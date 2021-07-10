using Images
using Plots
using ImageFiltering
using LinearAlgebra

img1 = load("shapes1.png")
v, h = Kernel.sobel()
I_y = imfilter(img1, v)
Gray.(abs.(I_y) ./ maximum(I_y))
I_x = imfilter(img1, h)
Gray.(abs.(I_x) ./ maximum(I_x))
magni = sqrt.(I_x .^ 2 + I_y .^ 2)
Gray.(magni./maximum(magni))

G = Kernel.gaussian(3)
k = [I_x.^2 I_x*I_y; I_y*I_x I_y.^2]
S = imfilter( k, reflect(centered(G)))
eig = eigen(S)
eigenvalue = reverse(eig.values, dims=1)

function quiverhelper(x,y,u,v;subsample=4, scale=100,threshold=0.05)
    x = x[1:subsample:end, 1:subsample:end]
    y = x[1:subsample:end, 1:subsample:end]
    u = x[1:subsample:end, 1:subsample:end]
    v = x[1:subsample:end, 1:subsample:end]
    above0 = sqrt.(u.^2+v.^2) .> threshold
    x = x[above0]
    y = x[above0]
    u = x[above0]
    v = x[above0]
    u = scale .* u
    c = scale .* v
    return(quiver(x[:],y[:],quiver=(u[:],v[:])))
end

x = zeros(size(I_x,1) * size(I_x,2), 1);
y = zeros(size(I_x,1) * size(I_x,2), 1);
u = zeros(size(I_x,1) * size(I_x,2), 1);
v = zeros(size(I_x,1) * size(I_x,2), 1);

eig_max = zeros(size(img1));
eig_min = zeros(size(img1));

threshold1=0.03;
threshold2=0.05;
