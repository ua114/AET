clc
% Define Variables.........
rev = 431.39; % rev/s
N = 43; % Number of blades
r_blade = 22/1000; % m, blade length
% r_0 = 
% r_i = 
h = 5/1000; % m, blade thickness
width = 22/1000; %m, blade width
rho = 8193; % kg/m3, density of high strength nickel-chromium alloy

%................

omega = rev * 2*pi; %rad/s

m_blade = rho * h * r_blade * width; % kg, mass of individual blade
fprintf('Mass of one blade: %1.2f kg\n',m_blade);

F = m_blade * omega^2 * r_blade; % N, force exerted by each blade
fprintf('Force exerted by each blade on the disc: %1.0f kN\n', F/1000);




