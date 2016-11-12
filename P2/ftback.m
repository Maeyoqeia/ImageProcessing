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
## @deftypefn {Function File} {@var{ftb} =} ftback (@var{A}, @var{x}, @var{y})
##
## @seealso{}
## @end deftypefn

## Author: svenja <svenja@SV>
## Created: 2014-11-11

function ftb = ftback (A, x, y)
%% 5. Schreiben Sie eine Funktion, der ein zentriertes 
%% fouriertransformiertes Bild A und zwei Koordinaten �bergeben werden. 
%% Die Funktion soll eine neue Matrix B erzeugen, die an der durch die 
%% Koordinaten spezifizierten Stelle den gleichen Wert wie A hat und 
%% sonst Null ist. Bild B soll nun in den Ortsraum zur�cktransformiert 
%% und zur�ckgegeben werden.

% Koordinatensystem von [-180;180] in [1; 256] umrechnen
x=(256/2)+x;
y=(256/2)+y;
B = zeros(size(A));
B(x,y) = A(x,y);

% Log mit exp r�ckg�ngig machen
e = exp(1);
backLog = e.^(B); %log r�ckg�ngig machen
backShift = ifftshift(backLog); 
ftb = ifft2(backShift);
%ftb = abs(back);

endfunction
