%1.
[name, path] = uigetfile();
eval(['cd ', path]);
Bild = imread(name);

figure(1);
imshow(Bild);
title('Bild mit Stoerung');

%2. Punktantwort mit Ausdehnung von 11 Pixeln, Winkel: 45 Grad
%Punktantwort liegt in der Mitte des Bildes, deshalb von der Mitte aus 1 nach rechts, eins nach oben usw.
%45 Grad entsprechen den Pixeln (M,1),(M-1,2),(M-2,3)usw. (M/2-5,N/2+5),(M/2-4, N/2+4)usw.
Ausdehnung=11;
[M,N] = size(Bild);
Punktantwort = zeros(M,N);
for i = -floor(Ausdehnung/2):floor(Ausdehnung/2)
  Punktantwort(floor(M/2)+i,floor(N/2)-i) = 255;
end
%figure(4);
%imshow(Punktantwort,[]);

%3. gestoertes Bild und Punktantwort in den Frequenzraum überführen
fftPunktantwort = fft2(fftshift(Punktantwort));
fftBild = fft2(Bild);

%4. invers filtern mit 1/Punktantwort
inverseFiltered = ifft2(fftBild./fftPunktantwort);

figure(2);
imshow(inverseFiltered,[]);
title('invers gefiltert');

%5. Wiener-Filter
function wfiltered = wienerFilter (G, H, k)
[M,N]=size(G);
A=zeros(M,N);

for u=1:M
  for v=1:N
    A(u,v) = A(u,v) + ((1/H(u,v)) * ((abs(H(u,v)))^2/((abs(H(u,v))^2)+k)));
  end
end

wfiltered = G.*A;
endfunction

%6.
wienerFilteredImg = ifft2(wienerFilter(fftBild, fftPunktantwort, 2000));
figure(3);
imshow(wienerFilteredImg,[]);
title('restauriertes Bild');
%k0 = 0: gleich dem invers gefilterten Bild (Formeltechnisch begründet)
%k1 = 0.5: (sehr) scharf, aber mit hohem Rauschanteil.
%k2 = 100: sehr scharf, sichtbarer aber geringerer Rauschanteil als vorher.
%k3 = 2000: akzeptables Bild, sehr scharf, Rauschen nur noch geringfügig bspw. am Reifen und Heckflügel zu sehen
%k4 = 20000: scharf, möglicherweise ringing-Artefakte (bspw. sich wiederholende Schrftzüge etc)
%k=100000: zunehmend unscharf, dafür kaum noch Rauschen sichtbar. ringing-Artefakte o.Ä. stark sichtbar

%Folgerung: desto kleiner der k-Wert, desto schärfer, aber verrauschter das Bild.
%desto größer der k-Wert, desto unschärfer, aber mehr weichzeichnen/weniger Rauschen.