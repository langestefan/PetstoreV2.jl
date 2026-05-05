
# Julia API Reference {#Julia-API-Reference}



## Client {#Client}
<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.Client' href='#PetstoreV2.Client'><span class="jlbinding">PetstoreV2.Client</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
Client(base_url::AbstractString; auth::Auth = NoAuth(), kwargs...)
```


Ergonomic wrapper around `OpenAPI.Clients.Client`. Composes an [`Auth`](/julia_reference#Auth) strategy into the inner client&#39;s `pre_request_hook`. Extra `kwargs` are forwarded verbatim to `OpenAPI.Clients.Client`.

For retry / rate-limit / timeout / logging, compose the call with [`with_defaults`](/julia_reference#PetstoreV2.with_defaults) or [`default_middleware`](/julia_reference#PetstoreV2.default_middleware) — the `Client` itself stays minimal so users can pick their own stack per call.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/Client.jl#L1-L11" target="_blank" rel="noreferrer">source</a></Badge>

</details>


## Auth {#Auth}
<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.Auth' href='#PetstoreV2.Auth'><span class="jlbinding">PetstoreV2.Auth</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
Auth
```


Abstract supertype for authentication strategies. Concrete subtypes are applied to outgoing requests via `apply!` and composed into a `pre_request_hook` for `OpenAPI.Clients.Client` by `build_pre_request_hook`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/auth.jl#L4-L10" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.NoAuth' href='#PetstoreV2.NoAuth'><span class="jlbinding">PetstoreV2.NoAuth</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
NoAuth()
```


Pass-through auth: leaves request headers untouched.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/auth.jl#L13-L17" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.BearerToken' href='#PetstoreV2.BearerToken'><span class="jlbinding">PetstoreV2.BearerToken</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
BearerToken(token)
```


Sets `Authorization: Bearer <token>`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/auth.jl#L20-L24" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.APIKey' href='#PetstoreV2.APIKey'><span class="jlbinding">PetstoreV2.APIKey</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
APIKey(key; header="X-API-Key")
```


Sets `<header>: <key>`. Works for any header-based API-key scheme.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/auth.jl#L29-L33" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.BasicAuth' href='#PetstoreV2.BasicAuth'><span class="jlbinding">PetstoreV2.BasicAuth</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
BasicAuth(username, password)
```


Sets `Authorization: Basic <base64(user:pass)>`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/auth.jl#L41-L45" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.apply!' href='#PetstoreV2.apply!'><span class="jlbinding">PetstoreV2.apply!</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
apply!(auth::Auth, headers::Dict{String,String}) -> Nothing
```


Inject credentials into the outgoing request headers.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/auth.jl#L51-L55" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.build_pre_request_hook' href='#PetstoreV2.build_pre_request_hook'><span class="jlbinding">PetstoreV2.build_pre_request_hook</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
build_pre_request_hook(auth) -> Function
```


Build the `pre_request_hook` accepted by `OpenAPI.Clients.Client`. The hook implements both required signatures: a `Ctx`-only pass-through and a `(resource, body, headers)` form that calls `apply!` on `auth`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/auth.jl#L74-L80" target="_blank" rel="noreferrer">source</a></Badge>

</details>


## Errors {#Errors}
<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.APIError' href='#PetstoreV2.APIError'><span class="jlbinding">PetstoreV2.APIError</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
APIError
```


Abstract supertype for all errors raised by this client.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/errors.jl#L1-L5" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.NetworkError' href='#PetstoreV2.NetworkError'><span class="jlbinding">PetstoreV2.NetworkError</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
NetworkError(cause)
```


Wraps an underlying transport-layer exception (DNS failure, connection reset, TLS handshake error, etc.).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/errors.jl#L8-L13" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.ClientError' href='#PetstoreV2.ClientError'><span class="jlbinding">PetstoreV2.ClientError</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
ClientError(status, body, parsed=nothing)
```


A 4xx response — caller error. `parsed` may be `nothing` or the JSON-decoded body, depending on `Content-Type`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/errors.jl#L18-L23" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.ServerError' href='#PetstoreV2.ServerError'><span class="jlbinding">PetstoreV2.ServerError</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
ServerError(status, body, parsed=nothing)
```


A 5xx response — server-side failure.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/errors.jl#L31-L35" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.AuthError' href='#PetstoreV2.AuthError'><span class="jlbinding">PetstoreV2.AuthError</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
AuthError(status, message)
```


A 401 / 403 response — authentication or authorization failure.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/errors.jl#L43-L47" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.RateLimitError' href='#PetstoreV2.RateLimitError'><span class="jlbinding">PetstoreV2.RateLimitError</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
RateLimitError(status=429; retry_after=nothing, body="")
```


A 429 response. `retry_after` is the parsed `Retry-After` header value in seconds, or `nothing` when absent / unparsable.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/errors.jl#L53-L58" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.TimeoutError' href='#PetstoreV2.TimeoutError'><span class="jlbinding">PetstoreV2.TimeoutError</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
TimeoutError(phase::Symbol)
```


Request exceeded the configured timeout. `phase` is `:connect`, `:read`, or `:total`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/errors.jl#L67-L72" target="_blank" rel="noreferrer">source</a></Badge>

</details>


## Reliability {#Reliability}
<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.RetryPolicy' href='#PetstoreV2.RetryPolicy'><span class="jlbinding">PetstoreV2.RetryPolicy</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
RetryPolicy(; max_attempts=5,
              base_delay=0.5,
              max_delay=30.0,
              retryable_statuses=DEFAULT_RETRYABLE_STATUSES,
              retry_on_network_error=true)
```


Exponential-backoff-with-full-jitter retry configuration. Used by [`with_retry`](/julia_reference#PetstoreV2.with_retry).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/retry.jl#L3-L12" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.with_retry' href='#PetstoreV2.with_retry'><span class="jlbinding">PetstoreV2.with_retry</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
with_retry(fn; policy=RetryPolicy(), sleep_fn=Base.sleep, jitter=rand) -> Any
```


Run `fn()` under the retry policy. Returns the first non-retryable result. For `RateLimitError`, the longer of `backoff_delay` and the server-supplied `retry_after` is used. `sleep_fn` and `jitter` are injectable so tests can avoid real sleeps and assert exact delays.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/retry.jl#L67-L74" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.TokenBucket' href='#PetstoreV2.TokenBucket'><span class="jlbinding">PetstoreV2.TokenBucket</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
TokenBucket(; rate=10.0, burst=10.0)
```


Token-bucket rate limiter. `rate` is tokens added per second; `burst` is the maximum reservoir size (and the initial fill).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/rate_limit.jl#L1-L6" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.acquire!' href='#PetstoreV2.acquire!'><span class="jlbinding">PetstoreV2.acquire!</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
acquire!(bucket; tokens=1.0, timeout=Inf, sleep_fn=Base.sleep, time_fn=time)
```


Block until `tokens` tokens are available, or throw [`RateLimitError`](/julia_reference#PetstoreV2.RateLimitError) if the wait would exceed `timeout` seconds. `time_fn` and `sleep_fn` are injectable for testing.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/rate_limit.jl#L23-L29" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.with_rate_limit' href='#PetstoreV2.with_rate_limit'><span class="jlbinding">PetstoreV2.with_rate_limit</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
with_rate_limit(bucket, fn; kwargs...) -> Any
```


Acquire from `bucket` then run `fn()`. Extra kwargs are forwarded to [`acquire!`](/julia_reference#PetstoreV2.acquire!).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/rate_limit.jl#L63-L68" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.with_timeout' href='#PetstoreV2.with_timeout'><span class="jlbinding">PetstoreV2.with_timeout</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
with_timeout(fn, seconds; phase=:total) -> Any
```


Run `fn()` on a background task; throw [`TimeoutError`](/julia_reference#PetstoreV2.TimeoutError)`(phase)` if it doesn&#39;t complete within `seconds`. `seconds = Inf` disables the timeout.

::: warning Warning

Julia cannot forcibly cancel a running task, so the underlying work may continue past the timeout. For HTTP calls, prefer the transport-layer `connect_timeout` / `readtimeout` exposed by `OpenAPI.Clients.Client`.

:::


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/timeout.jl#L1-L11" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.with_logging' href='#PetstoreV2.with_logging'><span class="jlbinding">PetstoreV2.with_logging</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
with_logging(fn; level=Logging.Info, label="api-call") -> Any
```


Wrap `fn()` in begin/end log records at `level`. Captures the elapsed time and outcome (`:ok` / `:error`); re-throws any exception unchanged. Useful as the outermost link in a [`default_middleware`](/julia_reference#PetstoreV2.default_middleware) stack.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/logging.jl#L22-L28" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.redact_headers' href='#PetstoreV2.redact_headers'><span class="jlbinding">PetstoreV2.redact_headers</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
redact_headers(headers) -> Dict{String,String}
```


Return a copy of `headers` with values for sensitive entries replaced by `"[redacted]"`. Header names are matched case-insensitively. Used by [`with_logging`](/julia_reference#PetstoreV2.with_logging); also useful when surfacing headers in error messages.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/logging.jl#L6-L13" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.DefaultMiddleware' href='#PetstoreV2.DefaultMiddleware'><span class="jlbinding">PetstoreV2.DefaultMiddleware</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
DefaultMiddleware(; retry, rate_limit, timeout, log_label)
```


Bundle of reliability primitives composed by [`default_middleware`](/julia_reference#PetstoreV2.default_middleware) and [`with_defaults`](/julia_reference#PetstoreV2.with_defaults). Each field is `nothing` to disable that link in the chain.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/middleware.jl#L1-L7" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.default_middleware' href='#PetstoreV2.default_middleware'><span class="jlbinding">PetstoreV2.default_middleware</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
default_middleware(; kwargs...) -> DefaultMiddleware
```


Build a sensible reliability stack. Forward to [`with_defaults`](/julia_reference#PetstoreV2.with_defaults) to execute a callable under it.

```julia
mw = default_middleware(; rate_limit = TokenBucket(; rate = 5, burst = 10),
                         timeout = 10.0)
result = with_defaults(mw) do
    list_pets(client)
end
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/middleware.jl#L15-L28" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.with_defaults' href='#PetstoreV2.with_defaults'><span class="jlbinding">PetstoreV2.with_defaults</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
with_defaults(fn, mw::DefaultMiddleware) -> Any
with_defaults(fn; kwargs...) -> Any
```


Run `fn()` under the configured middleware stack. Order, top-down:
1. Logging (outermost — sees all attempts and outcomes)
  
2. Retry (re-runs everything below on retryable errors)
  
3. Rate limit (waits for a token)
  
4. Timeout (innermost — bounds a single attempt)
  

Disable any link by setting it to `nothing`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/middleware.jl#L31-L43" target="_blank" rel="noreferrer">source</a></Badge>

</details>


## Pagination {#Pagination}
<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.paginate_cursor' href='#PetstoreV2.paginate_cursor'><span class="jlbinding">PetstoreV2.paginate_cursor</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
paginate_cursor(fetch_fn; channel_size=0) -> Channel
```


Lazy iterator over a cursor-paginated API. `fetch_fn(cursor)` must return `(items, next_cursor)` where `items` is iterable and `next_cursor === nothing` signals the end of pagination.

```julia
for user in paginate_cursor(c -> list_users(client; cursor=c))
    @show user.id
end
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/pagination.jl#L1-L13" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.paginate_offset' href='#PetstoreV2.paginate_offset'><span class="jlbinding">PetstoreV2.paginate_offset</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
paginate_offset(fetch_fn; page_size=50, start=0, channel_size=0) -> Channel
```


Lazy iterator over an offset-paginated API. `fetch_fn(offset, limit)` must return an iterable of items. Iteration stops on the first short page (fewer items than `page_size`).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/pagination.jl#L27-L33" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='PetstoreV2.paginate_pagenum' href='#PetstoreV2.paginate_pagenum'><span class="jlbinding">PetstoreV2.paginate_pagenum</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
paginate_pagenum(fetch_fn; start=1, channel_size=0) -> Channel
```


Lazy iterator over a page-number-paginated API. `fetch_fn(page)` must return an iterable of items. Iteration stops on the first empty page.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/langestefan/PetstoreV2.jl/blob/bf34bbbb9c5402aab3a49bcf53a6498fdb6cb676/src/client/pagination.jl#L48-L53" target="_blank" rel="noreferrer">source</a></Badge>

</details>

