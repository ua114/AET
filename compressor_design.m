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

fprintf('Tip radius at ENTRY of the HPC is : %1.2f cm\n', r_t_entry *100);
fprintf('Root radius at ENTRY of the HPC is : %1.2f cm\n', r_r_entry *100);

V_tip = M_tip * c_cruise;
U_t = sqrt(V_tip^2 - C_a^2);
N = U_t/(2*pi*r_t_entry); % Rotation Frequency
%fprintf('Number of revolutions per second is: %f\n', N);
%..............

% Annulus dimensions at exit
radius_mean = 0.5*(r_t_entry + r_r_entry);
fprintf('Mean radius is : %1.2f cm\n', radius_mean*100);

poly_eff = 0.9; % Polytropic efficiency of the HPC
P_02 = 13*P_01;
T_02 = T_01 * (P_02/P_01)^((gamma -1)/(gamma*poly_eff));
T_2 = T_02 - C_a^2/(2*cp*1000);

P_2 = P_02*(T_2/T_02)^(gamma/(gamma-1));
rho_2 = P_2 * 10^5/(R*T_2);
%fprintf('HPC outlet stagnation temerature is : %f K\n', T_02);
fprintf('HPC outlet temerature is : %1.2f K\n', T_2);

A_2 = m_core/(rho_2*C_a);
h = A_2/(2*pi*radius_mean);
fprintf('Exit blade height is : %1.3f cm\n',h*100);

r_t_exit = radius_mean + h/2;
r_r_exit = radius_mean - h/2;

fprintf('Tip radius at EXIT of the HPC is : %1.2f cm\n', r_t_exit *100);
fprintf('Root radius at EXIT of the HPC is : %1.2f cm\n', r_r_exit *100);
%..............
 
% Estimating number of stages
 
delta_T_0 = T_02 - T_01; % Rise in stagnation temperature across the HPC
U = 2*pi*radius_mean * U_t;
lambda = 1; % Work done factor, assume 1 at the begining
 
beta_1 = atand(U/C_a);
V_1 = C_a/cosd(beta_1);
V_2 = 0.72 * V_1;
beta_2 = acosd(C_a/V_2);

delta_T_os = lambda * U * C_a *(tand(beta_1) - tand(beta_2))/(cp*1000);
fprintf('Temperature rise per stage is: %1.2f K\n', delta_T_os);
stages = delta_T_0/delta_T_os;
fprintf('Number of stages required is : %1.0f\n', stages+2); 
T_os =delta_T_0/(stages +2);
fprintf('The temperature rise per stage is approximately: %1.0f\n',T_os);
%............

% Assume stage 1 and 10 have a temperature rise of 26 K and the rest ...
... rest of the stages will have a temperature rise of 30 K
delta_T_stage_1 = 26;
delta_T_stage_10 = 26;
delta_T_stage_rest = 30; 

lambda = [0.98, 0.93, 0.88, 0.83, 0.83, 0.83,0.83, 0.83, 0.83, 0.83];


% Stage 1 ...
i = 1;
delta_C_w = cp*1000*delta_T_stage_1/(lambda(i)*U);
C_w_2 = delta_C_w;
beta_1(i) = beta_1;
beta_2(i) = atand((U - C_w_2)/C_a);
alpha_1(i) = 0;
alpha_2(i) = atand(C_w_2/C_a);
Diff(i) = cosd(beta_1)/cosd(beta_2);
Reaction(i) = 1 - C_w_2/(2*U);
fprintf('Reaction at stage 1 is : %1.3f\n\n', Reaction(i));
%..............

% Stage 2 .....
i = 2;
Reaction(i) = 0.7; %Approximated
syms b1 b2
 eqn1 = delta_T_stage_rest == lambda(i)*U*C_a/(cp*1000)*(tand(b1)-tand(b2));
 eqn2 = Reaction_2 == C_a/(2*U)*(tand(b1)+tand(b2));
 sol_2 = solve([eqn1, eqn2], [b1,b2]);
 beta_1(i) = sol_2.b1;
 beta_2(i) = sol_2.b2;

alpha_1(i) = atand(U/C_a - tand(beta_1(i)));
alpha_2(i) = atand(U/C_a - tand(beta_2(i)));

Diff(i) = cosd(alpha_2(i))/cosd(alpha_1(i)); 
fprintf('\nDer Haller number for stage 2 is: %1.3f\n', Diff_2);
fprintf('Reaction at stage 2 is : %1.3f\n\n', Reaction(i));
%.........

% Stage 3-9;
Reaction(3:10) = 0.5;
for i=3:9
  syms b1 b2
 eqn1 = delta_T_stage_rest == lambda(i)*U*C_a/(cp*1000)*(tand(b1)-tand(b2));
 eqn2 = Reaction(i) == C_a/(2*U)*(tand(b1)+tand(b2));
 sol_2 = solve([eqn1, eqn2], [b1,b2]);
 beta_1(i) = sol_2.b1;
 beta_2(i) = sol_2.b2;
 alpha_1(i) = atand(U/C_a - tand(beta_1(i)));
 alpha_2(i) = atand(U/C_a - tand(beta_2(i)));
 Diff(i) = cosd(alpha_2(i))/cosd(alpha_1(i)); 
end
    
 

