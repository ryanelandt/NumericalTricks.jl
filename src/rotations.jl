quatErr(q_err::Quat{TD}) where {TD} = (0 <= q_err.w) ? SVector( q_err.x,  q_err.y,  q_err.z) : SVector(-q_err.x, -q_err.y, -q_err.z)

function quatErr(q1::Quat{TD}, qRef::Quat{TD}) where {TD}
  q_err = q1 * inv(qRef)
  return quatErr(q_err)
end

cheapRV(q::Quat) = 2 * quatErr(q)
cheapRV(spq::SPQuat) = cheapRV(Quat(spq))
