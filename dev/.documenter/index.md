


# PetstoreV2.jl {#PetstoreV2.jl}

Documentation for [PetstoreV2.jl](https://github.com/langestefan/PetstoreV2.jl).

A Julia REST/JSON API wrapper scaffolded with [OpenAPITemplate.jl](https://github.com/langestefan/OpenAPITemplate.jl).

## Quick start {#Quick-start}

```julia
using PetstoreV2

client = Client("https://api.example.com"; auth = BearerToken(ENV["PETSTOREV2_TOKEN"]))
```


See the [Getting Started](getting_started.md) guide for a worked example, or the [Julia API Reference](julia_reference.md) for the full surface.
