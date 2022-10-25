module Inertia

using LinearAlgebra, StaticArrays

include("solids.jl")
include("composite.jl")

export Cuboid, Sphere, Cylinder
export centre_of_mass, calculate_inertia


end # module Inertia
