vec_proj(vec_in::SVector{3, TD}, n̂::SVector{3,TD}) where {TD} = n̂ * dot(n̂, vec_in)
vec_sub_vec_proj(vec_in::SVector{3, TD}, normal_in::SVector{3,TD}) where {TD} = vec_in - vec_proj(vec_in, normal_in)
