clear;
close;
% 1. Bild interaktiv einlesen und ausgeben

orig = double(imread('hockey.bmp')); % Hilfsaufruf zum Vereinfachen

%[bild, pfad] = uigetfile();
%orig = double(imread([pfad '/' bild]));
%figure('Name','Original - Bild','NumberTitle','off');imshow(orig); title('Original');
load('quantm.mat');

% 2. In gleich große Blöcke M1 = 8x8, M2 = 16x16 unterteilen
[M,N] = size(orig);
Mm8 = M/8;
Nn8 = N/8;
vm8 = ones(1,Mm8).*8;
vn8 = ones(1,Nn8).*8;
cell8 = mat2cell(orig,vm8,vn8);

Mm16 = M/16;
Nn16 = N/16;
vm16 = ones(1,Mm16).*16;
vn16 = ones(1,Nn16).*16;
cell16 = mat2cell(orig,vm16,vn16);

% 3. Überführen sie es mit DCT in den Frequenzraum
% 4. Quantisieren durch Quantisierungsmatrix
% 5. Zigzag umsortierung und Runlength anwenden
% für 8x8 Blöcke

% für 8
for i = 1:(M/8)*(N/8)
cell8{i} = round(dct2(cell8{i})./quant8);
%cell8{i} = dct2(cell8{i})./quant8;
end

laenge8 = 0;
for i = 1:(M/8)*(N/8)
cell8{i} = rle_enc(zigzag(cell8{i}));
laenge8 = laenge8 + length(cell8{i});
end

% für 16
for i = 1:(M/16)*(N/16)
cell16{i} = round(dct2(cell16{i})./quant16);
%cell16{i} = dct2(cell16{i})./quant16;
end

laenge16 =0;
for i = 1:(M/16)*(N/16)
cell16{i} = rle_enc(zigzag(cell16{i}));
laenge16 = laenge16 + length(cell16{i});
end

% 6. Decodieren
% für 8
for i = 1:(M/8)*(N/8)
cell8{i} = zagzig(rle_dec(cell8{i}));
end

for i = 1:(M/8)*(N/8)
cell8{i} = idct2(cell8{i}.*quant8);
end
% für 16
for i = 1:(M/16)*(N/16)
cell16{i} = zagzig(rle_dec(cell16{i}));
end

for i = 1:(M/16)*(N/16)
cell16{i} = idct2(cell16{i}.*quant16);
end


ready8 = cell2mat(cell8);
figure(1); imshow(ready8,[]);

ready16 = cell2mat(cell16);
figure(2); imshow(ready16,[]);

figure(3); imshow(orig,[]);

% Kompressionsrate Bestimmen
% Möglichkeit 1: die Länge der Runlength-Kodierung durch die des Bildes
% teilen
alt = M*N;
comp8 = (M*N)/laenge8;
comp16 = (M*N)/laenge16;

% Möglichkeit 2: die Entropie beider Bilder berechnen und die des neuen
% durch das Originale teilen
ent_orig = entropy(orig);
ent_8 = entropy(ready8);
ent_16 = entropy(ready16);

komp8 = ent_orig/ent_8;
komp16 = ent_orig/ent_16;