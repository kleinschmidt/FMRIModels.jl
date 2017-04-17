module TestRemat

using Base.Test, MixedModels, FMRIModels, DataFrames

# from MixedModels/test/data.jl:
const ds = DataFrame(Yield = [1545.,1440.,1440.,1520.,1580.,1540.,1555.,1490.,1560.,1495.,
                              1595.,1550.,1605.,1510.,1560.,1445.,1440.,1595.,1465.,1545.,
                              1595.,1630.,1515.,1635.,1625.,1520.,1455.,1450.,1480.,1445.],
                     Batch = pool(repeat('A' : 'F', inner = 5)))

m = lmm(@formula(Yield ~ 1 + (1|Batch)), ds)

terms = m.trms

erm = ExpandedReMat(terms[1])

@test sparse(erm) == sparse(terms[1])

fit!(m)

m2 = lmm(@formula(Yield ~ 1 + (1|Batch)), ds)
m2.trms[1] = erm

fit!(m2)

end # module
