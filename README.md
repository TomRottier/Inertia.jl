# Inertia.jl
Julia package for calculating inertia parameters geometric solids.

## Installation
```julia
  pkg> add Inertia
```

## Usage
```julia
using Inertia
```

### Example
```julia

# create two solids
l = 1.0
w = 2.0
h = 3.0
m = 0.1
cuboid1 = Cuboid(l,w,h,m) # length, width, height, mass
cuboid2 = Cuboid(l,w,h,m)

# centre of mass of each solid
r1 = [-l/2, 0, 0]
r2 = [ l/2, 0, 0]

# rotation of each solid
R = [1 0 0; 0 0 -1; 0 1 0] # each rotated by 90 degrees about x axis

# group into vectors
solids = [cuboid1, cuboid2]
Rs = fill(R, 2)
rs = [r1, r2]

# centre of mass of whole system
com = centre_of_mass(solids, rs)

# combined inertia about combined centre of mass
moi = calculate_inertia(solids, Rs, rs, com)

# check combined inertia is equal to that of cuboid with double the length, double the mass and rotated by 90 degrees about x axis
moi == Cuboid(2l, h, w, 2m).moi

```
