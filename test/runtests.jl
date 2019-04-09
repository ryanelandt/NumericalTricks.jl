using Test
using NumericalTricks
using StaticArrays
using LinearAlgebra
using Rotations
using ForwardDiff: Partials, Dual, value


include("test_exports.jl")
include("test_div_by_zero.jl")
# include("test_matrix_factor_derivatives.jl")
include("test_basic_dh.jl")
include("test_geometry_kernel.jl")
include("test_poly_approx.jl")
include("test_utility.jl")


@testset "3_of_6" begin
    a = SVector{6,Float64}(1,2,3,4,5,6)
    @test all(first_3_of_6(a) .== SVector{3,Float64}(1,2,3))
    @test all(last_3_of_6(a) .== SVector{3,Float64}(4,5,6))
end

@testset "rotations" begin
    qq = Quat(1.0, 0.01, 0.02, 0.03)
    rv = RodriguesVec(qq)
    rv_sv = SVector(rv.sx, rv.sy, rv.sz)
    rv_cheap = cheapRV(qq)
    rel_err = (rv_sv - rv_cheap) ./ rv_sv
    @test all(rel_err .< 1.0e-3)
end
