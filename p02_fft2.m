%Programieraufgabe 2

A=imread('p02_Bild01.bmp');
A = im2double(A);

myfftimg = fftshift(p02_myfft2(A));
fftimg = fftshift(fft2(A));

figure('name', 'myfftimg');
imshow(myfftimg); title('myfftimg');

figure('name', 'fftimg');
imshow(fftimg); title('fftimg');

myfftimg= ifft2(fftshift(myfftimg));
fftimg= ifft2(fftshift(fftimg));

if max(abs(imag(myfftimg(:))))/max(abs(myfftimg(:))) < sqrt(eps)
        figure('name', 'myreal');
        myreal = real(myfftimg);
        imshow(myreal); title('myreal');
end
