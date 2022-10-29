using Test, Inertia
using StaticArrays

@testset "solids" verbose = true begin

    @testset "cuboid" verbose = true begin
        cuboid = Cuboid(1.0, 2.0, 3.0, 0.1)
        @test isapprox(cuboid.moi, @SMatrix [0.10833 0 0; 0 0.08333 0; 0 0 0.04167]; atol=1e-5)

    end

    @testset "sphere" verbose = true begin
        sphere = Sphere(1.0, 1.0)
        @test isapprox(sphere.moi, @SMatrix [0.4 0 0; 0 0.4 0; 0 0 0.4]; atol=1e-5)

    end


    @testset "cylinder" verbose = true begin
        cylinder = Cylinder(0.1, 2.3, 3.5)
        @test isapprox(cylinder.moi, @SMatrix [0.0175 0 0; 0 1.5517 0; 0 0 1.5517]; atol=1e-4)

    end

end


# test that two cuboids next to each other such that their inertia about combined centre of mass is the same as what is would be for a larger cuboid
@testset "composite shapes" verbose = true begin
    # cuboids of same dimensions and mass
    l = 1.0
    w = 2.0
    h = 3.0
    m = 0.1
    cuboid1 = Cuboid(l, w, h, m)
    cuboid2 = Cuboid(l, w, h, m)

    # dispalcement from origin of cuboids com
    r1 = [-l / 2, 0, 0]
    r2 = [l / 2, 0, 0]

    solids = [cuboid1, cuboid2]
    rs = [r1, r2]

    @testset "centre of mass" verbose = true begin
        com = centre_of_mass(solids, rs)
        @test com ≈ [0.0, 0.0, 0.0]

    end

    @testset "parallel axis" verbose = true begin
        @test Inertia.parallel_axis(cuboid1, [0, 0, 0]) == cuboid1.moi
        @test Inertia.parallel_axis(cuboid1, [1, 1, 1]) == cuboid1.moi + m * [2 -1 -1; -1 2 -1; -1 -1 2]

    end

    @testset "rotate inertia" verbose = true begin
        R = [1 0 0; 0 0 -1; 0 1 0] # rotates 90 degrees about x axis
        @test Inertia.rotated_inertia(cuboid1.moi, R') == Cuboid(l, h, w, m).moi

    end

    @testset "moment of inertia" verbose = true begin
        Rs = fill([1 0 0; 0 1 0; 0 0 1], 2)
        moi = calculate_inertia(solids, Rs, rs)
        @test moi == Cuboid(2l, w, h, 2m).moi

        R = [1 0 0; 0 0 -1; 0 1 0] # rotates 90 degrees about x axis
        Rs = fill(R, 2)
        moi = calculate_inertia(solids, Rs, rs)
        @test moi == Cuboid(2l, h, w, 2m).moi


    end
end