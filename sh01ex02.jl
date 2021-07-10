using TestImages
using ImageFiltering
img = testimage("lake_gray")

filter = [-1 0 1;-1 0 1;-1 0 1]
img2 = imfilter(Gray.(img), reflect(centered(filter)))
pic1 = plot(img, showaxis = false,title = "original image")
pic2 = plot(img2, showaxis = false,title = "filtered image")
plot(pic1, pic2,layout = (1,2))
savefig("filter.png")
