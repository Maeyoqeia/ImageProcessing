function img_compressed = p04_compress(image, block_size, quant)
  
  %a) Einteilung in block_size x block_size grosse Bloecke
  [M,N] = size(image);
  if (mod(M, block_size) ~= 0) | (mod(N, block_size) ~= 0)
    error('Bild nicht einteilbar in gegebene Blockgröße!');
  else  
    verticalBlocks = M/block_size; % Anzahl der horziontalen Bloecke
    horizontalBlocks = N/block_size;  % Anzahl der vertikalen Bloecke
    y_sizes = block_size.*ones(1, verticalBlocks);
    x_sizes = block_size.*ones(1, horizontalBlocks);
    zerlegung = mat2cell(image, y_sizes, x_sizes);
  end  
  
  z_length = length(zerlegung);
  zerlegung_vec = reshape(zerlegung, [z_length*z_length, 1]); %Alle Bloecke als Vektor schreiben
  
  %b) DCT auf den Bloecken
  dct_zerlegung = zerlegung_vec; %Initialisierung für die richtige Groesse
  for i = 1:1:z_length*z_length
    dct_zerlegung(i,1) = dct2(cell2mat(zerlegung_vec(i,1)));
  end
  
  %c) Quantisierung in jedem Block
  qnt_zerlegung = dct_zerlegung; %Initialisierung für die richtige Groesse
  for i = 1:1:z_length*z_length
    qnt_zerlegung(i,1) = cell2mat(dct_zerlegung(i,1))./quant;
  end
 
  
  %d) Umsortierung entlang der Nebendiagonale
  zig_zerlegung = qnt_zerlegung; %Initialisierung für die richtige Groesse
  for i = 1:1:z_length*z_length
    zig_zerlegung(i,1) = p04_zigzag(cell2mat(dct_zerlegung(i,1)));
  end
  
  %e) RLE und f)
  img_compressed = zig_zerlegung; %Initialisierung für die richtige Groesse
  for i = 1:1:z_length*z_length
    img_compressed(i,1) = p04_rle(cell2mat(qnt_zerlegung(i,1)));
  end

end
