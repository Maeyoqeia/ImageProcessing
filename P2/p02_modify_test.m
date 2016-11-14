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

%das fouriertransformierte, schon zentrierte Bild wird in die Funktion gegeben. 
%Die wichtigsten Frequenzanteile sind die um den (zentrierten) Ursprung, weil sie den größten Anteil an 
% der Funktion ausmachen.
%Wenn man nun diese Funktionen (als Rückgabewert von modify) wieder aufsummiert, enthält man 
%fast das Originalsignal, weil die wichtigen (ersten) Koeffizienten und FUnktionswerte gespeichert wurden.
%SO kann man ein Bild komprimieren.