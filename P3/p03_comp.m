pkg load image;

close all; clear; clc;

img = imread('p03_Bild1.png'); 

figure(1);
imshow(img);
title('Eingabe');

%Punktantwort mit Ausdehnung von 17 Pixeln, Winkel: 135 Grad
%Punktantwort liegt in der Mitte des Bildes, von der Mitte aus nach:
%links oben (in M- und N-Richtung minus-Koordinate)
%rechts unten (in M- und N-Richtung plus-Koordinate)
px=17; % Bewegungseinfluss
[M,N] = size(img);
psf = zeros(M,N);
for i = -floor(px/2):floor(px/2)
  psf(floor(M/2)+i,floor(N/2)+i) = 255;
end
%figure(2);
%imshow(psf,[]);
%title('psf || Punktantwort');

%gestoertes Bild und Punktantwort in den Frequenzraum transformieren
fft_psf = fft2(fftshift(psf));
fft_img = fft2(img);

%inverse Filterung mit 1/psf (=Störung)
inverseFiltered = ifft2(fft_img./fft_psf);

figure(3);
imshow(inverseFiltered,[]);
title('nach inverser Filterung');

%Ergebnisinterpretation Teil 1:
% Das Ergebnis wird von einem starken Rauschen überlagert.
% Da das gestoerte Bild sowohl Bewegungsunschaerfe als auch Rauschen beinhaltet,
% wird bei der inversen Filterung zwar die Störung durch die PSF beseitigt,
% der Fehler, der durch den Rauschanteil zustande kommt, jedoch noch verstaerkt.
% Das urspruengliche Rauschen wird ebenfalls mit dem Inversen des Fehlers
% multipliziert (d.h. mit einer Zahl zwischen 0 und 1), wodurch der Wert noch
% vervielfacht wird.

%Test von p03_wien-filt
wienerFilteredImg1 = p03_wien_filt(img, psf, 0);
wienerFilteredImg2 = p03_wien_filt(img, psf, 0.5);
wienerFilteredImg3 = p03_wien_filt(img, psf, 100);
wienerFilteredImg4 = p03_wien_filt(img, psf, 1000);
wienerFilteredImg5 = p03_wien_filt(img, psf, 10000);
wienerFilteredImg6 = p03_wien_filt(img, psf, 100000);

%figure(4);
%    subplot(2,3,1); imshow(wienerFilteredImg1, []);
%    subplot(2,3,2); imshow(wienerFilteredImg2, []);
%    subplot(2,3,3); imshow(wienerFilteredImg3, []);
%    subplot(2,3,4); imshow(wienerFilteredImg4, []);
%    subplot(2,3,5); imshow(wienerFilteredImg5, []);
%    subplot(2,3,6); imshow(wienerFilteredImg6, []);

figure(4);
imshow(wienerFilteredImg4,[]);
title('restauriertes Bild');

%Ergebnisinterpretation Teil 2:
%k = 0: Ergebnis ist wie das verrauschte Eingabebild, da die Funktion des 
%       Wienerfilters aufgrund seiner Formel so nicht zur Anwendung kommt.
%k = 0.5: (sehr) scharf, aber mit hohem Rauschanteil.
%k = 100: sehr scharf, sichtbarer aber geringerer Rauschanteil als vorher.
%k = 1000: akzeptables Bild, sehr scharf, Rauschen nur noch geringfuegig zu sehen
%k = 10000: scharf, leichte Ringing(?)-Artefakte (an der Horizontlinie, bei den Flügeln des Strausses usw.)
%k = 100000: zunehmend unscharf, dafuer kaum noch Rauschen sichtbar. Ringing(?)-Artefakte stark sichtbar

%Folgerung: desto kleiner der k-Wert, desto schaerfer, aber verrauschter das Bild.
%desto groesser der k-Wert, desto unschaerfer, aber mehr Weichzeichnen/weniger Rauschen.
