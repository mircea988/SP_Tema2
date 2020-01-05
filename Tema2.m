%Tema 2
%Numarul din lista = 9
%Semnal dreptugnhiular cu P=40, N=50 si durata=9.

D=9;
N=50;
P=40;
F=1/P;
t=0:0.02:P-0.02; 
w0=2*pi*F;

%generez un vector cu zerouri:
x = zeros(1,size(t,2));

%aranjez vectorul
x(t<=D)=1;
x(t>D)=-1;
x(t>P-D)=1;

%seria
for k = -N:N
    xt = x;
    xt = xt.*exp(-j*k*w0*t);
    X(k+51) = trapz(t,xt); 
end

%reconstruirea semnalului (aproximare)
x_aprox(1:length(t)) = 0;
for const = 1:length(t);
for k = -N:N
x_aprox(const) = x_aprox(const) + (1/P)*X(k+N+1)*exp(j*k*w0*t(const));
end
end

%semnalul dat cu coeficientii seriei
figure(1);
plot(t,x); %afisez mai intai x(t)
title('x(t) si semnalul alcatuit prin esantionare');
hold on
plot(t,x_aprox,'r'); 
xlabel('Timp (s)');
ylabel('Amplitudine');

fr = -N*F:F:N*F; %vectorul de frecvente pentru afisarea semnalului
figure(2);
stem(fr,abs(X)); 
title('Spectrul x(t)');
xlabel('Frecventa (Hz)');
ylabel('|X|');

%Seria Fourier este reprezentarea semnalului sub forma de suma pana la
%infinit din: sin si cos (SFT),exponentiale (SFE), sau armonice
%(SFA). Din cursuri am observat ca semnalul poate fi analizat pe esantioane
%si aproximat astfel incat sa obtinem un model cat mai apropiat de cel real
%si o eroare cat mai mica.