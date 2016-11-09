pkg load image;

img1 = imread('p01_Bild1.png');
img2 = imread('p01_Bild2.png');

figure(1)
imshow(img1);
title('Mit Rechteck', 'FontSize', 12);

rectangle('Position',[441,106,11,11],...
	'EdgeColor', 'r',...
	'LineWidth', 3,...
	'LineStyle','-');