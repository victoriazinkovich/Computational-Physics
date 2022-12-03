include("../Package/src/package.jl")

using .Viscosity
using Plots, DelimitedFiles

function plot_graph(foo, ts, ys, name)
    scatter(ts, ys; label="Узлы интерполяции", legend=:top, xlabel="Temperature, K", ylabel="Viscosity, μPa * s")
    xs = collect(first(ts):1:last(ts))
    plot!(xs, foo.(xs); title = "Molecule: " * name, label="Кубический сплайн")
    savefig("./Output plots/" * name * ".png")
end

CO2 = Substance("CO2", 44.009/1000, 3.996, 190)
CH4 = Substance("CH4", 16.043/1000, 3.822, 137)
O2  = Substance("O2", 31.999/1000, 3.433, 113)

substances = [CO2, CH4, O2]

η_s = [Viscosity.η(molecule) for molecule in substances]

for (molecule, η) in zip(substances, η_s)
    nist = readdlm("./Output data/" * molecule.name * ".nist.tsv")
    n = size(nist, 1)
    temps = nist[2:n]
    velosities = nist[n+2:2*n]
    display(plot_graph(η, temps, velosities, molecule.name))
end
