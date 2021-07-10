using Images
using FileIO
using Plots
using FFTW
using Interact
using ImageFiltering
#a)
img1 = load("F:\\uulm\\semester2\\CV1\\exercise2\\flower01.png")
img2 = load("F:\\uulm\\semester2\\CV1\\exercise2\\flower02.png")
img1 = Gray.(img1)
img2 = Gray.(img2)
spectrum1 = fft(channelview(img1))
spectrum2 = fft(channelview(img2))
spectrum1 = fftshift(abs.(spectrum1))
spectrum2 = fftshift(abs.(spectrum2))
#b)
value = float.(img1)
h = size(value)[1]/2
filter = Kernel.gaussian(h)
a = maximum(filter)
filter = 1 .- (filter./a)
imgg1 = imfilter(spectrum1,reflect(centered(filter)))
imgg2 = imfilter(spectrum2,reflect(centered(filter)))
#c)
e1 = sum(abs2,imgg1)
e2 = sum(abs2,imgg2)
#d)
h1 = heatmap(abs.(imgg1),title="amplitude spectra",color=:grays,xticks=false,yticks=false)
annotate!(h1,410,320,e1)
savefig("4.png")
h2 = heatmap(abs.(imgg2),title="amplitude spectra",color=:grays,xticks=false,yticks=false)
annotate!(h2,400,320,e2)
savefig("5.png")
