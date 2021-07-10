function myhistogram(img)
   value = float.(img)
   h = size(value)[1]
   w = size(value)[2]
   channelvalue = channelview(value)
   for i in 1:h
      for j in 1:w
         if channelvalue[i,j]<0 || channelvalue[i,j]>1
            println("The input intensity is not within the defined range")
            return 0
         end
      end
   end
   p = zeros(256)
   for i in 1:h
      for j in 1:w
         p[floor(Int,channelvalue[i,j]*255)+1] = p[floor(Int,channelvalue[i,j]*255)+1] + 1
      end
   end
   p = p / (h*w)
   return p
end


using Images
using FileIO
using Plots

img1 = load("F:\\uulm\\semester2\\CV1\\exercise1\\images\\obstA.png")
img2 = load("F:\\uulm\\semester2\\CV1\\exercise1\\images\\obstB.png")

hist1 = myhistogram(img1)
hist2 = myhistogram(img2)
pic1 = plot(img1,title ="obstA",showaxis = false)
pic2 = bar(1:256,hist1,title="Histogram for obstA", legend = false,xlabel = "gray value", ylabel = "normalized frequency")
annotate!(pic2,1,0.01,"fruit")
annotate!(pic2,110,0.02,"fruit")
annotate!(pic2,150,0.03,"background")
pic3 = plot(img2,title ="obstB",showaxis = false)
pic4 = bar(1:256,hist2,title="Histogram for obstB",legend = false, xlabel = "gray value", ylabel = "normalized frequency")
annotate!(pic4,0,0.01,"fruit")
annotate!(pic4,60,0.01,"fruit")
annotate!(pic4,130,0.025,"background")
plot(pic1,pic2,pic3,pic4,layout =(2,2))
savefig("res.png")

intensity1 = channelview(float.(img1))*255
x = intensity1[50,:]
plot(1:w,x,title="Profile of intensities along line50 for obstA",legend = false, xlabel = "width", ylabel = "intensity")
savefig("1.png")
y = intensity1[200,:]
plot(1:w,y,title="Profile of intensities along line200 for obstA",legend = false, xlabel = "width", ylabel = "intensity")
savefig("2.png")

intensity1 = channelview(float.(img2))*255
x = intensity1[50,:]
plot(1:w,x,title="Profile of intensities along line50 for obstB",legend = false, xlabel = "width", ylabel = "intensity")
savefig("3.png")
y = intensity1[200,:]
plot(1:w,y,title="Profile of intensities along line200 for obstB",legend = false, xlabel = "width", ylabel = "intensity")
savefig("4.png")
