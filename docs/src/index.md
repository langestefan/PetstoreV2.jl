```@meta
CurrentModule = PetstoreClient
```

# PetstoreClient.jl

Documentation for [PetstoreClient.jl](https://github.com/your-username/PetstoreClient.jl).

A Julia REST/JSON API wrapper scaffolded with
[OpenAPITemplate.jl](https://github.com/your-username/OpenAPITemplate.jl).

## Quick start

```julia
using PetstoreClient

client = Client("https://api.example.com"; auth = BearerToken(ENV["PETSTORECLIENT_TOKEN"]))
```

See the [Getting Started](getting_started.md) guide for a worked example, or
the [Julia API Reference](julia_reference.md) for the full surface.
