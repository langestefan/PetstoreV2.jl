using PetstoreV2
using Test

@testset "Error type hierarchy" begin
    @test PetstoreV2.NetworkError(ErrorException("dns")) isa PetstoreV2.APIError
    @test PetstoreV2.ClientError(404, "not found") isa PetstoreV2.APIError
    @test PetstoreV2.ServerError(500, "boom") isa PetstoreV2.APIError
    @test PetstoreV2.AuthError(401, "nope") isa PetstoreV2.APIError
    @test PetstoreV2.RateLimitError(; retry_after = 5.0) isa PetstoreV2.APIError
    @test PetstoreV2.TimeoutError(:read) isa PetstoreV2.APIError
end

@testset "parse_retry_after" begin
    @test PetstoreV2.parse_retry_after("5") == 5.0
    @test PetstoreV2.parse_retry_after(" 12 ") == 12.0
    @test PetstoreV2.parse_retry_after("Wed, 21 Oct 2015 07:28:00 GMT") === nothing
    @test PetstoreV2.parse_retry_after("") === nothing
    @test PetstoreV2.parse_retry_after(nothing) === nothing
end

@testset "check_response 2xx returns nothing" begin
    for s in (200, 201, 204, 299)
        @test PetstoreV2.check_response(s, "") === nothing
    end
end

@testset "check_response classifies by status" begin
    @test_throws PetstoreV2.AuthError PetstoreV2.check_response(401, "")
    @test_throws PetstoreV2.AuthError PetstoreV2.check_response(403, "")
    @test_throws PetstoreV2.ClientError PetstoreV2.check_response(404, "missing")
    @test_throws PetstoreV2.ServerError PetstoreV2.check_response(503, "")
    @test_throws PetstoreV2.ClientError PetstoreV2.check_response(600, "weird")
end

@testset "check_response 429 surfaces RateLimitError" begin
    headers = Dict("Retry-After" => "7")
    err = try
        PetstoreV2.check_response(429, "", headers)
        nothing
    catch e
        e
    end
    @test err isa PetstoreV2.RateLimitError
    @test err.retry_after == 7.0
end
