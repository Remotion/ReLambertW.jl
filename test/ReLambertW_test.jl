
using Test
include("../src/ReLambertW.jl")
using .ReLambertW

import .MathConstants.e
import .MathConstants.pi

@test lambertwm1(-1/e) == -1;
@test lambertwm1(big(-1)/big(e)) == -1;

@test lambertw0(e) == 1;
@test lambertw0(big(e)) == 1;

@test lambertw0(2*exp(2)) == 2
@test lambertw0(2*exp(big(2))) == 2

function lambertw0_test_iter_1(T)
    for i = 1:700
        ti = T(i)
        lambertw0(ti*exp(ti)) != i && return false;
    end
    return true
end
@test lambertw0_test_iter_1(Float64)
@test lambertw0_test_iter_1(BigFloat)


function lambertw0_test_iter_2(T)
    for i = 1:700
        ti = T(1)/T(i);
        w = lambertw0(ti*exp(ti));
        if !isapprox(w,ti)
            println(" i",i," ",w," != " ,ti);
            return false;
        end
    end
    return true
end
@test lambertw0_test_iter_2(Float64)
@test lambertw0_test_iter_2(BigFloat)

@test lambertw0(1/8*exp(1/8)) ≈ 1/8
@test lambertw0(big(1)/8*exp(big(1)/8)) == 1/8

@test lambertw0(big(0.0)) == 0
@test lambertw0(1.0) ≈ Ω
@test lambertw0(1.0) == Float64(Ω);
@test lambertw0(1.0) ≈ omega;
@test lambertw0(1.0) == Float64(omega);
@test lambertw0(big(1.0)) == big(omega)

@test lambertwm1(-1/e) == -1
@test lambertwm1(big(-1)/big(e)) == -1

@test lambertwm1_fast(0.0) == -Inf
@test lambertwm1(0.0) == -Inf
@test lambertwm1(big(0.0)) == -Inf


@test AbstractFloat in supertypes(typeof(lambertw0(1//3)))
@test AbstractFloat in supertypes(typeof(lambertw0(1//big(3))))

@test AbstractFloat in supertypes(typeof(lambertw0(-1//3)))
@test AbstractFloat in supertypes(typeof(lambertw0(-1//big(3))))


@test lambertw0(pi) == 1.073658194796149172092178407024821347547745350410314531380525539603772912749810400238657539543107022
@test lambertw0(pi)*exp(lambertw0(pi)) ≈ Float64(pi)
@test lambertw0(BigFloat(pi))*exp(lambertw0(BigFloat(pi))) ≈ BigFloat(pi)
@test lambertw0(BigFloat(pi))*exp(lambertw0(BigFloat(pi))) == BigFloat(pi)

setprecision(512);
@test lambertw0(BigFloat(pi)) == BigFloat("1.07365819479614917209217840702482134754774535041031453138052553960377\
2912749810400238657539543107021745350480054282507202230659920022936523\
6774999977546837967978607572802078218928250041977017117468185378390026");
setprecision(256);


#! Wright omega function Tests

@test womega(0.0) == Float64(omega)
@test womega(big(0.0)) == big(omega)

@test womega(1.0f0) == 1.0f0
@test womega(1.0) == 1.0
@test womega(1) == 1
@test womega(big(1.0)) == 1
@test womega(big(1)) == 1

@test womega(Float32(-2.0)) < womega(Float32(-1.0))
@test womega(Float64(-2.0)) < womega(Float64(-1.0))

@test womega(Float32(Inf)) == Inf
@test womega(Float32(-Inf)) == 0
@test womega(Float64(Inf)) == Inf
@test womega(Float64(-Inf)) == 0
@test womega(Inf) == Inf
@test womega(-Inf) == 0
@test womega(big(Inf)) == Inf
@test womega(big(-Inf)) == 0

@test womega(pi) ≈ lambertw0(exp(pi))
@test womega(e) ≈ lambertw0(exp(e))

function womega_vs_lambertw0_test_1(T, niters )
    ep = eps(T)*4;
    for v = rand(T, niters) * 708 # exp() may overflow if we use bigger values here.
        !isapprox(womega(v), lambertw0(exp(v)), rtol=ep) && return false;
    end
    return true
end

@test womega_vs_lambertw0_test_1(Float64, 100_000)
@test womega_vs_lambertw0_test_1(BigFloat, 1000)

function womega_vs_lambertw0_test_2(T, niters )
    ep = eps(T)*4;
    for v = rand(T, niters) * 708 .+ 1
        iv = 1/v;
        if !isapprox(womega(iv), lambertw0(exp(iv)), rtol=ep)
            println(iv, "  " ,v,"  ", womega(iv) / lambertw0(exp(iv)));
            return false;
        end
    end
    return true
end

@test womega_vs_lambertw0_test_2(Float64, 100_000)
@test womega_vs_lambertw0_test_2(BigFloat, 1000)

# short function names.
W₀(x)  = lambertw0(x);
W₋₁(x) = lambertwm1(x);
ω(x)   = womega(x);

@test W₀(0) == 0
@test W₀(-1/e) == -1
@test W₀(2*log(2)) == log(2)

@test ω(0) == W₀(1)
@test ω(1) == 1
