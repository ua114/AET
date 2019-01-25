clc
%Specify parameters......
T_2 = 232.65; %Stagnation temperature at 8.53 km/28,000 feet
T_4 = 1600; % Burner outlet temperature
T_9 = 500;
V_sound_28000 = 306; % Speed of sound at 8.53 km
V_takeoff = 75;
V = V_takeoff*0.8; % diffuser effect
M = 0.78; % Mach number
engine_diameter = 1.5;
rho_sealevel = 1.225;
m_takeoff = rho_sealevel*V*(1/4)*pi*(engine_diameter)^2;
fprintf('Mass flow rata at takeoff is %f kg/s\n', m_takeoff);
c_p = 1020; 
gamma = 1.4;
bpr = 7.4;
% Pressure ratios.......
rp_fan = 32.5/13;
rp_compressor = 13;
rp_turbine = 1/32.5;
%.............

% Calculate temperatures
T_23 = T_2*(rp_fan)^((gamma-1)/gamma); 
T_12 = T_23; %Bypass and core temperature are the same at this point

T_3 = T_23*(rp_compressor)^((gamma-1)/gamma);
T_5 = T_4*(rp_turbine)^((gamma-1)/gamma);
%................

% Work and energy.......
%w_fan = (1/2)*m;
w_compressor = c_p*(T_23 - T_3);
q_combustor = c_p*(T_4 - T_3);
w_turbine = c_p*(T_4 - T_5);
%...................

% Velocity........
V_c = sqrt(2*c_p*(T_5 - T_9));
%.......

% Solve m_bypass m_core

syms m_bypass m_core
eqn1 = m_bypass + m_core == m_takeoff;
eqn2 = (m_bypass)/(m_core) == bpr;
sol = solve([eqn1; eqn2], [m_bypass, m_core]);
m_b = sol.m_bypass;
m_c = sol.m_core;
%...........

% Calculate thrust and motor power required
Thrust = (V_c * m_c) - (m_takeoff * V_takeoff) + (m_b * 0.75 * V_c);
fprintf('The thrust at takeoff is %f kN\n', Thrust/1000);
%https://www.grc.nasa.gov/www/k-12/airplane/turbfan.html
F_N0 = 29;
h = 8.53*1E3;
F_N = F_N0*(1.22 * exp(-h/10^4));
fprintf('Thrust at cruise is %f kN\n',F_N);

