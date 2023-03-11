clc; clear;

% Richiamo script utili al calcolo
Forze;
Dati_Motore;

GMin = 5;
GMax = 50;

Energia = zeros(N,1);
EnergiakWh = zeros(N,1);
EnergiakWh_END = zeros(GMax,1);
Iteration = 0;

%% Considero solo la potenza positiva
for i=1:N
    if Ptot(i)<0
        Ptot(i) = 0;
    end
end
i=0;

i=0;

for G=GMin:GMax
    Iteration = Iteration+1;
    Omega_Motore = G*Vel/r; % Calcolo velocità di rotazione del motore [rad/s]
    %----------------------- Check motor speed
    if max(Omega_Motore)>omegaMax/9.55
        error('max rotational speed reached')
    end

    niGear = 0.95; % Efficienza cambio
    
    % Calcolo efficenza motore 
    Ttot = fillmissing(Ptot./Omega_Motore,'constant',0);
    
    Prame = kc*(Ttot.^2); % Potenza persa rame
    Pferro = ki*Omega_Motore; % Potenza persa ferro
    Pcine = kw*(Omega_Motore.*Omega_Motore.*Omega_Motore); % Potenza persa cinetica
    
    for i=1:N
        if Ptot(i) == 0
            Prame(i)=0; % Attenzione -> lui genera picchi molto elevati 
            % dovuti alla coppia richiesta. Nel caso 
            Pferro(i)=0;
            Pcine(i)=0;
        end
    end

    den = 20;
    num = 0;
    for i=1:N
        if Ptot(i)>1000
            if num < den
                Pcost(i,1) = ConL*num/den;
                num = num+1;
            else
                Pcost(i,1) = ConL;
            end
        else
            Pcost(i,1) = 0;
            num=0;
        end
    end
    %questo pezzo di codice è praticamente inutile in quanto non riesce a
    %smorzare l'effetto delle perdite nel rame -> si consiglia di non
    %usarelo
% %     num=1;
% %     den = 200;
% %     toll = 10;
% %     for i=2:N
% %         diff(i) = Prame(i)-Prame(i-1);
% %         if diff(i)>toll
% %             P=Prame(i);
% %             if num < den
% %                 Prame(i,1) = P*num/den;
% %                 num = num+1;
% %             else
% %                 Prame(i,1) = P;
% %             end
% %         end
% %     end
            

    Ploss = Prame + Pferro + Pcine + Pcost;
    Pin = Ptot+Ploss;

    niMotor = fillmissing(Ptot./Pin,'constant',0); % Efficienza motore


    %%  
    for ii=2:N
        if Omega_Motore(ii)<(omegaBase/9.55)
            TmaxVer = TmaxC;
            PmaxVer = Omega_Motore(ii)*TmaxC;
            if (Ttot(ii-1)>TmaxVer | Pin(ii-1)>PmaxVer)
                warning('max torque/power reached 1')
            end
        else 
            TmaxVer = PmaxC*1000./Omega_Motore(ii);
            PmaxVer = PmaxC*1000;
            if (Ttot(ii-1)>TmaxVer | Pin(ii-1)>PmaxVer)
                warning('max torque/power reached 2')
            end
        end
        Tplot(ii,1)=TmaxVer;
        Pplot(ii,1)=PmaxVer;
    end
    
    %%
    for i=2:N
        Energia(i)=fillmissing(Ptot(i)*TimeStep(i)./niMotor(i)./niGear,'constant',0)+Energia(i-1);
    end
    i=0;

    EnergiakWh_END(G,1)=Energia(end)/3600/1000;
    
end


    


