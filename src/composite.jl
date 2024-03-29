# calculate inertial properties for combinations of solids

# inertia about axes rotated by R from axes inertia currently expressed in
rotated_inertia(I, R) = R * I * R'

# parallel axis theorem for inertia tensor about a point p from CoM
function parallel_axis(I, m, p)
    Ixx = I[1, 1] + m * (p[2]^2 + p[3]^2)
    Iyy = I[2, 2] + m * (p[1]^2 + p[3]^2)
    Izz = I[3, 3] + m * (p[1]^2 + p[2]^2)
    Ixy = Iyx = I[1, 2] - m * p[1] * p[2]
    Ixz = Izx = I[1, 3] - m * p[1] * p[3]
    Iyz = Izy = I[2, 3] - m * p[2] * p[3]

    return [Ixx Ixy Ixz; Iyx Iyy Iyz; Izx Izy Izz]
end

parallel_axis(solid::AbstractSolid, p) = parallel_axis(moi(solid), solid.mass, p)

# sum inertia
sum_inertia(I...) = sum(I)

# centre of mass
centre_of_mass(ms, rs) = reduce(+, ms .* rs) / sum(ms)

centre_of_mass(solids::Vector{T}, rs) where {T<:AbstractSolid} = centre_of_mass(getfield.(solids, :mass), rs)

# calculate total inertia of collection of solids about a point p
function calculate_inertia(Is, Rs, ms, rs, p)
    # total inertia about CoM
    Itotal = zeros(3, 3)

    for (I, R, m, r) in zip(Is, Rs, ms, rs)
        # inertia about axes parallel to global frame
        I′ = rotated_inertia(I, R')

        # inertia about com
        I′cm = parallel_axis(I′, m, p - r)

        Itotal += I′cm
    end

    return Itotal
end

# total inertia about CoM
calculate_inertia(Is, Rs, ms, rs) = calculate_inertia(Is, Rs, ms, rs, centre_of_mass(ms, rs))

"""
Calculate the combined inertia of a collection of rigid bodies about a point.

- `solids`: vector of solids.
- `Rs`: vector of rotation matricies for the rotation from the global frame to the body-fixed frame.
- `rs`: vector of positions of each solids centre of mass.
- `p`: point about which inertia is calculated. If omitted defaults to the centre of mass of the system.
"""
calculate_inertia(solids::Vector{T}, Rs, rs, p) where {T<:AbstractSolid} = begin
    calculate_inertia(moi.(solids), Rs, mass.(solids), rs, p)
end

calculate_inertia(solids::Vector{T}, Rs, rs) where {T<:AbstractSolid} = begin
    calculate_inertia(moi.(solids), Rs, mass.(solids), rs)
end
