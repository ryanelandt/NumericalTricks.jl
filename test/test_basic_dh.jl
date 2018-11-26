
@testset "basic_dh" begin

    zero_3 = zeros(SVector{3,Float64})
    rot_I = one(RotMatrix{3,Float64})
    sm44_I = one(SMatrix{4,4,Float64,16})
    rot_rand = rand(RotMatrix{3,Float64})
    t_rand = rand(SVector{3,Float64})

    # Rotation Only
    @test sm44_I == basic_dh(rot_I).mat
    R, t = dh_R_t(basic_dh(rot_rand))
    @test R == rot_rand
    @test t == zero_3

    # Translation Only
    @test sm44_I == basic_dh(zero_3).mat
    R, t = dh_R_t(basic_dh(t_rand))
    @test R == rot_I
    @test t == t_rand

    # Rotation and Translation
    @test sm44_I == basic_dh(rot_I, zero_3).mat
    R, t = dh_R_t(basic_dh(rot_rand, t_rand))
    @test R == rot_rand
    @test t == t_rand

    # Matrix
    @test sm44_I == basic_dh(sm44_I).mat

    @test R isa SMatrix{3,3,Float64,9}
    @test t isa SVector{3,Float64}

end
