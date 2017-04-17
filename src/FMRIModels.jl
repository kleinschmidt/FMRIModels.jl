module FMRIModels

using CategoricalArrays, DataArrays, NIfTI

import MixedModels: ReMat
export ExpandedReMat

include.(["remat.jl"])

end
