clc
% Define Variables.........
HP_ratio = 13; % Overall HP pressure ratio
rp_stage = 1.6; % Max pressire rise across a stage
Fan_diameter = 0.9582; % in m
C_a = 170; 
Core_area = 0.0351; %m^2
m_core = 7.817; %Mass flow rate in the core in kg/s
rho_cruise = 0.494; % in kg/m^3
hub_ratio = 0.6;
M_tip = 1.4; % Maximum mach number at blade tip
c_cruise = 310; % Speed of sound at cruise altitude
%.................

stages = HP_ratio/rp_stage;
fprintf('Number of compressor stages is : %d\n', floor(stages) +1);

% Calculate Blade Tip Radius....
r_t = sqrt((m_core)/(rho_cruise*pi*C_a*(1-(hub_ratio)^2)));
fprintf('Initial compressor blade radius is: %f cm\n', r_t*100);
%.......

% Calculate Blade tip sped
N = (M_tip*c_cruise)/(2*pi*r_t);
fprintf('Rotation speed is : %f\n', N);
