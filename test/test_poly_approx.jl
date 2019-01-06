
@testset "fastSigmoid" begin
    for TYPE_k = (Float64, Dual{Nothing,Float64,12})
        x_cut⁻¹ = 1.0
        out = fastSigmoid(TYPE_k( 0.0), x_cut⁻¹)
        @test zero(TYPE_k) == out
        @test typeof(out) == TYPE_k

        out = fastSigmoid(TYPE_k( 1.0), x_cut⁻¹)
        @test  one(TYPE_k) == out
        @test typeof(out) == TYPE_k

        out = fastSigmoid(TYPE_k(-1.0), x_cut⁻¹)
        @test -one(TYPE_k) == out
        @test typeof(out) == TYPE_k

        out = fastSigmoid(TYPE_k( 0.5), x_cut⁻¹)
        @test zero(TYPE_k) < out < one(TYPE_k)
        @test typeof(out) == TYPE_k

        out = fastSigmoid(TYPE_k(-0.5), x_cut⁻¹)
        @test -one(TYPE_k) < out < zero(TYPE_k)
        @test typeof(out) == TYPE_k
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
