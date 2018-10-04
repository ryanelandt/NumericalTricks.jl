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

function soft_clamp(x::T, bound::T) where {T}
    # using LinearAlgebra
    # using SymPy
    #
    # @syms x a0 a1 a2 a3 a4 a5 real=true
    #
    # p_0 = a0 + a1*x + a2*x^2 + a3*x^3 + a4*x^4 + a5*x^5
    # p_1 = diff(p_0, x, 1)
    # p_2 = diff(p_1, x, 1)
    #
    # e1 = subs(p_0 - 1//2, x, 1//2)
    # e2 = subs(p_1 - 1, x, 1//2)
    # e3 = subs(p_2 - 0, x, 1//2)
    #
    # e4 = subs(p_0 - 1, x, 3//2)
    # e5 = subs(p_1 - 0, x, 3//2)
    # e6 = subs(p_2 - 0, x, 3//2)
    #
    # A,B = SymPy.sympy["linear_eq_to_matrix"]([e1, e2, e3, e4, e5, e6], a0, a1, a2, a3, a4, a5)
    # c = A \ B
    #
    # p = dot(c, [x^k for k = 0:5])
    # println("    poly = ", p)
    x̄ = safe_scalar_divide(x, bound)
    return soft_clamp_normalized(x̄, x, bound)
end

function soft_clamp_normalized(x̄::T, x::T, bound::T) where {T}
    (x̄ < 0) && return -soft_clamp_normalized(-x̄, -x, bound)
    (1.5 <= x̄) && (return bound)
    (x̄ <= 0.5) && (return x)
    x2 = x̄ * x̄
    poly = x2 * (x2 * 0.5 - 2 * x̄ + Float64(9/4)) + Float64(5/32)
    return bound * poly
  end
