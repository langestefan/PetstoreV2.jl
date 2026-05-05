using PetstoreClient
using Test

@testset "with_timeout returns fast result" begin
    @test PetstoreClient.with_timeout(() -> 42, 1.0) == 42
end

@testset "with_timeout with Inf is a pass-through" begin
    @test PetstoreClient.with_timeout(() -> "ok", Inf) == "ok"
end

@testset "with_timeout throws TimeoutError when slow" begin
    err = nothing
    try
        PetstoreClient.with_timeout(() -> (sleep(0.5); :late), 0.05; phase = :read)
    catch e
        err = e
    end
    @test err isa PetstoreClient.TimeoutError
    @test err.phase === :read
end

@testset "with_timeout rethrows fn errors" begin
    @test_throws ErrorException PetstoreClient.with_timeout(() -> error("boom"), 1.0)
end
