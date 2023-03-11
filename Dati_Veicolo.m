%Declaration of main parameter of the veichle and Driving Cycle
mass = 7500 ; 		% Massa [Kg]
Inertia = 0 ;         	% Momento di inerzia componenti rotoriche [Kg/m^2] (se non conosciuta verrà considerato una maggiorazione del 5%)
Cd = 0.6 ;		% Drag Coefficent [-]
A = 6 ;	% Area frontale [m^2]
murr = 0.02 ;  	% Coefficente resistenza al rotolamento [-]
r = 0.366 ; %225/75 R17.5
lambda = 1.05; 
        
niGear = 0.95; % efficenza trasmissione 
        
rho = 1.2; % [Kg/m3]
        
thetag = 0; % gradi
theta = thetag*pi/180; % conversione in radianti
