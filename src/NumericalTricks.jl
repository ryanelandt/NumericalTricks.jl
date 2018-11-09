__precompile__(true)

module NumericalTricks

using StaticArrays
using LinearAlgebra
using Rotations
using ForwardDiff: Dual, value


include("poly_approx.jl")
include("div_by_zero.jl")
include("rotations.jl")
include("vector_projections.jl")
include("matrix_factor_derivatives.jl")

export
  # poly_approx.jl
  fastSoftPlus,
  fastSigmoid,
  soft_clamp,

  # div_by_zero.jl
  safe_normalize,
  unsafe_normalize,
  safe_inv_norm_squared,
  safe_inv_norm,
  safe_norm,
  norm_squared,
  safe_scalar_divide,
  unsafe_norm,
  unsafe_inv_norm,

  # rotations.jl
  quatErr,
  cheapRV,
  components,

  # vector_projections.jl
  vec_proj,
  vec_sub_vec_proj,

  # matrix_factor_derivatives.jl
  cholesky_U_deravitive

end
