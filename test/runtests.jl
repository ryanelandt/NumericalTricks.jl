using Test
using NumericalTricks
using StaticArrays
using LinearAlgebra
using Rotations
using ForwardDiff: Partials, Dual, value


include("test_exports.jl")
include("test_div_by_zero.jl")


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
