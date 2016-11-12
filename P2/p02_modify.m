function img_mod = p02_modify(img_fft, x, y)
[u,v] = size(img_fft);
img_mod = zeros(u,v);
img_mod(u/2 + x,v/2 + y) = img_fft(u/2 + x,v/2 + y);

img_mod = ifft2(ifftshift(img_mod));
end