
function img_rest = p03_wien_filt(img_blur, psf, k)

%gestoertes Bild und Punktantwort in den Frequenzraum transformieren
H = fft2(fftshift(psf));
fft_img = fft2(img_blur);

[M,N]=size(img_blur);
W=zeros(M,N);

one = ones(M,N);
first = one./H;
abs = abs(H).^2
abs2 = abs .+ k;
W = first .* (abs./abs2);

img_rest = ifft2(fft_img.*W);

end
