clc
clear all
close all

%Conditii Initiale, declararea variabilelor
T=40;
N=50;
D=7;
eta=D/T;

%Crearea bazei de timp pe un numar de 5 perioade, rezolutia respecta
%teorema de esantionare
res=1/(2*T);
tmax=5*T;
t=0:res:tmax-res;

%Apelarea functie de crearea a semnalului dreptunghiular, stocarea
%semnalului original
signal=rectangular(eta,t,T);

%Calcularea primilor 50 de coeficienti ai termenilor seriei Fourier
%complexe
for i=1:N
    X(i)=integral(@(t)rectangular(eta,t,T).*exp((-j*i*2*pi.*t)/T),0,T);
end

%Calculul componentei continue
X0=integral(@(t)rectangular(eta,t,T),0,T);

%Constructia vectorului de coeficienti, adaugarea elementelor negative,
%prin conjugare
for i=N:-1:1
    Xf(N-i+1)=conj(X(i));
end

%Adaugarea in vector a componentei continue
Xf(N+1)=X0;

%Adaugarea in vector a componentelor pozitive
for i=1:N
    Xf(N+i+1)=X(i);
end

%Declararea vectorului pentru semnalul reconstruit
x_rep=zeros(1,length(t));


%Reconstructia semnalului prin adunarea termenilor seriei Fourier complexe
%pentru fiecare esantion de timp al semnalului original
for i=1:length(t)
    for k=1:2*N+1
        x_rep(i)=x_rep(i)+Xf(k)*exp((j*(k-N-1)*2*pi*t(i))/T);
    end
    x_rep(i)=x_rep(i)/T;
end

%Afisarea rezultatelor

amp_spec_index=-50:50;
stem(amp_spec_index, abs(Xf),'x','linewidth',2)
title('Spectrul de amplitudini al semnalului dat','fontsize',20,'fontweight','bold')
grid on
xlabel('k','fontsize',15,'fontweight','bold')
ylabel('|X_k|','fontsize',15,'fontweight','bold')
hold on
plot(amp_spec_index, abs(Xf),'r--','linewidth',2)
set( gca, 'Color', [0.95,0.95,0.95] );

figure()
plot(t,signal,'g')
hold on
plot(t,x_rep,'r--');
grid on
set( gca, 'Color', [0.95,0.95,0.95] );
title('Semnalul original + Reconstructia sa utilizand Seria Fourier Complexa','fontsize',20,'fontweight','bold')
legend('Semnalul Original','Semnalul Reconstruit')
xlabel('t','fontsize',15,'fontweight','bold')
ylabel('x(t)','fontsize',15,'fontweight','bold')