pkg load image;

close all; clear; clc;
%read picture and convert to double
img = imread('p02_Bild01.tif'); 
image = im2double(img);
img_fft = fftshift(fft2(image));

im_25 = p02_modify(img_fft, 2, 5);
im_m25 = p02_modify(img_fft, -2, 5);
im_m2m5 = p02_modify(img_fft, -2, -5);
im_16m4 = p02_modify(img_fft, 16, -4);

figure(1);
    subplot(2,2,1); imshow(log(1+real(im_25))*5000);
    subplot(2,2,2); imshow(log(1+real(im_m25))*5000);
    subplot(2,2,3); imshow(log(1+real(im_m2m5))*5000);
    subplot(2,2,4); imshow(log(1+real(im_16m4))*5000);
    
size = size(image, 1);
center = size/2;
res = 0;
for x = 1:size
  for y = 1:size
  if(sqrt((center-x).^2 + (center - y).^2) < 20)
    res = res .+ p02_modify(img_fft, center-x,center-y);
    end
end
end
figure(2); imshow(res);

%Interpretation des Ergebnisses:
%Bei der Eingabe des fouriertransformierten, zentrierten Bildes liegen die niedrigen Frequenzen in der Bildmitte,
%die hohen Frequenzen am Bildrand. Werden nun die Frequenzen um den Bildmittelpunkt zur Darstellung des Bildes
%im Ortsraum genutzt, gehen Bildinformationen verloren, die nur durch hohe Frequenzen dargestellt werden können. 
%Dabei handelt es sich im die Kanteninformationen, die nur mittels hoher Frequenzen abgetastet werden können.
%Die Funktion selbst stellt daher eine Art Filter dar, welcher das Bild 'weichzeichnet'. Außerdem kann die Funktion
%zur Kompression des Bildes verwendet werden, da ein Teil der Daten abgeschnitten wird.