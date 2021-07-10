using Images
using FileIO
using Plots

img1 = load("shapes1.png")
img1 = Gray.(img1)
value = float.(img1)
h = size(value)[1]
w = size(value)[2]
buffer0 = zeros(Float32,h,w)
buffer45 = zeros(Float32,h,w)
buffer90 = zeros(Float32,h,w)
buffer135 = zeros(Float32,h,w)
for j in 2:h-1
    for i in 2:w-1
        buffer0[i,j] = abs2(value[i,j] - value[i+1,j])
        buffer45[i,j] = abs2(value[i,j] - value[i,j+1])
        buffer90[i,j] = abs2(value[i,j] - value[i+1,j+1])
        buffer135[i,j] =abs2(value[i,j] - value[i+1,j-1])
    end
end

boxfilter = [1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1]
buffer0 = imfilter(buffer0, reflect(centered(boxfilter)))
buffer45 = imfilter(buffer45, reflect(centered(boxfilter)))
buffer90 = imfilter(buffer90, reflect(centered(boxfilter)))
buffer135 = imfilter(buffer135, reflect(centered(boxfilter)))

for j in 2:h-1
    for i in 2:w-1
    norm = max(buffer0[i,j],buffer45[i,j],buffer90[i,j],buffer135[i,j])
    buffer0[i,j] = buffer0[i,j]/norm
    buffer45[i,j] = buffer45[i,j]/norm
    buffer90[i,j] = buffer90[i,j]/norm
    buffer135[i,j] = buffer135[i,j]/norm
    end
end

threshold = 0.7
for j in 2:h-1
    for i in 2:w-1
    minimum = min(buffer0[i,j],buffer45[i,j],buffer90[i,j],buffer135[i,j])
          if minimum > threshold
              value[i,j] = 255
          else
              value[i,j] = 0
          end
    end
end

plot(value,showaxis = false)

#for noisy image
img2 = load("shapes1_noisy.png")
img2 = Gray.(img2)
value = float.(img2)
h = size(value)[1]
w = size(value)[2]
buffer0 = zeros(Float32,h,w)
buffer45 = zeros(Float32,h,w)
buffer90 = zeros(Float32,h,w)
buffer135 = zeros(Float32,h,w)
for j in 2:h-1
    for i in 2:w-1
        buffer0[i,j] = abs2(value[i,j] - value[i+1,j])
        buffer45[i,j] = abs2(value[i,j] - value[i,j+1])
        buffer90[i,j] = abs2(value[i,j] - value[i+1,j+1])
        buffer135[i,j] =abs2(value[i,j] - value[i+1,j-1])
    end
end

boxfilter = [1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1]
buffer0 = imfilter(buffer0, reflect(centered(boxfilter)))
buffer45 = imfilter(buffer45, reflect(centered(boxfilter)))
buffer90 = imfilter(buffer90, reflect(centered(boxfilter)))
buffer135 = imfilter(buffer135, reflect(centered(boxfilter)))

for j in 2:h-1
    for i in 2:w-1
    norm = max(buffer0[i,j],buffer45[i,j],buffer90[i,j],buffer135[i,j])
    buffer0[i,j] = buffer0[i,j]/norm
    buffer45[i,j] = buffer45[i,j]/norm
    buffer90[i,j] = buffer90[i,j]/norm
    buffer135[i,j] = buffer135[i,j]/norm
    end
end

threshold = 0.7
for j in 2:h-1
    for i in 2:w-1
    minimum = min(buffer0[i,j],buffer45[i,j],buffer90[i,j],buffer135[i,j])
          if minimum > threshold
              value[i,j] = 255
          else
              value[i,j] = 0
          end
    end
end

plot(value,showaxis = false)
