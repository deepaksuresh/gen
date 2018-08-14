#Assumes that julia is started as julia -p 4

addprocs(2)

@everywhere function matmul_multicore(n,w,A,B,C)
    range = 1+(w-2) * div(n,2) : (w-1) * div(n,2)
    @inbounds for i=range
    	for k=1:size(B)[2]
            for j=1:size(A)[2]
                C[i,k]+= A[i,j]*B[j,k]
            end
        end
    end
end



function perform_ijk_multicore(n::Int64)
	A = randn(n,n);
	B = randn(n,n);
	C = SharedArray{Float64}((n,n));
    tic()
    @sync begin
    for w in workers()
        @async remotecall_wait(matmul_multicore, w, n, w, A, B, C)
    end
end
toc()
end

