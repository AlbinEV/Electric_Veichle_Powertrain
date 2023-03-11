
%% Importing the Driving Cycle and calculate the velocity and acceleration needed 
    % Attenzione: le velocità utilizzate nei altri codici sono le vel,acc e
    % jerk mentre con ref servono solo internamente
%% Importing driving cycle
DrivingCycle = readtable("Cilci di guida\Manhattan_Bus_Cycle10Hz.csv");
N = length(DrivingCycle.Time_seconds_);
Time = DrivingCycle.Time_seconds_; % Vettore tempo [s]
TimeStep = cat(1,0,diff(Time));
% % Calcola i dati grezzi 
Vel_ref  = DrivingCycle.Speed_mph_*0.44704; % Conversion mph -> m/s
Acc_ref  = cat(1,0,diff(Vel_ref)./diff(DrivingCycle.Time_seconds_)); % Calcola e trasla il vettore Accelerazione
Jerk_ref = cat(1,0,diff(Acc_ref)./diff(DrivingCycle.Time_seconds_)); % Calcola e trasla il vettore Jerk
Dist_ref = cumtrapz(Vel_ref)/10000; % Distance in km

%% Smooth input data
% Prendo il ciclo di guida puro e lo rendo più lineare tramite una funzione
% di interpolazione
DrivingCycleSmooth = smoothdata(DrivingCycle,"gaussian","SmoothingFactor",0.0002,"DataVariables","Speed_mph_"); 
Vel = DrivingCycleSmooth.Speed_mph_*0.44704 ; % Conversion mph to [m/s]
Acc = cat(1,0,diff(Vel)./diff(DrivingCycle.Time_seconds_)); % Acceleration vector [m/s2]
Jerk = cat(1,0,diff(Acc)./diff(DrivingCycle.Time_seconds_)); % jerk of the velocity vector [m/s3]
Dist = cumtrapz(Vel)/10000; % Distance in km

% % Evaluation error of the distance traveled
% error = Dist - Dist_ref;

% Opzioni Plot
close all
grid minor
xlim([9,40]);
hold on
plot(DrivingCycle.Time_seconds_,Jerk,'k',LineWidth=1.5)
plot(DrivingCycle.Time_seconds_,Jerk_ref,'r')

title('Jerk');
xlabel('Time [s]');
ylabel('Jerk [m/s^3]');
legend('Interpolated','Actual')




