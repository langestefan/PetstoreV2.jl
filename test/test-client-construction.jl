using PetstoreV2
using OpenAPI
using Test

@testset "Client construction" begin
    c = PetstoreV2.Client("https://example.test/api")
    @test c isa PetstoreV2.Client
    @test c.base_url == "https://example.test/api"
    @test c.auth isa PetstoreV2.NoAuth
    @test c.inner isa OpenAPI.Clients.Client
end

@testset "Client with auth" begin
    c = PetstoreV2.Client("https://example.test"; auth = PetstoreV2.BearerToken("abc"))
    @test c.auth isa PetstoreV2.BearerToken
    @test c.auth.token == "abc"
end
