# regular solids and their inertial properties
abstract type AbstractSolid end

## cuboid
struct Cuboid{T} <: AbstractSolid
    length::T
    width::T
    height::T
    mass::T
    moi::SMatrix{3,3,T,9} # principle inertia tensor
end

# determine moment of inertia from dimensions and mass
function Cuboid(l, w, h, m)
    c = 1 / 12 * m
    I = @SMatrix [c*(w^2+h^2) 0 0; 0 c*(l^2+h^2) 0; 0 0 c*(l^2+w^2)]

    return Cuboid(l, w, h, m, I)
end


## sphere
struct Sphere{T} <: AbstractSolid
    radius::T
    mass::T
    moi::SMatrix{3,3,T,9} # principle inertia tensor
end

# determine moment of inertia from dimensions and mass
function Sphere(r, m)
    c = 2 / 5 * m
    I = @SMatrix [c*r^2 0 0; 0 c*r^2 0; 0 0 c*r^2]

    return Sphere(r, m, I)
end


## cylinder
struct Cylinder{T} <: AbstractSolid
    radius::T
    length::T
    mass::T
    moi::SMatrix{3,3,T,9} # principle inertia tensor
end

# determine moment of inertia from dimensions and mass
function Cylinder(r, l, m)
    c1 = 1 / 12 * m
    c2 = 1 / 2 * m
    I = @SMatrix [c2*r^2 0 0; 0 c1*(3r^2+l^2) 0; 0 0 c1*(3r^2+l^2)]

    return Cylinder(r, l, m, I)
end


