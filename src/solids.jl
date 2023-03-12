# regular solids and their inertial properties
abstract type AbstractSolid end

## cuboid
struct Cuboid{T<:Real} <: AbstractSolid
    length::T
    width::T
    height::T
    mass::T
    Ixx::T
    Iyy::T
    Izz::T
    Ixy::T
    Iyz::T
    Izx::T
end

# determine moment of inertia from dimensions and mass
function Cuboid(l, w, h, m)
    c = 1 / 12 * m
    Ixx = c * (w^2 + h^2)
    Iyy = c * (l^2 + h^2)
    Izz = c * (l^2 + w^2)
    Ixy = Iyz = Izx = zero(l)

    return Cuboid(l, w, h, m, Ixx, Iyy, Izz, Ixy, Iyz, Izx)
end


## sphere
struct Sphere{T<:Real} <: AbstractSolid
    radius::T
    mass::T
    Ixx::T
    Iyy::T
    Izz::T
    Ixy::T
    Iyz::T
    Izx::T
end

# determine moment of inertia from dimensions and mass
function Sphere(r, m)
    c = 2 / 5 * m
    Ixx = Iyy = Izz = c * r^2
    Ixy = Iyz = Izx = zero(r)

    return Sphere(r, m, Ixx, Iyy, Izz, Ixy, Iyz, Izx)
end


## cylinder
struct Cylinder{T<:Real} <: AbstractSolid
    radius::T
    length::T
    mass::T
    Ixx::T
    Iyy::T
    Izz::T
    Ixy::T
    Iyz::T
    Izx::T
end

# determine moment of inertia from dimensions and mass
function Cylinder(r, l, m)
    c1 = 1 / 12 * m
    c2 = 1 / 2 * m
    Ixx = c2 * r^2
    Iyy = Izz = c1 * (3r^2 + l^2)
    Ixy = Iyz = Izx = zero(r)

    return Cylinder(r, l, m, Ixx, Iyy, Izz, Ixy, Iyz, Izx)
end


