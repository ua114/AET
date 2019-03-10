clc
altitude = 8.53*10^3; % in feet (8.53 km)
M = 0.78; % mach number
Mtow = 33; % tonnes
p_cruise = 0.494; % Density at cruise in kg/m^3
p_sealevel = 1.225; 

% Weights (all in tonnes)..........
W_empty = 19.7 ; % Operating empty weight
Max_Payload = 8.5; %
Max_Fuel = 8.8;
W_motor = 0.1;
W_batteries = 0.5;
W_Fuel = Mtow - Max_Payload - W_empty - W_batteries ...
    - W_motor; % At maximum payload capacity
W_initial = Max_Payload + W_empty + W_Fuel + W_batteries + W_motor;
W_final = W_initial - W_Fuel; %Only fuel is lost between flight
W_cruise = W_initial - 0.05*W_Fuel; % 5 fuel used up at takeoff
%.................

LD = 18; % L/d
thrust = W_cruise*9810/LD;
%sfc = 0.3752/thrust;
sfc = (16.2/1000)/thrust;
speed_of_sound = 306;% m/s at 8.53 Km altitude
V = M*speed_of_sound; % calculate flight speed

% Range Equation...............

Range = V * LD * (1/(9.81 *sfc)) *log(W_initial/W_final);
fprintf('Range is : %f Km \n', Range/1000);
%.............................

% Calcualte Cl_max................

Cl_max = W_initial*1000*9.81/(0.5*p_sealevel*V^2*70);
fprintf('Cl max = %f\n',Cl_max);

%.....................

fprintf('The thrust required at cruise at 8.3 km is : %f kN\n',...
    thrust/1000);
thrust_sealevel = 20.2*10^3; %From gas turb
h = -10^4 * log((50/61)*(thrust/thrust_sealevel)^(10/7));
fprintf('The new altitude is : %f km\n', h/1000);

% Take off............

rate_of_climb = 6; %Designed climb rate
min_rate_of_climb = 2.4; 
LD_takeoff = 10; 
thrust_takeoff = (1/LD_takeoff + rate_of_climb/100)*W_initial*1000*9.81;
min_thrust_takeoff = (1/LD_takeoff + min_rate_of_climb/100)*...
    W_initial*1000*9.81;
fprintf('\nThrust required at takeoff : %f kN\n', thrust_takeoff/1000);
fprintf('MINIMUM Thrust required at takeoff : %f kN\n',...
    min_thrust_takeoff/1000);
%m = 128.4


