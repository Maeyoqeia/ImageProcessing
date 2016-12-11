
function vec = p04_rld(vec_enc)
  mn = length(vec_enc);
  vec = [];

  for i = 2:2:mn                  %gerade Vektoreintraege enthalten die Run-Lengths
    run = vec_enc(i);
    value = vec_enc(i-1);         %ungerade Eintraege enthalten die Values
    while (run > 0)
      vec = cat(1, vec, value);   %cat() in y-Richtung --> Spaltenvektor
      run--;
    end      
  end
  
end