sk = [2 3 0 1]
k = [0 1 2 3]
u = [0 1 2 3]
N = 4
su = zeros(ComplexF64,4)
#a)
for i in u
    sigma = 0
    for j in k
        sigma += sk[j+1]*exp((-1*im)*2*pi*i/N*j)
    end
    su[i+1] = round(sigma)/sqrt(N)
end
println(su)
#b)
sr = zeros(4)
for i in k
    sigma = 0
    for j in u
        sigma += su[j+1]*exp((1*im)*2*pi*j/N*i)
    end
    sr[i+1] = round(sigma)/sqrt(N)
end
println(sr)
#c)
using Plots
pic1 = bar(k,sk,title="original signal", legend=false)
savefig("1.png")
pic2 = bar(0:3,su,title="frequency spectrum", legend=false)
savefig("2.png")
pic3 = bar(0:3,sr,title="reconstructed signal", legend=false)
savefig("3.png")
