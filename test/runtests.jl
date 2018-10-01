using Test
using NumericalTricks
using StaticArrays
using LinearAlgebra
using Rotations


include("test_exports.jl")


@testset "div_by_zero" begin
    sv3_zero = SVector{3,Float64}(0.0, 0.0, 0.0)
    @test sv3_zero == safe_normalize(sv3_zero)
    for k = 1:127
        rv = randn(SVector{3,Float64})
        @test norm(safe_normalize(rv)) ≈ 1.0
        @test safe_inv_norm_2(rv) ≈ (1 / norm(rv))^2
        # norm_rv = norm(rv)
        # @test safeNorm(rv) ≈ norm_rv
        # @test safeInvNorm(rv) ≈ 1 / norm_rv
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


@testset "rotations" begin
    qq = Quat(1.0, 0.01, 0.02, 0.03)
    rv = RodriguesVec(qq)
    rv_sv = SVector(rv.sx, rv.sy, rv.sz)
    rv_cheap = cheapRV(qq)
    rel_err = (rv_sv - rv_cheap) ./ rv_sv
    @test all(rel_err .< 1.0e-3)
end
