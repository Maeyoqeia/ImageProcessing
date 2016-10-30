pkg load image;

close all; clear; clc;
img1 = imread('/home/viola/DATA/uni/semester7/BV/Übung1/p01_Bild1.png'); 
img2 = imread('/home/viola/DATA/uni/semester7/BV/Übung1/p01_Bild2.png'); 
figure(1); imshow(img1);
figure(2); imshow(img2);
#A = img2;
one = img2(1:5000);
two = img2(5201:120200);
three = img2(120643:end);
#A(120201:120642) = [];
#A(5001:5200) = [];

C = cat(2,one,two,three);
D = reshape(C,321,481);

figure(3); imshow(D);

