%Programieraufgabe 2

clear();

A=imread('p02_Bild01.bmp');
A = im2double(A);

A= fftshift(fft2(A));

[m,n] = size(A);
B =zeros(m,n);
i=0;
j=0;

while (i<24)
    while (j<24)
        dist=sqrt(i^2+j^2);
        if dist<=24
            if (i==0) && (j==0)
                B=B+p02_modify(A,i,j);
            elseif i==0
                B=B+p02_modify(A,i,j)+p02_modify(A,i,-j);
            elseif j==0
                B=B+p02_modify(A,i,j)+p02_modify(A,-i,j);
            else
                B=B+p02_modify(A,i,j)+p02_modify(A,i,-j)+p02_modify(A,-i,j)+p02_modify(A,-i,-j);
            end
        end
       j=j+1; 
    end
    i=i+1;
end

figure();
imshow(B);
