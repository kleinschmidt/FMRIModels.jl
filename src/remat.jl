import MixedModels: ReMat

immutable ExpandedReMat{T<:AbstractFloat,V,R} <: ReMat
    f::Union{NullableCategoricalVector{V,R},CategoricalVector{V,R},PooledDataVector{V,R}}
    z::AbstractMatrix{T}
    fnm::Symbol
    cnms::Vector
end

ExpandedReMat(A::ReMat) = ExpandedReMat(A.f, full(A), A.fnm, A.cnms)

Base.size(A::ExpandedReMat) = size(A.z)
Base.size(A::ExpandedReMat, i::Integer) = size(A.z, i)

Base.full(r::ExpandedReMat) = isa(r.z, AbstractSparseMatrix) ? full(r.z) : r.z
Base.sparse(r::ExpandedReMat) = isa(r.z, AbstractSparseMatrix) ? r.z : sparse(r.z)


Base.A_mul_B!{T}(α::Real, A::ExpandedReMat, B::StridedVecOrMat{T}, β::Real, R::StridedVecOrMat{T}) = A_mul_B!(α, A.z, B, β, R)
Base.Ac_mul_B!{T}(α::Real, A::ExpandedReMat, B::StridedVecOrMat{T}, β::Real, R::StridedVecOrMat{T}) = Ac_mul_B!(α, A.z, B, β, R)


# Base.Ac_mul_B{T}(A::ScalarReMat{T}, B::ScalarReMat{T})
# Base.Ac_mul_B{T}(A::VectorReMat{T}, B::ScalarReMat{T})
# Base.Ac_mul_B{T}(A::ScalarReMat{T}, B::VectorReMat{T}) = ctranspose(B'A)
Base.Ac_mul_B(A::ExpandedReMat, B) = Ac_mul_B(A.z, B)
Base.Ac_mul_B(A, B::ExpandedReMat) = Ac_mul_B(A, B.z)
Base.Ac_mul_B(A::ExpandedReMat, B::ExpandedReMat) = Ac_mul_B(A.z, B.z)






# Base.Ac_mul_B!{T}(C::Diagonal{T}, A::ScalarReMat{T}, B::ScalarReMat{T})
# Base.Ac_mul_B!{Tv, Ti}(C::SparseMatrixCSC{Tv, Ti}, A::ScalarReMat{Tv}, B::ScalarReMat{Tv})
# Base.Ac_mul_B!{T}(C::HBlkDiag{T}, A::VectorReMat{T}, B::VectorReMat{T})
# Base.Ac_mul_B!{T}(C::Matrix{T}, A::ScalarReMat{T}, B::ScalarReMat{T})
# Base.Ac_mul_B!{T}(C::Matrix{T}, A::VectorReMat{T}, B::VectorReMat{T})
# Base.Ac_mul_B{T}(A::VectorReMat{T}, B::VectorReMat{T})

# Base.Ac_mul_B!{T}(C::Matrix{T}, A::VectorReMat{T}, B::VectorReMat{T})
# Base.Ac_mul_B!{T}(R::DenseVecOrMat{T}, A::DenseVecOrMat{T}, B::ReMat)
# Base.Ac_mul_B(A::DenseVecOrMat, B::ReMat)

# (*){T}(D::Diagonal{T}, A::ScalarReMat{T})
# Base.A_mul_B!{T}(C::ScalarReMat{T}, A::Diagonal{T}, B::ScalarReMat{T})
# Base.A_mul_B!{T}(C::VectorReMat{T}, A::Diagonal{T}, B::VectorReMat{T})

# Base.A_mul_B!{T}(A::Diagonal{T}, B::ScalarReMat{T})
# Base.A_mul_B!{T}(A::Diagonal{T}, B::VectorReMat{T})

# (*){T}(D::Diagonal{T}, A::VectorReMat{T})

################################################################################
# Don't need to implement these:
