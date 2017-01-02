pkg load image;

close all; clear; clc;
%read picture and convert to double
img = imread('p05_Bild01.bmp'); 
image = im2double(img);

%show picture
figure(1); imshow(image);
a = [1 2 1]';
b = [-1 0 1];
sobelkernelx = a*b;
sobelkernely = b'*a';
img1 = p05_conv2d(image, sobelkernelx);
#img2 = p05_filt2d(image, sobelkernelx);

figure(2); imshow(img1);
#figure(3); imshow(img2);