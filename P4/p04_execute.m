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

%Bildkompression
p04_compress(image, 16, quant16);