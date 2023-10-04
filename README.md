# Electric_Veichle_Powertrain
Codes and algorithms for calculating the performance of electric vehicles

This code was developed to evaluate the energy consumed by an electric vehicle in a driving cycle through an iterative energy algorithm.

Work in progress.

## 03/11/2023 -> The parameters utiliezd for the article (DOI: https://doi.org/10.3390/machines11040420) are:
  Driving cycle: Manhattan Bus Cycle
  
  Dati_Veicolo 
    %Declaration of main parameter of the veichle and Driving Cycle
    mass = 5000 ; 		% Massa [Kg]
    Inertia = 0 ;         	% Momento di inerzia componenti rotoriche [Kg/m^2] (se non conosciuta verrà considerato una   maggiorazione del 5%)
    Cd = 0.6 ;		% Drag Coefficent [-]
    A = 6 ;	% Area frontale [m^2]
    murr = 0.01 ;  	% Coefficente resistenza al rotolamento [-]
    r = 0.366 ; %225/75 R17.5
    lambda = 1.05; 

    niGear = 0.95; % efficenza trasmissione 

    rho = 1.2; % [Kg/m3]

    thetag = 0; % gradi
    theta = thetag*pi/180; % conversione in radianti
    
  Forze
    %% Forze
    Kinematics;
    Dati_Veicolo;
    %% Dichiarazione delle Forze

    % Resistenza Rotolamento
    F_ReistRotol = murr*mass*9.81; % [N]

    % Resistenza Aerodinamica
    F_Aereodin = 0.5*rho*A*Cd*Vel.^2; % [N]

    % Resistenza Collinare
    F_Coll = mass*9.81*sin(theta); % [N]

    % Resistenza Inerziale 
    if  (Inertia==0)
        % Resitenza all'accelerazione lineare maggiorata del 5%
        F_Inerz = mass*Acc*lambda;
        Fwa=0;
    else
        % Resitenza all'accelerazione lineare
        Fla = mass*Acc(C);
        % Resistenza all'accelerazione rotazionale
        Fwa=Inertia*G*Acc/niGear/r^2;
    end

    Ftot = F_ReistRotol + F_Aereodin + F_Coll + F_Inerz; %[N]
    Ptot = Ftot.*Vel; % [Watt]

Motor
  TR_09028_W400
  TR_12030_W400
