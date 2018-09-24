using Test
using NumericalTricks
using StaticArrays
using LinearAlgebra


@testset "div_by_zero" begin
    sv3_zero = SVector{3,Float64}(0.0, 0.0, 0.0)
    @test sv3_zero == safeNormalize(sv3_zero)
    for k = 1:128
        rv = randn(SVector{3,Float64})
        @test norm(safeNormalize(rv)) ≈ 1.0
        norm_rv = norm(rv)
        @test safeNorm(rv) ≈ norm_rv
        @test safeInvNorm(rv) ≈ 1 / norm_rv
    end
end


@testset "poly_approx" begin
    # fastSoftPlus
    for center_value = [0.1, 0.25, 0.5, 1.0, 2.0]
        p = 1.0e-14
        x = center_value * LinRange(-1.0 - p, -1.0 + p, 1001)
        y = fastSoftPlus.(x, center_value)
        @test 0.0 == minimum(y)
    end
end
