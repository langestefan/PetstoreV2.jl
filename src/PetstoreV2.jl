module PetstoreV2

using HTTP, JSON, OpenAPI

# Generated low-level surface — DO NOT EDIT, regenerate via gen/regenerate.jl
include("api/PetstoreV2API.jl")
using .PetstoreV2API

# Re-export every public name from the generated module so users don't have to
# qualify with `PetstoreV2API.`.
for n in names(PetstoreV2API; all = false)
    n === Symbol("PetstoreV2API") && continue
    @eval export $n
end

# Hand-written ergonomic surface
include("client/auth.jl")
include("client/errors.jl")
include("client/logging.jl")
include("client/retry.jl")
include("client/rate_limit.jl")
include("client/timeout.jl")
include("client/middleware.jl")
include("client/Client.jl")
include("client/pagination.jl")
include("client/show.jl")

export Client, Auth, NoAuth, BearerToken, APIKey, BasicAuth, resolve_credentials
export APIError, NetworkError, ClientError, ServerError, AuthError,
    RateLimitError, TimeoutError, check_response
export RetryPolicy, with_retry
export TokenBucket, acquire!, with_rate_limit
export with_timeout
export with_logging, redact_headers
export DefaultMiddleware, default_middleware, with_defaults
export paginate_cursor, paginate_offset, paginate_pagenum

end # module
