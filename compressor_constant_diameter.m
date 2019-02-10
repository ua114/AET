clc
clear
% Define Variables.........
HP_ratio = 13; % Overall HP pressure ratio
Fan_diameter = 0.9582; % in m
C_a = 170; 
m_core = 7.817; %Mass flow rate in the core in kg/s
rho_cruise = 0.494; % in kg/m^3
hub_ratio = 0.6;
M_tip = 1.4; % Maximum mach number at blade tip
c_cruise = 310; % Speed of sound at cruise altitude
%..................

% Air properties 
R = 287; % Absolute gas constant
gamma = 1.4;
P_atm = 0.33; % Stagnation Pressure at 28,000 ft in bar
P_01 = 2.5 * P_atm; % Inlet stagnation Pressure into the HPC
T_01 = 232.8; % Stagnation temperature at 28,000 ft ? ground level??
cp = 1.01; %kJ KgK-1
%.................

% Preallocation of variables
T_1 = zeros(1,10);
T_01 = zeros(1,10);
P_1 = zeros(1,10);
P_01 = zeros(1,10);

T_2 = zeros(1,10);
T_02 = zeros(1,10);
P_2 = zeros(1,10);
P_02 = zeros(1,10);

T_3 = zeros(1,10);
T_03 = zeros(1,10);
P_3 = zeros(1,10);
P_03 = zeros(1,10);
%........


