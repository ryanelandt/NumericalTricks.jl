
function safe_normalize(v::SVector{3,Float64})
    n2 = muladd(v[1], v[1], 1.0e-66)
    n2 = muladd(v[2], v[2], n2)
    n2 = muladd(v[3], v[3], n2)
    return v * (1 / sqrt(n2))
end

function norm_squared(v::SVector{3,T}) where T
    n2 = v[1]^2
    n2 = muladd(v[2], v[2], n2)
    n2 = muladd(v[3], v[3], n2)
    return n2
end

safe_norm(v::SVector{3,Float64}) = sqrt(norm_squared(v))
function safe_norm(v::SVector{3,T}) where {T}
    n2 = norm_squared(v)
    return (n2 != 0.0) ? sqrt(n2) : zero(T)
end

function safe_normalize(v::SVector{3,Dual{Type_Tag,Float64,N}}) where {Type_Tag, N}
    n2 = norm_squared(v)
    return (n2 != 0.0) ? v * (1 / sqrt(n2)) : v
end

@inline function unsafe_normalize(v::SVector{3,Float64})
    n2 = norm_squared(v)
    inv_n2 = 1 / sqrt(n2)
    return v * inv_n2
end

function unsafe_normalize(v::SVector{3,Dual{Type_Tag,Float64,N}}) where {Type_Tag, N}
    n2 = norm_squared(v)
    inv_n2 = 1 / sqrt(n2)
    return v * inv_n2
end

function safe_inv_norm_squared(v::SVector{3,T}) where {T}
    n2 = norm_squared(v)
    return ifelse(n2 == 0.0, 0.0, 1 / n2)
end

function safe_inv_norm(v::SVector{3,T}) where {T}
    n2 = norm(v)
    return ifelse(n2 == 0.0, 0.0, 1 / n2)
end

function safe_scalar_divide(a::T, b::T) where {T}
    (b != 0.0) && (return a / b)
    (a == 0.0) && (return zero(T))
    error("attempted to divide non-zero $a by zero $b you should not do this")
end
