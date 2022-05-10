
using BenchmarkTools
include("../src/ReLambertW.jl")
using .ReLambertW

import .MathConstants.e
import .MathConstants.pi

@benchmark womega(x) setup=(x=rand())
@benchmark womega(1.0)
@benchmark womega(big(1.0)) samples=100

@benchmark lambertw0(x) setup=(x=rand(Float64)*10)
@benchmark lambertw0(1.0)

@benchmark lambertw0(x) setup=(x=rand(Float64)*10)
@benchmark lambertw0(big(1.0)) samples=100


#! Comparison with LambertW.jl
using LambertW

println("LambertW -------------------------------------------")
@benchmark lambertw(x) setup=(x=rand(Float64)*10) samples=4000
@benchmark lambertw(x) setup=(x=rand(BigFloat)*10) samples=100

println("ReLambertW -----------------------------------------")
@benchmark lambertw0(x) setup=(x=rand(Float64)*10) samples=4000
@benchmark lambertw0(x) setup=(x=rand(BigFloat)*10) samples=100

suite = BenchmarkGroup()
suite["LambertW"] = BenchmarkGroup(["lambertw"])
suite["ReLambertW"] = BenchmarkGroup(["lambertw0"])

suite["LambertW"]["lambertw"] = @benchmarkable lambertw(x) setup=(x=rand(BigFloat)*10) samples=100
suite["ReLambertW"]["lambertw0"] = @benchmarkable lambertw0(x) setup=(x=rand(BigFloat)*10) samples=100

results = run(suite) # , verbose = true
median(results)