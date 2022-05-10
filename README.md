# ReLambertW

[Lambert W function](https://en.wikipedia.org/wiki/Lambert_W_function)

[Wright omega function](https://en.wikipedia.org/wiki/Wright_omega_function)

Julia module to compute real Lambert-W Function also known as product-log.
This module also includes Wright omega function as well.

Lambert W is the solution to the equation  w*exp(w) = x.

Wright omega function is the solution to the equation y + ln(y) = x

Functions: `lambertw0(z)`, `lambertwm1(z)`, `womega(z)`
Constants: `omega`, `Ω`

```julia
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
