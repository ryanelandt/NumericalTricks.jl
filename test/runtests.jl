using Test
using NumericalTricks
using StaticArrays
using LinearAlgebra
using Rotations


include("test_exports.jl")


@testset "div_by_zero" begin
    sv3_zero = SVector{3,Float64}(0.0, 0.0, 0.0)
    @test sv3_zero == safe_normalize(sv3_zero)
    @test all(isnan.(unsafe_normalize(sv3_zero)))
    for k = 1:128
        rv = randn(SVector{3,Float64})
        rv_norm = norm(rv)
        rv_normalize = rv ./ rv_norm
        s_normalize = safe_normalize(rv)
        u_normalize = unsafe_normalize(rv)
        @test rv_normalize ≈ s_normalize
        @test rv_normalize ≈ u_normalize
        @test norm(s_normalize) ≈ 1.0
        @test norm(u_normalize) ≈ 1.0
        @test safe_inv_norm_squared(rv) ≈ (1 / rv_norm)^2
        @test norm_squared(rv) ≈ rv_norm^2
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
