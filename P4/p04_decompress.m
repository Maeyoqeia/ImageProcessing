
function image = p04_decompress(img_compressed, quant)
  
  cell_length = length(img_compressed);
  %e) RLE und f) --> RLD
  rld_rev = img_compressed; %_rev steht fuer reversal, Umkehren der Kompression
  for i = 1:1:cell_length
    rld_rev(i,1) = p04_rld(cell2mat(img_compressed(i,1)));
  end

  %d) Rueckgängigmachen der Umsortierung entlang der Nebendiagonale
  zag_rev = rld_rev; %Initialisierung für die richtige Groesse
  for i = 1:1:cell_length
    zag_rev(i,1) = p04_zagzig(cell2mat(rld_rev(i,1)));
  end

  %c) Dequantisierung in jedem Block
  qnt_rev = zag_rev; %Initialisierung für die richtige Groesse
  for i = 1:1:cell_length
    [m, n] = size(quant); %Matrix auf die gleiche Groesse bringen, um .*-Operation durchfuehren zu koennen
    B = zeros(m);
    [a, b] = size(cell2mat(zag_rev(i,1)));
    B(1:a, 1:b) = cell2mat(zag_rev(i,1));
    qnt_rev(i,1) = B.*quant;
  end
  
  %b) IDCT auf den Bloecken
  idct_rev = qnt_rev; %Initialisierung für die richtige Groesse
  for i = 1:1:cell_length
    idct_rev(i,1) = idct2(cell2mat(qnt_rev(i,1)));
  end
  
  image = mat2gray(reshape(cell2mat(idct_rev), [256 256]));

end