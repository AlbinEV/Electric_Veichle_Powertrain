%% Forze
Kinematics;
Dati_Veicolo;
%% Dichiarazione delle Forze

% Resistenza Rotolamento
F_ReistRotol = murr*mass*9.81; % [N]

% Resistenza Aerodinamica
F_Aereodin = 0.5*rho*A*Cd*Vel.^2; % [N]

% Resitenza Collinare
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



