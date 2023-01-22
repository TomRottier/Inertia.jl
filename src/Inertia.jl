module Inertia

using LinearAlgebra, StaticArrays

include("solids.jl")
include("composite.jl")
include("utils.jl")

export Cuboid, Sphere, Cylinder
export centre_of_mass, calculate_inertia, moi, mass


end # module Inertia
