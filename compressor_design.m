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
%..................

% Air properties 
R = 287; % Absolute gas constant
gamma = 1.4;
P_atm = 0.33; % Stagnation Pressure at 28,000 ft in bar
P_01 = 2.5 * P_atm; % Inlet stagnation Pressure into the HPC
T_01 = 232.8; % Stagnation temperature at 28,000 ft ? ground level??
cp = 1.01; %kJ KgK-1
%.................

T_1 = T_01 - C_a^2/(2*cp*1000); % HPC inlet temperature
P_1 = P_01*(T_1/T_01)^(gamma/(gamma-1)); % HPC inlet pressure
rho_1 = P_1*10^5/(R*T_1); %HPC inlet density
%.............

% Annulus dimensions at entry
r_t_entry = sqrt(m_core/(pi*rho_1*C_a*(1-hub_ratio^2))); % Tip radius
r_r_entry = hub_ratio * r_t_entry; % Root radius

fprintf('Tip radius at entry of the HPC is : %f cm\n', r_t_entry *100);
fprintf('Root radius at entry of the HPC is : %f cm\n', r_r_entry *100);

V_tip = M_tip * c_cruise;
U_t = sqrt(V_tip^2 - C_a^2);
N = U_t/(2*pi*r_t_entry); % Rotation Frequency
fprintf('Number of revolutions per second is: %f\n', N);
%..............

% Annulus dimensions at exit
radius_mean = 0.5*(r_t_entry + r_r_entry);
fprintf('Mean radius is : %f cm\n', radius_mean*100);

poly_eff = 0.9; % Polytropic efficiency of the HPC
P_02 = 13*P_01;
T_02 = T_01 * (P_02/P_01)^((gamma -1)/(gamma*poly_eff));
T_2 = T_02 - C_a^2/(2*cp*1000);

P_2 = P_02*(T_2/T_02)^(gamma/(gamma-1));
rho_2 = P_2 * 10^5/(R*T_2);
fprintf('HPC outlet stagnation temerature is : %f K\n', T_02);
fprintf('HPC outlet temerature is : %f K\n', T_2);

A_2 = m_core/(rho_2*C_a);
h = A_2/(2*pi*radius_mean);
fprintf('Exit blade height is : %f cm\n',h*100);






