%% DEFINZIONE DEI DATI MOTORE
% Inserire i valori caratteristici del motore 
% ID_Motore: 

%TMPW32_27_8;
%TMF37_21_4;
%TM4_MOTIVE_MV360;

TR_09028_W400;
%TR_12030_W400;
%AMEX132L;

NumMot=2;             % Numeri di motori 

TmaxC=Tmax;              % Coppia motore massima [Nm]
    %Tmax=2250;      % INSERIMENTO MANUALE
gmax=omegaMax;    % Giri massimo motore [RPM]
    %gmax=5400;    % INSERIMENTO MANUALE
gbase=omegaBase;  % Giri base motore [RPM]
    %gbase=1103;   %INSERIMENTO MANUALE
%Pmax2=Pmax;           % Potenza massima singolo motore [kW]
    %Pmax2=260;      %INSERIMENTO MANUALE
    
% Valori per il calcolo del rendimento del motore 
%kc=0.01; % Perdite rame
%ki=0.8; % perdite traferro
%kw = 0.0002; % Perdite aria
%ConL = 800; % Perdite elettroniche costanti

%% Conversioni
PmaxC=Pmax*NumMot;
Pmax=repmat(Pmax*1000,N,1);
