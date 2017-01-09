function img_conv = p05_conv2d(image,kernel)

[m,n] = size(image);
[kernelsize,~] = size(kernel);
padding = floor(kernelsize/2);
image_pddd = padarray(image, [padding padding]);
kernel_flpd = flipud(fliplr(kernel));

img_filt = ones(m,n);

for x = 1+padding:m+padding
  for y = 1+padding:n+padding
  subA = image_pddd(x-padding:x+padding,y-padding:y+padding);
  img_conv(x,y) = sum(sum(subA.*kernel));
  end
 end

