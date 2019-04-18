vec_proj(vec_in::SVector{3, TD}, n̂::SVector{3,TD}) where {TD} = n̂ * dot(n̂, vec_in)
# vec_sub_vec_proj(vec_in::SVector{3, TD}, normal_in::SVector{3,TD}) where {TD} = vec_in - vec_proj(vec_in, normal_in)
function vec_sub_vec_proj(v::SVector{3,T}, n̂::SVector{3,T}) where T
	t = -dot(v, n̂)
	return SVector{3,T}(muladd(t, n̂[1], v[1]),
						muladd(t, n̂[2], v[2]),
						muladd(t, n̂[3], v[3]))
end
