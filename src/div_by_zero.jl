# safeNorm(v::SVector{3,T}) where {T} = sqrt(dot(v, v) + 1.0e-66)
# safeInvNorm(v::SVector{3,T}) where {T} = 1 / safeNorm(v)
# safeNormalize(v::SVector{3,T}) where {T} = v * safeInvNorm(v)

function safe_normalize(v::SVector{3,Float64})
    n2 = muladd(v[1], v[1], 1.0e-66)
    n2 = muladd(v[2], v[2], n2)
    n2 = muladd(v[3], v[3], n2)
    return v * (1 / sqrt(n2))
end

@inline function norm_squared(v::SVector{3,T}) where T
    n2 = v[1]^2
    n2 = muladd(v[2], v[2], n2)
    n2 = muladd(v[3], v[3], n2)
    return n2
end

function safe_normalize(v::SVector{3,Dual{Float64,Float64,N}}) where N
    n2 = norm_squared(v)
    if n2 != 0.0
        return v * (1 / sqrt(n2))
    else
        return v
    end
end

function safe_inv_norm_squared(v::SVector{3,T}) where {T}
    n2 = norm_squared(v)
    return ifelse(n2 == 0.0, 0.0, 1 / n2)
end

function safe_scalar_divide(a::T, b::T) where {T}
    (b != 0.0) && (return a / b)
    (a == 0.0) && (return zero(T))
    error("attempted to divide non-zero $a by zero $b you should not do this")
end
