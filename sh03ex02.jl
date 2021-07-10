using Images
using FileIO
using Plots

img1 = load("F:\\uulm\\semester2\\CV1\\exercise3\\materials\\circles.png")
p0 = plot(img1,legend = false)
filterx = [1 0 -1;2 0 -2;1 0 -1]
filtery = [1 2 1;0 0 0;-1 -2 -1]
p1 = imfilter(Gray.(img1), reflect(centered(filterx)))
p2 = imfilter(Gray.(img1), reflect(centered(filtery)))

value = float.(img1)
channelvalue = channelview(value)
h = size(value)[1]
w = size(value)[2]

ix = float.(p1)
ixvalue = channelview(ix)
iy = float.(p2)
iyvalue = channelview(iy)

buffer1 = zeros(h,w)
buffer2 = zeros(h,w)
for i in 1:h
  for j in 1:w
    buffer1[i,j] = sqrt(ixvalue[i,j]*ixvalue[i,j]+iyvalue[i,j]*iyvalue[i,j])
    buffer2[i,j] = atan(iyvalue[i,j]/ixvalue[i,j])
  end
end

p3 = heatmap(buffer1,title = "gradient magnitude", legend = false,size = (300,300))
include("F:\\uulm\\semester2\\CV1\\exercise3\\materials\\colorgrad.jl")
p4 = plot(ColorGrad.colorgrad(buffer2,buffer1, 0.0),title = "gradient orientation",legend = false)
