
function [GWMedian, Pixelanzahl, E, V] = p01_image_statistics(img)
img;
GWMedian = median(median(img));
printf('Grauwertmedian :%i\n', GWMedian);
Pixelanzahl = sum(sum((img > 50) & (img < 100)));
printf('Pixel mit Grauwert zwischen 50 und 100: %i\n',Pixelanzahl);
E = mean(mean(img));
printf("Erwawrtungswert: %i\n", E);
V = var(var(img));
printf("Varianz: %i", V);
endfunction;
