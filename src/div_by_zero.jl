# safeNorm(v::SVector{3,T}) where {T} = sqrt(dot(v, v) + 1.0e-66)
# safeInvNorm(v::SVector{3,T}) where {T} = 1 / safeNorm(v)
# safeNormalize(v::SVector{3,T}) where {T} = v * safeInvNorm(v)

function safeNormalize(v::SVector{3,Float64})
    n2 = muladd(v[1], v[1], 1.0e-66)
    n2 = muladd(v[2], v[2], n2)
    n2 = muladd(v[3], v[3], n2)
    return v * (1 / sqrt(n2))
end
function safeNormalize(v::SVector{3,Dual{Float64,Float64,N}}) where N
    n2 = v[1]^2
    n2 = muladd(v[2], v[2], n2)
    n2 = muladd(v[3], v[3], n2)
    if n2 != 0.0
        return v * (1 / sqrt(n2))
    else
        return v
    end
end
