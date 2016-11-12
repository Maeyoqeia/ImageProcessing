## Copyright (C) 2014 svenja
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{fftimg} =} myfft2 (@var{img})
##
## @seealso{}
## @end deftypefn

## Author: svenja <svenja@SV>
## Created: 2014-11-11

function fftimg = myfft2 (img)

bild = imread("lena256.bmp");
% unit8 in double f�r Berechnungen
bild = double(bild);

% m von 1 bis 256 als Vektor
m = linspace(1,256,256);
% Matrix 256x256 gef�llt mit e
e = ones(256,256);
e(:,:) = exp(1);
% mn Vektor m punktweise mit -2pi*i/N multipliziert
mn = m.*(-2i*pi/256);
expo = ones(256,256);                  % m=1 2 3
% Matrix mit m in Zeilen, u in Spalten ( u=1 2 3
u = expo.*m';                           %  2 4 6
expo = u.*mn;                           %  3 6 9
expo = e.^expo;


Fv = zeros(256,256);
Fu = Fv;
Fuv = Fv;
Fv = bild*expo';
Fu = Fv'*expo;
Fu = abs(log(Fu'));
Fuv(1:128,1:128)=Fu(129:256,129:256);
Fuv(1:128, 129:256) = Fu(129:256,1:128);
Fuv(129:256,1:128)=Fu(1:128,129:256);
Fuv(129:256,129:256) = Fu(1:128,1:128);
fftimg=Fuv;


%% Schreiben Sie eine Funktion fftimg = myfft2(img), die ein Bild in den 
%% Fourierraum transformiert. Vergleichen Sie sie mit den Ergebnissen 
%% der Matlab-Funktion. Die Berechnungsvorschrift lautet f�r die 
%% Image-Pixel f(m,n) und die Fouriertransformierte 
%% F(u,v)= sumM, sumN f(m,n)*exp(-i*2*pi*(um/M + vn/N))
%% Benutzen Sie (m�glichst) keine for-Schleifen!



endfunction
