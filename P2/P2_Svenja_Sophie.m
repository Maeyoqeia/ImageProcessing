%%% Praktische Aufgabe Nr. 2
%%% von Sophie und Svenja

%Eingabe = "Bitte geben Sie den Pfad zu p2.bmp an. :";
%Ans = input(Eingabe, 's');
%Pic = imread(Ans);

% 1.
bild = imread("lena256.bmp");
% bild2 = imread("pic1.bmp");
figure(1);
imshow(bild,[]);
title('Originalbild');
[M, N] = size(bild);
% 2., 3.
% 2D Fast Fourier Transformation (fft2), geordnet um Mittelpunkt(fftshift)
picft = log(fftshift(fft2(bild, M, N)));
figure(2);
title('FFT');
imshow(picft,[]);

%% 4. siehe myfft2.m
figure(3);
mybild = myfft2(bild);
imshow(mybild, []);

%% 5. siehe ftback.m

%% 6. Testen Sie Ihre Funktion (aus 5.) mit den Koordinaten (2,6), 
%% (-2,-6), (2,-6) und (14,-3) und geben Sie die Ergebnisse in einem 
%% Fenster mit 4 Teilbildern aus.
%%-> subplot(Anz. Zeilen, Anz. Spalten, aktuelle Z/S)

test1 = ftback(picft,2,6);
test2 = ftback(picft,-2,-6);
test3 = ftback(picft,2,-6);
test4 = ftback(picft,14,-3);
figure(4);
subplot(2,2,1);
imshow(test1,[]);
title("Koordinaten: (2,6)");
subplot(2,2,2);
imshow(test2,[]);
title("Koordinaten: (-2,-6)");
subplot(2,2,3);
imshow(test3,[]);
title("Koordinaten: (2,-6)");
subplot(2,2,4);
imshow(test4,[]);
title("Koordinaten: (14,-3)");


%% 7. Geben Sie der Funktion (aus 5.) die Werte aller Koordinaten, 
%% die einen Abstand kleiner als 18 vom Ursprung haben, nacheinander 
%% als Input. Addieren Sie die Teil-Ergebnisse und zeigen Sie sie an.
%%%% f(mid,mid)  |f|<18
%%%% testen f(mid-18, mid+18) ... f(mid+18, mid-18)
Ausschnitt = zeros(256,256); 

for l1=(1:36)
  for l2=(1:36)
  if (sqrt((18-l2)^2 + (18-l1)^2) <= 18)
  reconstruct = ftback(picft,l1,l2);
  Ausschnitt = Ausschnitt + reconstruct;
  endif
  endfor
endfor

figure(5);
imshow(Ausschnitt,[]);