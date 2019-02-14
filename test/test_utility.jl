
@testset "utility" begin
    p1 = SVector{3,Float64}(1.0, 2.0, 3.0)
    p2 = SVector{3,Float64}(2.0, 3.0, 4.0)
    @test p2 == weightPoly(p1, p2, 1.0, 0.0)
    @test p1 == weightPoly(p1, p2, 0.0, 1.0)
    @test (p1 + p2) * 0.5 == weightPoly(p1, p2, -0.7, 0.7)

    p, d = make_pd_gains(2*pi, 1.0)
    @test p == 1.0
    @test d == 2.0
    p, d = make_pd_gains(1*pi, 1.0)
    @test p == 4.0
    @test d == 4.0
end
