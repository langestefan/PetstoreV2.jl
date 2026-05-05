using PetstoreClient
using Test

@testset "Error type hierarchy" begin
    @test PetstoreClient.NetworkError(ErrorException("dns")) isa PetstoreClient.APIError
    @test PetstoreClient.ClientError(404, "not found") isa PetstoreClient.APIError
    @test PetstoreClient.ServerError(500, "boom") isa PetstoreClient.APIError
    @test PetstoreClient.AuthError(401, "nope") isa PetstoreClient.APIError
    @test PetstoreClient.RateLimitError(; retry_after = 5.0) isa PetstoreClient.APIError
    @test PetstoreClient.TimeoutError(:read) isa PetstoreClient.APIError
end

@testset "parse_retry_after" begin
    @test PetstoreClient.parse_retry_after("5") == 5.0
    @test PetstoreClient.parse_retry_after(" 12 ") == 12.0
    @test PetstoreClient.parse_retry_after("Wed, 21 Oct 2015 07:28:00 GMT") === nothing
    @test PetstoreClient.parse_retry_after("") === nothing
    @test PetstoreClient.parse_retry_after(nothing) === nothing
end

@testset "check_response 2xx returns nothing" begin
    for s in (200, 201, 204, 299)
        @test PetstoreClient.check_response(s, "") === nothing
    end
end

@testset "check_response classifies by status" begin
    @test_throws PetstoreClient.AuthError PetstoreClient.check_response(401, "")
    @test_throws PetstoreClient.AuthError PetstoreClient.check_response(403, "")
    @test_throws PetstoreClient.ClientError PetstoreClient.check_response(404, "missing")
    @test_throws PetstoreClient.ServerError PetstoreClient.check_response(503, "")
    @test_throws PetstoreClient.ClientError PetstoreClient.check_response(600, "weird")
end

@testset "check_response 429 surfaces RateLimitError" begin
    headers = Dict("Retry-After" => "7")
    err = try
        PetstoreClient.check_response(429, "", headers)
        nothing
    catch e
        e
    end
    @test err isa PetstoreClient.RateLimitError
    @test err.retry_after == 7.0
end
