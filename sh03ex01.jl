function myhistogram(img)
     @assert minimum(img) >= 0 "'img'exceeds allowed range (minimum below 0)."
     @assert minimum(img) <= 1 "'img'exceeds allowed range (maximum above 1)."
     h = zeros(256)
     for i in 0:255
        h[i+1] = sum(i/255 .<= img .< (i+1)/255)
     end
     return h ./sum(h)
end


using Images
using FileIO
using Plots

img1 = load("F:\\uulm\\semester2\\CV1\\exercise3\\materials\\bookstore_dark.tif")
p0 = plot(img1,showaxis = false)
hist1 = myhistogram(img1)
p1 = bar(hist1,title="Histogram", legend = false,xlabel = "intensity", ylabel = "frequency")
s1  = cumsum(hist1)
p2 = bar(s1,title="Cumulative histogram", legend = false,xlabel = "intensity", ylabel = "cumulated frequency")

value = float.(img1)
h = size(value)[1]
w = size(value)[2]
channelvalue = channelview(value)
for i in 1:h
   for j in 1:w
      channelvalue[i,j] = s[floor(Int,channelvalue[i,j]*255)+1]
   end
end

newimg = colorview(Gray,channelvalue)
p3 = plot(newimg,title ="equalized image",showaxis = false)
hist2 = myhistogram(newimg)
p4 = bar(hist2,title="Histogram", legend = false,xlabel = "intensity", ylabel = "frequency")
s2  = cumsum(hist2)
p5 = bar(s2,title="Cumulative histogram", legend = false,xlabel = "intensity", ylabel = "cumulated frequency")

plot(p0,p1,p2,p3,p4,p5,layout =(2,3))
savefig("res.png")
