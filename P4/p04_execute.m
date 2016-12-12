% Test von RLE
%vec = [1 1 1 1 1 1 2 3 3 3 4 4 4 4 4 4];
%rl = p04_rle(vec);
%rd = p04_rld(rl);

pkg load image;
pkg load signal;
close all; clear; clc;

image = imread('p04_Bild1.png'); 

figure(1);
imshow(image, []);
title('Eingabe');

% Einlesen quantm
load('p04_quantm.mat');

%Bildkompression mit 16er Bloecken
img_comp_16 = p04_compress(image, 16, quant16);
img_decomp_16 = p04_decompress(img_comp_16, quant16);
figure(2);
imshow(img_decomp_16, []);
title('Bildkompression 16');

%Bildkompression mit 8er Bloecken
img_comp_8 = p04_compress(image, 8, quant8);
img_decomp_8 = p04_decompress(img_comp_8, quant8);
figure(3);
imshow(img_decomp_8, []);
title('Bildkompression 8');

%Aufgabenteil 5 - Kompressionsrate bestimmen
%z.B. durch: Entropie des Originals / Entropie des komprimierten Bildes
ent_orig = entropy(orig);
ent_8 = entropy(img_decomp_8);
ent_16 = entropy(img_decomp_16);

komp8 = ent_orig/ent_8;
komp16 = ent_orig/ent_16;

% Vermutlich wuerde die Qualitaet des Bildes, das mit 16er-Bloecken komprimiert
% wurde, geringer ausfallen als die des Bildes, das mit 8er-Bloecken, wenn man 
% davon ausgeht, dass die auftretenden Artefakte an groesseren/laengeren
% Blockgrenzen aufgrund der Groesse auffaelliger sind, als an kuerzeren Block-
% grenzen. Allerdings kann es auch passieren, dass durch die Kompression einer
% groesseren zusammenhaengenden Flaeche z.B. der Verlauf von Kanten weniger
% Artefakte zeigt und so als angenehmer (qualitativ besser) empfunden wird, als 
% die vielen kleinen Fehler, die bei einer Kompression in kleineren Bloecken 
% auftreten koennen.
