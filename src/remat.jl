import MixedModels: AbstractReMat


"""
    ExpandedReMat

Represent a random effects matrix that can't be represented in the compact
format of the standard ReMat.  The z field here is the full Z' matrix, and
linear algebra methods delegate to the (transposed?) matrix.

"""

immutable ExpandedReMat{T<:AbstractFloat,V,R} <: AbstractReMat
    f::Union{NullableCategoricalVector{V,R},CategoricalVector{V,R},PooledDataVector{V,R}}
    z::AbstractMatrix{T}
    fnm::Symbol
    cnms::Vector
end

ExpandedReMat(A::AbstractReMat) = ExpandedReMat(A.f, full(A), A.fnm, A.cnms)

Base.size(A::ExpandedReMat) = size(A.z)
Base.size(A::ExpandedReMat, i::Integer) = size(A.z, i)

Base.full(r::ExpandedReMat) = isa(r.z, AbstractSparseMatrix) ? full(r.z) : r.z
Base.sparse(r::ExpandedReMat) = isa(r.z, AbstractSparseMatrix) ? r.z : sparse(r.z)

