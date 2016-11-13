

function myfftimg = p02_myfft2( grayImage )

    [M,N] = size(grayImage);
    BasisFunktionen=double(ones(M,N)*(-1i*2*pi/M));
    uIndexVector = (0:1:N-1).';
    vIndexVector = (0:1:N-1);
    BasisFunktionen=exp(BasisFunktionen.*(uIndexVector*vIndexVector)); 

    myfftimg=BasisFunktionen*double(grayImage)*BasisFunktionen;


end

