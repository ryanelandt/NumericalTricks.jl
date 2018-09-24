function fastSoftPlus(x::T, k::Float64=1.0) where {T}
  # This function is designed to ALWAYS produce non-negative output
  (x <= -k) && (return zero(T))
  (k <= x) && (return x)
  return (k + x)^3 * (3*k - x) / (16*k^3)
end

function fastSigmoid(x::T) where {T}
  # This function assumes that x is non-negative.
  (0.16666666666666666 <= x) && (return one(T))
  x2 = x * x
  x3 = x * x2
  x5 = x3 * x2
  return 11.25 * x - 270.0 * x3 + 2916.0 * x5
end
