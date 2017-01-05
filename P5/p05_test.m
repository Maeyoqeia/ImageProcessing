pkg load image;

close all; clear; clc;
%read picture and convert to double
img = imread('p05_Bild01.bmp'); 
image = im2double(img);

%Originalbild
figure(1); imshow(image);

%a) Sobel-Filterkern
a = [1 2 1]';
b = [-1 0 1];
sobelkernelx = a*b;
sobelkernely = b'*a';

%b) Mittelwert-Filterkern
filter_M3 = 1/(3*3) * ones(3,3);
filter_M7 = 1/(7*7) * ones(7,7);
filter_M11 = 1/(11*11) * ones(11,11);

% OR Funktionsaufruf und Zeitmessung
start0 = tic;
img0 = p05_conv2d(image, sobelkernelx);
zeit0 = toc(start0);

start1 = tic;
img1 = p05_conv2d(image, sobelkernely);
zeit1 = toc(start1);

start2 = tic;
img2 = p05_conv2d(image, filter_M3);
zeit2 = toc(start2);

start3 = tic;
img3 = p05_conv2d(image, filter_M7);
zeit3 = toc(start3);

start4 = tic;
img4 = p05_conv2d(image, filter_M11);
zeit4 = toc(start4);

% Ausgabe fuer Ortsraum
figure(2);
subplot(2,2,1);
imshow(img0, []);
title(['im OR gefiltert: Kanten (Sobel,x-Richtung) 3x3 ',char(10),'Die Berechnungsdauer betraegt: ',num2str(zeit0),' s']);
subplot(2,2,2);
imshow(img1, []);
title(['im OR gefiltert: Kanten (Sobel,y-Richtung) 3x3 ',char(10),'Die Berechnungsdauer betraegt: ',num2str(zeit1),' s']);

figure(3);
subplot(2,3,1);
imshow(img2, []);
title(['im OR gefiltert: Glaettung (Mittelwert) 3x3 ',char(10),'Berechnungsdauer ',num2str(zeit2),' s']);
subplot(2,3,2);
imshow(img3, []);
title(['im OR gefiltert: Glaettung (Mittelwert) 7x7 ',char(10),'Berechnungsdauer ',num2str(zeit3),' s']);
subplot(2,3,3);
imshow(img4, []);
title(['im OR gefiltert: Glaettung (Mittelwert) 11x11 ',char(10),'Berechnungsdauer: ',num2str(zeit4),' s']);


% FR Funktionsaufruf und Zeitmessung
start0 = tic;
img0 = p05_filt2d(image, sobelkernelx);
zeit0 = toc(start0);

start1 = tic;
img1 = p05_filt2d(image, sobelkernely);
zeit1 = toc(start1);

start2 = tic;
img2 = p05_filt2d(image, filter_M3);
zeit2 = toc(start2);

start3 = tic;
img3 = p05_filt2d(image, filter_M7);
zeit3 = toc(start3);

start4 = tic;
img4 = p05_filt2d(image, filter_M11);
zeit4 = toc(start4);

% Ausgabe fuer Frequenzraum
figure(2);
subplot(2,2,3);
imshow(img0, []);
title(['im FR gefiltert: Kanten (Sobel,x-Richtung) 3x3 ',char(10),'Berechnungsdauer: ',num2str(zeit0),' s']);
subplot(2,2,4);
imshow(img1, []);
title(['im FR gefiltert: Kanten (Sobel,y-Richtung) 3x3 ',char(10),'Berechnungsdauer: ',num2str(zeit1),' s']);

figure(3);
subplot(2,3,4);
imshow(img2, []);
title(['im FR gefiltert: Glaettung (Mittelwert) 3x3 ',char(10),'Berechnungsdauer: ',num2str(zeit2),' s']);
subplot(2,3,5);
imshow(img3, []);
title(['im FR gefiltert: Glaettung (Mittelwert) 7x7 ',char(10),'Berechnungsdauer: ',num2str(zeit3),' s']);
subplot(2,3,6);
imshow(img4, []);
title(['im FR gefiltert: Glaettung (Mittelwert) 11x11 ',char(10),'Berechnungsdauer: ',num2str(zeit4),' s']);

%Beoachtung: Entgegen unserer Erwartung, dass ein 3x3 Filterkern weniger Berechnungszeit benoetigt
%als ein größerer Filterkern, zeigen mehrmalige Durchlaeufe, dass pro Durchlauf 3x3, 7x7 und 11x11 um die gleichen Werte 
%schwanken. Dabei ist mal die Berechnung des 3x3, 7x7 oder 11x11 Kerns schneller.
%Vermutlich zeigen sich deutliche Unterschiede erst bei wesentlich groesseren Filterkernen.
%Die Filterung im Frequenzraum erfolgt durch die Multiplikation wesentlich schneller als durch Konvolution im Ortsraum.