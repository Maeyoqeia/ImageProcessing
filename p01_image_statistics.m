
function [GWMedian, Pixelanzahl, E, V] = p01_image_statistics(img)
img;
GWMedian = median(img(:));
printf('Grauwertmedian :%i\n', GWMedian);
Pixelanzahl = sum(img(:) >= 50 & img(:) <= 100);
printf('Pixel mit Grauwert zwischen 50 und 100: %i\n',Pixelanzahl);
E = mean(img(:));
printf("Erwartungswert: %i\n", E);
V = var(img(:));
printf("Varianz: %i", V);
endfunction;
