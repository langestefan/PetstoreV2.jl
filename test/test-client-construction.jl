using PetstoreClient
using OpenAPI
using Test

@testset "Client construction" begin
    c = PetstoreClient.Client("https://example.test/api")
    @test c isa PetstoreClient.Client
    @test c.base_url == "https://example.test/api"
    @test c.auth isa PetstoreClient.NoAuth
    @test c.inner isa OpenAPI.Clients.Client
end

@testset "Client with auth" begin
    c = PetstoreClient.Client("https://example.test"; auth = PetstoreClient.BearerToken("abc"))
    @test c.auth isa PetstoreClient.BearerToken
    @test c.auth.token == "abc"
end
