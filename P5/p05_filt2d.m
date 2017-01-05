function img_filt = p05_filt2d(image,kernel)

%Kernelgröße für Frequenzraum anpassen
[m n] = size(image);
[a b] = size(kernel);
x_start = floor(m/2)-floor(a/2);
x_end = floor(m/2)+floor(a/2);
y_start = floor(n/2)-floor(b/2);
y_end = floor(n/2)+floor(b/2);
A = zeros(m,n);
A(x_start:x_end, y_start:y_end) = flipud(fliplr(kernel));%siehe Hinweis Aufgabenteil 1 (weil Konvolution verlangt, keine Korrelation)

%Transformation in den Fourierraum
imagefft = fft2(fftshift(image));
kernelfft = fft2(fftshift(A));
img_filtered = imagefft.*kernelfft;

img_filt = ifftshift(ifft2(img_filtered));