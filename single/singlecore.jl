function ijk(A::Array{Float64}, B::Array{Float64}, C::Array{Float64})
	    @inbounds for i=1:size(A)[1]
        	for k=1:size(B)[2]
            	for j=1:size(A)[2]
                	C[i,k]+= A[i,j]*B[j,k]
                end
            end
        end
        C
    end

 function perform_ijk(n::Int64)
 	A = randn((n,n))
 	B = randn((n,n))
 	C = zeros((n,n))
	tic()
 	ijk(A,B,C)
	toc()
 end
