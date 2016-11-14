%pkg load image;

close all; clear; clc;
%read picture and convert to double
img = imread('p02_Bild01.tif'); 
image = im2double(img);

%use fft functions
img_myfft = p02_myfft2(image);
img_fft = fftshift(fft2(image));

%get amplitude and scale image
amp_img_myfft = log(abs(img_myfft))/8;
amp_img_fft = log(abs(img_fft))/8;

figure(1); imshow(amp_img_myfft);
figure(2); imshow(amp_img_fft);

%inverse ft and shifting
img_myifft = ifft2(ifftshift(img_myfft));
img_ifft = ifft2(ifftshift(img_fft));

%test if imaginary part is zero
if(max(abs(imag(img_myifft(:))))/max(abs(img_myifft(:))) < sqrt(eps))
  figure(3); imshow(real(img_myifft));
end

