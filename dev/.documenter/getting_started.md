
# Getting Started {#Getting-Started}

## Installation {#Installation}

```julia
using Pkg
Pkg.add("PetstoreV2")
```


## Constructing a Client {#Constructing-a-Client}

```julia
using PetstoreV2

client = Client("https://api.example.com"; auth = NoAuth())
```


Available auth strategies:

|                                                     Type |                                          When to use |
| --------------------------------------------------------:| ----------------------------------------------------:|
|           [`NoAuth`](/julia_reference#PetstoreV2.NoAuth) |                                          public APIs |
| [`BearerToken`](/julia_reference#PetstoreV2.BearerToken) |                         OAuth2/JWT bearer-token APIs |
|           [`APIKey`](/julia_reference#PetstoreV2.APIKey) | header-based API-key APIs (configurable header name) |
|     [`BasicAuth`](/julia_reference#PetstoreV2.BasicAuth) |                                      HTTP basic auth |


## Reliability primitives {#Reliability-primitives}

The hand-written overlay ships retry, rate-limit, and timeout helpers. Wrap a call to compose them:

```julia
result = with_retry(; policy = RetryPolicy(; max_attempts = 3)) do
    with_timeout(5.0) do
        # ... call a generated endpoint here ...
    end
end
```


## Pagination {#Pagination}

```julia
for item in paginate_offset((offset, limit) -> list_things(client; offset, limit))
    @show item
end
```


See [`paginate_cursor`](/julia_reference#PetstoreV2.paginate_cursor), [`paginate_offset`](/julia_reference#PetstoreV2.paginate_offset), [`paginate_pagenum`](/julia_reference#PetstoreV2.paginate_pagenum).
