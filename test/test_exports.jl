@testset "exports" begin
    # Ensure that every exported name is actually defined
    for name in names(NumericalTricks)
        @test isdefined(NumericalTricks, name)
    end
end
