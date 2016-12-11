
function vec_enc = p04_rle(vec)
  mn = length(vec);
  run = 1;
  value = vec(1);
  vec_enc = [];

  for i = 2:1:mn
    if (value ~= vec(i))
     temp = [value run];
      vec_enc = cat(2, vec_enc, temp);  %cat() in x-Richtung --> Zeilenvektor
      value = vec(i);
      run = 1;
    else
      run++;  
    end  
  end
  temp = [value run];
  vec_enc = cat(2, vec_enc, temp);
  
end
