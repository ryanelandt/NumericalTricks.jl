
@testset "vector projections" begin
    n̂  = SVector{3,Float64}(0, 0, 1)
    v1 = SVector{3,Float64}(1, 0, 0)
    v2 = SVector{3,Float64}(0, 1, 1)

    @test vec_proj(v1, n̂) == 0.0 * n̂
    @test vec_proj(n̂, n̂) == 1.0 * n̂
    @test vec_proj(v2, n̂) == 1.0 * n̂

    @test vec_sub_vec_proj(v1, n̂) == v1
    @test vec_sub_vec_proj(n̂, n̂) == 0.0 * n̂
    @test vec_sub_vec_proj(v2, n̂) == SVector{3,Float64}(0, 1, 0)
end
