
function img_rest = p03_wien_filt(img_blur, psf, k)

%gestoertes Bild und Punktantwort in den Frequenzraum transformieren
H = fft2(fftshift(psf));
fft_img = fft2(img_blur);

[M,N]=size(img_blur);
A=zeros(M,N);

for u=1:M
  for v=1:N
    A(u,v) = A(u,v) + ((1/H(u,v)) * ((abs(H(u,v)))^2/((abs(H(u,v))^2)+k)));
  end
end

img_rest = ifft2(fft_img.*A);

endfunction
