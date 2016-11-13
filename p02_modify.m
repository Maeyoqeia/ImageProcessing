%Programieraufgabe 2

function B = p02_modify( A, x, y )
    [M,N] = size(A);
    f =zeros(M,N);
    f(x+(M/2),y+(N/2))=A(x+(M/2),y+(N/2));
    B = ifft2(fftshift(f));
end

