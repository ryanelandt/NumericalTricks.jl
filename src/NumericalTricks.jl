__precompile__(true)

module NumericalTricks

using StaticArrays
using LinearAlgebra
using Rotations
using ForwardDiff: Dual


include("poly_approx.jl")
include("div_by_zero.jl")
include("rotations.jl")

export
  # poly_approx.jl
  fastSoftPlus,
  fastSigmoid,
  soft_clamp,

  # div_by_zero.jl
  safe_normalize,
  safe_inv_norm_squared,
  norm_squared,
  safe_scalar_divide,

  # rotations.jl
  quatErr,
  cheapRV

end
