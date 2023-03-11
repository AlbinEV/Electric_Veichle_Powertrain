%% Parametri motore da inserire
% [RPM}
omegaMax = 12000;
omegaBase = 2984; 
% [Nm]
Tmax = 288;
Tnom = 135;
% [kW]
Pmax=90;
Pnom=55;

%% Ricerca Parametri Motore

kc = 0.08 ; % Perdite rame
ki = 0.01; % Perdite ferro
kw = 0.000014; % Perdite Meccaniche
ConL = 400; % Perdite costanti