using PetstoreClient
using Test

const _NO_SLEEP = (_::Real) -> nothing
const _ONE_JITTER = () -> 1.0

@testset "with_retry returns first success" begin
    calls = Ref(0)
    result = PetstoreClient.with_retry(; sleep_fn = _NO_SLEEP) do
        calls[] += 1
        :ok
    end
    @test result === :ok
    @test calls[] == 1
end

@testset "with_retry retries on retryable status then succeeds" begin
    attempts = Ref(0)
    sleeps = Float64[]
    sink(d) = push!(sleeps, d)
    result = PetstoreClient.with_retry(;
        policy = PetstoreClient.RetryPolicy(; max_attempts = 4, base_delay = 1.0),
        sleep_fn = sink,
        jitter = _ONE_JITTER,
    ) do
        attempts[] += 1
        attempts[] < 3 && throw(PetstoreClient.ServerError(503, "down"))
        :recovered
    end
    @test result === :recovered
    @test attempts[] == 3
    @test sleeps == [1.0, 2.0]
end

@testset "with_retry exhausts attempts then rethrows" begin
    attempts = Ref(0)
    @test_throws PetstoreClient.ServerError PetstoreClient.with_retry(;
        policy = PetstoreClient.RetryPolicy(; max_attempts = 3, base_delay = 0.01),
        sleep_fn = _NO_SLEEP,
        jitter = _ONE_JITTER,
    ) do
        attempts[] += 1
        throw(PetstoreClient.ServerError(503, "down"))
    end
    @test attempts[] == 3
end

@testset "with_retry skips non-retryable status" begin
    attempts = Ref(0)
    @test_throws PetstoreClient.ClientError PetstoreClient.with_retry(; sleep_fn = _NO_SLEEP) do
        attempts[] += 1
        throw(PetstoreClient.ClientError(404, "missing"))
    end
    @test attempts[] == 1
end

@testset "RateLimitError honors Retry-After when longer than backoff" begin
    attempts = Ref(0)
    sleeps = Float64[]
    sink(d) = push!(sleeps, d)
    PetstoreClient.with_retry(;
        policy = PetstoreClient.RetryPolicy(; max_attempts = 3, base_delay = 0.1),
        sleep_fn = sink,
        jitter = _ONE_JITTER,
    ) do
        attempts[] += 1
        attempts[] < 3 && throw(PetstoreClient.RateLimitError(; retry_after = 5.0))
        :ok
    end
    @test all(>=(5.0), sleeps)
end

@testset "is_retryable defaults" begin
    p = PetstoreClient.RetryPolicy()
    @test PetstoreClient.is_retryable(p, PetstoreClient.NetworkError(ErrorException("x")))
    @test PetstoreClient.is_retryable(p, PetstoreClient.ServerError(503, ""))
    @test !PetstoreClient.is_retryable(p, PetstoreClient.ClientError(404, ""))
    @test PetstoreClient.is_retryable(p, PetstoreClient.RateLimitError())
    @test PetstoreClient.is_retryable(p, PetstoreClient.TimeoutError(:read))
    @test !PetstoreClient.is_retryable(p, ErrorException("not an APIError"))
end

@testset "non-APIError is not retried" begin
    attempts = Ref(0)
    @test_throws ErrorException PetstoreClient.with_retry(; sleep_fn = _NO_SLEEP) do
        attempts[] += 1
        error("boom")
    end
    @test attempts[] == 1
end
