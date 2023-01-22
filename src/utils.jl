# return moi matrix of a solid
moi(s::AbstractSolid) = @SMatrix [s.Ixx s.Ixy s.Izx; s.Ixy s.Iyy s.Iyz; s.Izx s.Iyz s.Izz]

# mass of solid
mass(s::AbstractSolid) = s.mass