clc
clear
% Define Variables.........
HP_ratio = 13; % Overall HP pressure ratio
C_a = 170; 
m_core = 7.817; %Mass flow rate in the core in kg/s
rho_cruise = 0.494; % in kg/m^3
hub_ratio = 0.6;
M_tip = 1.4; % Maximum mach number at blade tip
c_cruise = 310; % Speed of sound at cruise altitude
%..................

% Preallocation of variables
T_1 = zeros(1,10);
T_01 = zeros(1,10);
P_1 = zeros(1,10);
P_01 = zeros(1,10);

% T_2 = zeros(1,10);
% T_02 = zeros(1,10);
% P_2 = zeros(1,10);
% P_02 = zeros(1,10);

T_3 = zeros(1,10);
T_03 = zeros(1,10);
P_3 = zeros(1,10);
P_03 = zeros(1,10);

rho_1 = zeros(1,10);
rho_2 = zeros(1,10);
rho_3 = zeros(1,10);

U_t = zeros(1,10);
U = zeros(1,10);

Area = zeros(1,10);
%........

% Air properties 
R = 287; % Absolute gas constant
gamma = 1.4;
P_atm = 0.33; % Stagnation Pressure at 28,000 ft in bar
P_01(1) = 2.5 * P_atm; % Inlet stagnation Pressure into the HPC
T_01(1) = 232.8; % Stagnation temperature at 28,000 ft ? ground level??
cp = 1.01; %kJ KgK-1
%.................

T_1(1) = T_01(1) - C_a^2/(2*cp*1000); % HPC inlet temperature
P_1(1) = P_01(1)*(T_1(1)/T_01(1))^(gamma/(gamma-1)); % HPC inlet pressure
rho_1(1) = P_1(1)*10^5/(R*T_1(1)); %HPC inlet density

% Annulus dimensions at entry
r_t_entry = sqrt(m_core/(pi*rho_1(1)*C_a*(1-hub_ratio^2))); % Tip radius
r_r_entry = hub_ratio * r_t_entry; % Root radius

fprintf('Tip radius at ENTRY of the HPC is : %1.2f cm\n', r_t_entry *100);
fprintf('Root radius at ENTRY of the HPC is : %1.2f cm\n', r_r_entry *100);

V_tip = M_tip * c_cruise;
U_t(1) = sqrt(V_tip^2 - C_a^2);
N = U_t/(2*pi*r_t_entry); % Rotation Frequency
fprintf('Number of revolutions per second at ENTRY is: %1.2f\n', N(1));
%..............

% Calculating annulus exit geometry
outer_radius = r_t_entry;
poly_eff = 0.9; % Polytropic Efficiency

P_02 = 13*P_01(1);
T_02 = T_01(1) * (P_02/P_01(1))^((gamma -1)/(gamma*poly_eff));
T_2 = T_02 - C_a^2/(2*cp*1000);

P_2 = P_02*(T_2/T_02)^(gamma/(gamma-1));
rho_exit = P_2 * 10^5/(R*T_2);
A_exit = m_core/(rho_exit*C_a);

r_r_exit = sqrt(outer_radius^2 - A_exit/pi);
fprintf('Root radius at EXIT of the HPC is : %1.2f cm\n',r_r_exit * 100);
fprintf('Exit blade length is : %1.2f cm\n', (outer_radius - r_r_exit)*100);
hub_ratio_exit = r_r_exit/outer_radius;
%..........

% Estimating number of stages .....
delta_T_0 = T_02 - T_01(1); % Rise in stagnation temperature across the HPC
