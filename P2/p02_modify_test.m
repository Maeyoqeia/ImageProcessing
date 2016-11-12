pkg load image;

close all; clear; clc;
%read picture and convert to double
img = imread('p02_Bild01.tif'); 
image = im2double(img);
size = size(image, 1);
image = fftshift(fft2(image));

im_25 = p02_modify(image, 2, 5);
im_m25 = p02_modify(image, -2, 5);
im_m2m5 = p02_modify(image, -2, -5);
im_16m4 = p02_modify(image, 16, -4);

figure(2);
    subplot(2,2,1); imshow(log(1+ real(im_25))*5000);
    subplot(2,2,2); imshow(log(1+real(im_m25))*5000);
    subplot(2,2,3); imshow(log(1+real(im_m2m5))*5000);
    subplot(2,2,4); imshow(log(1+real(im_16m4))*5000);


    %{
res = 0;
for i= (1:1:39)
  for j = (1:1:39)
res = res .+ p02_modify(image,i,j);
end
end
%}

center = size/2;
res = 0;
for x = 1:size
  for y = 1:size
  if(sqrt((center-x).^2 + (center - y).^2) < 20)
    res = res .+ p02_modify(image, center-x,center-y);
    end
end
end
figure(5); imshow(res);
%das fouriertransformierte, schon zentrierte Bild wird in die Funktion gegeben. 
%Die wichtigsten Frequenzanteile sind die um den (zentrierten) Ursprung, weil sie den größten Anteil an 
% der Funktion ausmachen.
%Wenn man nun diese Funktionen (als Rückgabewert von modify) wieder aufsummiert, enthält man 
%fast das Originalsignal, weil die wichtigen (ersten) Koeffizienten und FUnktionswerte gespeichert wurden.
%SO kann man ein Bild komprimieren.