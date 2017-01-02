function img_filt = p05_filt2d(image,kernel)

imagefft = fft2(fftshift(image));
kernelfft = fft2(fftshift(kernel));

img_filtered = imagefft*kernelfft;

img_filt = ifftshift(ifft(img_filtered));