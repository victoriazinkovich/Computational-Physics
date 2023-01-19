### Viscosity of the rarefied gas

In this work, the following things were implemented:

1. Julia-package that is implementing the rarefied gas model, having the following interface
  - Structure for setting the substance
  - The function of calculating viscosity by structure and temperature 

2. Using the developed package, viscosities for $CO_2$, $CH_4$, $O_2$ were calculated in the temperature ranges of 100-1000 K in increments of 1 Kelvin

3. Graphs were constructed for each substance. The graphs show
  - Calculated viscosity of the substance from the rarefied gas model
  - NIST database data on viscosity for each substance (5-6 points)
