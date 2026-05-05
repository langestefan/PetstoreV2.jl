using PetstoreV2
using Test

@testset "redact_headers strips secret values" begin
    headers = Dict("Authorization" => "Bearer secret",
                   "X-API-Key" => "topsecret",
                   "Content-Type" => "application/json")
    out = PetstoreV2.redact_headers(headers)
    @test out["Authorization"] == "[redacted]"
    @test out["X-API-Key"] == "[redacted]"
    @test out["Content-Type"] == "application/json"
end

@testset "redact_headers is case-insensitive" begin
    out = PetstoreV2.redact_headers(Dict("AUTHORIZATION" => "Bearer x",
                                      "cookie" => "abc"))
    @test out["AUTHORIZATION"] == "[redacted]"
    @test out["cookie"] == "[redacted]"
end

@testset "with_logging passes value through" begin
    @test PetstoreV2.with_logging(() -> 42) == 42
end

@testset "with_logging rethrows" begin
    @test_throws ErrorException PetstoreV2.with_logging(() -> error("boom"))
end

@testset "default_middleware composes retry + rate-limit + timeout" begin
    attempts = Ref(0)
    bucket = PetstoreV2.TokenBucket(; rate = 100.0, burst = 10.0)
    mw = PetstoreV2.default_middleware(;
        retry = PetstoreV2.RetryPolicy(; max_attempts = 3, base_delay = 0.0,
                                      max_delay = 0.0),
        rate_limit = bucket,
        timeout = 1.0,
        log_label = "test",
    )
    result = PetstoreV2.with_defaults(mw) do
        attempts[] += 1
        attempts[] < 2 && throw(PetstoreV2.RateLimitError(; status = 429))
        return :ok
    end
    @test result === :ok
    @test attempts[] == 2
end

@testset "with_defaults respects nothing-disabled links" begin
    # No retry, no rate-limit, no timeout, no log — pure pass-through.
    mw = PetstoreV2.DefaultMiddleware(; retry = nothing, rate_limit = nothing,
                                    timeout = nothing, log_label = nothing)
    @test PetstoreV2.with_defaults(() -> :passthrough, mw) === :passthrough
end
