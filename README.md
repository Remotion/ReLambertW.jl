# ReLambertW

[Lambert W function](https://en.wikipedia.org/wiki/Lambert_W_function)

[Wright omega function](https://en.wikipedia.org/wiki/Wright_omega_function)

Julia module to compute real valued Lambert-W Function also known as product-log.

Fast real valued Wright omega function is included as well.

Lambert W is the solution to the equation  w*exp(w) = x.

Wright omega function is the solution to the equation y + ln(y) = x

Functions: `lambertw0(z)`, `lambertwm1(z)`, `womega(z)`
Constants: `omega`, `Ω`

## Examples ##

```julia
julia> W₀(x) = lambertw0(x);
julia> W₋₁(x) = lambertwm1(x);
julia> ω(x) = womega(x);

julia> womega(0)
0.5671432904097838

julia> womega(big(0))
0.567143290409783872999968662210355549753815787186512508135131079223045793086683

julia> lambertw0(1)
0.5671432904097838

julia> lambertwm1(-exp(-1))
-1.0

julia> omega
Ω = 0.5671432904097...

julia> big(omega)
0.567143290409783872999968662210355549753815787186512508135131079223045793086683

julia> omega * exp(omega)
1.0

julia> womega(987) + log(womega(987))
987.0000000000001

julia> womega(big(987)) + log(womega(big(987)))
987.0  
```


## References ##


* Toshio Fukushima 2020: [Precise and fast computation of Lambert W function by piecewise minimax rational function approximation with variable transformation](https://www.researchgate.net/publication/346309410_Precise_and_fast_computation_of_Lambert_W_function_by_piecewise_minimax_rational_function_approximation_with_variable_transformation)

* Toshio Fukushima 2020: [Fast computation of Wright ω function by piecewise minimax rational function approximation](https://www.researchgate.net/publication/345000961_Fast_computation_of_Wright_o_function_by_piecewise_minimax_rational_function_approximation)

