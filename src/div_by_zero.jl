safeNorm(v::SVector{3,T}) where {T} = sqrt(dot(v, v) + 1.0e-66)
safeInvNorm(v::SVector{3,T}) where {T} = 1 / safeNorm(v)
safeNormalize(v::SVector{3,T}) where {T} = v * safeInvNorm(v)
