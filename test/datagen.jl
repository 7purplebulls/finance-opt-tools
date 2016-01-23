# generate data
if Pkg.installed("JLD") == nothing
    Pkg.add("JLD")
end

using JLD

function gendata(n)
	
	# covariance matrix
	covar = (arg = randn(n,n); arg*arg'/1000)
    # expected return
    u = rand(Float64,n)/100

#return(covar)

save("randdata.jld","covar", covar, "u",u)    

end

