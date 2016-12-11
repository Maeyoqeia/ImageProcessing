%1.
[name, path] = uigetfile();
Bild = imread([path '/' name]);

figure(1);
imshow(Bild);
title ('Original');

%2.
[m n] = size(Bild);
Blockgr1 = 8;
Blockgr2 = 16;
% Für Blöcke der Größe 8x8
laengs = ones(1,m/Blockgr1);
laengs = laengs.*Blockgr1;
runter = ones(1, n/Blockgr1);
runter = runter.*Blockgr1;
% Für Blöcke der Größe 16x16
laengs2 = ones(1,m/Blockgr2);
laengs2 = laengs2.*Blockgr2;
runter2 = ones(1, n/Blockgr2);
runter2 = runter2.*Blockgr2;

% Teile Matrix "Bild" in 44x64 bzw. 22x32 Blöcke der Größe 8 bzw. 16
Bloecke1 = mat2cell(Bild, [laengs], [runter]);
Bloecke2 = mat2cell(Bild, [laengs2], [runter2]);

%3. Blöcke mit DCT in Frequenzraum überführen
numlaengs = linspace(1,44, 44);
numrunter = linspace(1,64, 64);

for i = numlaengs
  for j = numrunter
    dctBloecke1(numlaengs, numrunter) = dct2(Bloecke1(numlaengs, numrunter));
  end
end  

%
%numlaengs2 = linspace(1,44);
%numrunter2 = linspace(1,64);
%dctBloecke2 = dct2(Bloecke2(numlaengs2,numrunter2));