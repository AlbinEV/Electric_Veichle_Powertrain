clc; clear;

% Richiamo script utili al calcolo
Forze;
Dati_Motore;


G = 18; % Rapporto di trasmissione



Energia1 = zeros(N,1);
EnergiakWh_NO_EFFICIENZA = zeros(N,1);

%% Considero solo la potenza positiva
for i=1:N
    if Ptot(i)<0
        Ptot(i) = 0;
    end
end

%% Calcolo consumo energetico su di un ciclo di guida - NO EFFICIENZA
for i=2:N
    Energia1(i)=Ptot(i)*TimeStep(i)+Energia1(i-1);
end
EnergiakWh_NO_EFFICIENZA=Energia1/3600/1000;


%% Calcolo con efficienza
Energia2 = zeros(N,1);
EnergiakWh_SI_EFFICIENZA = zeros(N,1);

Omega_Motore = G*Vel/r; % Calcolo velocità di rotazione del motore [rad/s]
niGear = 0.95; % Efficienza cambio

% Calcolo efficenza motore 
Ttot = fillmissing(Ptot./Omega_Motore,'constant',0);

Prame = kc*Ttot.^2; % Potenza persa rame
Pferro = ki*Omega_Motore; % Potenza persa ferro
Pcine = kw*Omega_Motore.^3; % Potenza persa cinetica
% Perdite costanti - solo quando il veicolo è in movimento
for i=1:N
    if Vel > 0
        Pcost(i,1) = ConL;
    else
        Pcost(i,1) = 0;
    end
end

Ploss = Prame + Pferro + Pcine + Pcost;
niMotor = fillmissing(Ptot./(Ptot+Ploss),'constant',0); % Efficienza motore

for i=2:N
    Energia2(i)=fillmissing(Ptot(i)*TimeStep(i)./niMotor(i),'constant',0)+Energia2(i-1);
end
EnergiakWh_SI_EFFICIENZA=Energia2/3600/1000;

diffe=fillmissing(EnergiakWh_SI_EFFICIENZA-EnergiakWh_NO_EFFICIENZA,'constant',0);





    








