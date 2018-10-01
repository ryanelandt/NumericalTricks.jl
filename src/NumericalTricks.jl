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

  # div_by_zero.jl
  # safeNorm,
  # safeInvNorm,
  safe_normalize,
  safe_inv_norm_2,

  # rotations.jl
  quatErr,
  cheapRV

end
