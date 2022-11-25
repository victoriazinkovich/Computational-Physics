include("../Package/src/package.jl")

using .Viscosity

using DelimitedFiles

function create_file(foo, ts, ys, name)
    x = collect(first(ts):1:last(ts))
    y = foo.(x)
    
    open("./Output data/" * name * ".tsv", "w") do io
        writedlm(io, ["T" "η"])
        writedlm(io, [x y])
    end
    
    open("./Output data/" * name * ".nist.tsv", "w") do io
        writedlm(io, ["T" "η"])
        writedlm(io, [ts ys])
    end
end

CO2 = Substance("CO2", 44.009/1000, 3.996, 190)
CH4 = Substance("CH4", 16.043/1000, 3.822, 137)
O2  = Substance("O2", 31.999/1000, 3.433, 113)

tabular = Dict(
    CO2 => (tnist = [300, 400, 500, 600, 700, 800, 900], viscnist = [14.994, 19.621, 23.910, 27.864, 31.523, 34.953, 38.141]),
    CH4 => (tnist = [100, 200, 250, 300, 400, 500, 600], viscnist = [3.9362, 7.6848, 9.4575, 11.123, 14.165, 16.895, 19.387]),
    O2 => (tnist = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000], viscnist = [7.7024, 14.693, 20.631, 25.821, 30.470, 34.713, 38.641, 42.319, 45.796, 49.107])
)

substances = [CO2, CH4, O2]

η_s = [Viscosity.η(molecule) for molecule in substances]

for (molecule, η) in zip(substances, η_s)
    create_file(η, tabular[molecule].tnist, tabular[molecule].viscnist, molecule.name)
end
