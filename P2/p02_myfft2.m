function img_myfft = p02_myfft2(img)
    [m,n] = size(img);
    %m = n
    
    %preprocess image - shift frequencies to the center 
    %http://dsp.stackexchange.com/questions/9039/centering-zero-frequency-for-discrete-fourier-transform
    D = ones(m) * -1;
    vec3 = [0:m-1];
    vec4 = vec3';
    E = D .^ (vec4 .+ vec3); % E is a 1, -1 alternating matrix (-1)^(2m)
    img1 = img .* E;
    
    %use dft matrix to implement ft
    vec1 = [0:m-1];
    vec2 = vec1';
    A = (vec1 .* vec2);
    A = A * ((-2*1i*pi) /m); 
    B = exp(A);
    %B is the general DFT transform matrix
    %just use it on the rows and columns of img1 (http://fourier.eng.hmc.edu/e161/lectures/fourier/node11.html)
    C = B * img1 * B;
    
    img_myfft = C;
   % figure(1); imshow(C);
    %figure(2); imshow(fftshift(fft2(img)));

    
end