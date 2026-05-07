# Julia API Reference

```@meta
CurrentModule = PetstoreV2
```

## Client

```@docs
Client
```

## Auth

```@docs
Auth
NoAuth
BearerToken
APIKey
BasicAuth
resolve_credentials
PetstoreV2.apply!
PetstoreV2.build_pre_request_hook
```

## Errors

```@docs
APIError
NetworkError
ClientError
ServerError
AuthError
RateLimitError
TimeoutError
check_response
PetstoreV2.parse_retry_after
```

## Reliability

```@docs
RetryPolicy
with_retry
PetstoreV2.is_retryable
PetstoreV2.backoff_delay
TokenBucket
acquire!
with_rate_limit
with_timeout
with_logging
redact_headers
DefaultMiddleware
default_middleware
with_defaults
```

## Pagination

```@docs
paginate_cursor
paginate_offset
paginate_pagenum
```

## Pretty printing

```@docs
Base.show(::IO, ::MIME"text/plain", ::T) where T <: OpenAPI.APIModel
```
