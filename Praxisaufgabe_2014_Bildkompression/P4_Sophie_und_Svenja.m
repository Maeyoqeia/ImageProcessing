% P4 Svenja und Sophie | Octave

% 1. Lesen Sie ein Bild interaktiv (Dialog) ein und geben Sie das Bild in einem Fenster aus.

% Einlesen Bild
[name, path] = uigetfile();
bild = imread([path '/' name]);
bild = double(bild);

% Einlesen quantm
load('quantm.mat');

% Ausgeben
figure(1);
imshow(bild, []);
title('Originalbild')

% 2. Unterteilen Sie das Bild in gleich große Blöcke der Größe M x M (M = 8 und M = 16)
[m, n] = size(bild);
blockgr8 = 8;
blockgr16 = 16;

if (mod(m, blockgr16) ~= 0)
    error('Bild nicht einteilbar in gegebene Blockgröße!');
end

% Einteilung Blockgröße 8x8
zeilen8 = ones(1, m/blockgr8).*blockgr8;
spalten8 = ones(1, n/blockgr8).*blockgr8;
block8 = mat2cell(bild, [zeilen8], [spalten8]);     % Matrix unterteilt in 8x8 große Matrizen

% Einteilung Blockgröße 16x16
zeilen16 = ones(1, m/blockgr16).*blockgr16;
spalten16 = ones(1, n/blockgr16).*blockgr16;
block16 = mat2cell(bild, [zeilen16], [spalten16]);


% 3. Überführen Sie die einzelnen Blöcke mithilfe der DCT in den Frequenzraum.
% 4. Führen Sie nun eine Quantisierung der unterschiedlichen Frequenzen durch. 
%    Dazu können sie die Quantisierungsmatrizen „quantm.mat“ verwenden.
% 5. Anschließend sollen die Daten umsortiert (zig-zag scan) und Run Length kodiert werden.
%    Auf die Huffman-Kodierung kann an dieser Stelle verzichtet werden. 
%    Sie können die Funktionen rle_enc() und zigzag() verwenden.

indices8 = linspace(1,(m*n)/blockgr8^2,(m*n)/blockgr8^2);
zigzag8 = zeros(1,(m*n));

indices16 = linspace(1,(m*n)/blockgr16^2,(m*n)/blockgr16^2);
zigzag16 = zigzag8;

% Für Blockgröße 8
j = 0;
for i = indices8
block8{i} = dct2(block8{i})./quant8;              % 3. DCT und 4. Quantisierung
zigzag8(j+1:i*blockgr8^2) = zigzag(block8{i});    % 5. ZigZag Scan
j = i*blockgr8^2;
end

% Für Blockgröße 16
j = 0;
for i = indices16
block16{i} = dct2(block16{i})./quant16;           % 3. DCT und 4. Quantisierung
zigzag16(j+1:i*blockgr16^2) = zigzag(block16{i}); % 5. ZigZag Scan
j = i*blockgr16^2;
end

rle8 = rle_enc(zigzag8);       % Run-Length-Encodierung
rle16 = rle_enc(zigzag16);


%%% 6. Implementieren Sie auch die Rückwärts-Schritte, die nötig sind, 
%%%    um die verlustbehafteten Daten zurück in den Ortsraum zu transferieren.

rleback8 = rle_dec(rle8);    % Run-Length Decodierung
rleback16 = rle_dec(rle16);

j = 0;
for i = indices8
block8{i} = zagzig(rleback8(j+1:i*blockgr8^2));   % ZigZag Zurück
block8{i} = idct2(block8{i});
j = i*blockgr8^2;
end

j = 0;
for i = indices16
block16{i} = idct2(zagzig(rleback16(j+1:i*blockgr16^2)));
j = i*blockgr16^2;
end

kompression8 = cell2mat(block8);     % Matrix zusammenfügen und DCT Rückgängig
kompression16 = cell2mat(block16);


% 7. Visualisieren Sie das Ergebnis für die Blockgröße 8 und 16 mit den unterschiedlichen 
%    Quantisierungsmatrizen und geben sie jeweils die Kompressionsrate an.
% Kompressionsrate: C = n1/n2, wobei n1 und n2 die Anzahl der
% Informationseinheiten sind, um dieselbe Information zu kodieren.
% n1 - Original, n2 - komprimiertes Bild
[M,N]=size(bild);
[A1,A2]=size(rle8);
[B1,B2]=size(rle16);
C1=(M*N)/(A1*A2);
C2=(M*N)/(B1*B2);
% Leider bekommen wir durch einen Fehler im Code falsche Ergebnisse für die Kompressionsraten.
% Diese sollte nicht gleichen und schon gar nicht kleiner als 1 sein, da das hieße, 
% das Bild würde nach der Kompression sogar noch mehr Speicherplatz benötigen als das Original.
% Beide Werte sollten also größer 1 sein, dabei dürfte die Kompressionsrate bei einer 8x8 Quantisierung
% auch kleiner ausfallen als die einer 16x16 Quantisierung. Das liegt daran, dass beim 8x8 die Bildmatrix
% in kleinere Parts eingeteilt wird und somit runs, die die Grenzen einer 8x8 Matrix überschreiten, sich aber
% in einer 16x16 Matrix weiter fortsetzen würden, unterbrochen werden, die dann separat als 2 oder mehr runs
% gespeichert werden müssen. 

figure(2); 
imshow(kompression8, []);
title('Blockgröße 8');
figure(3);
imshow(kompression16, []);
title('Blockgröße 16');