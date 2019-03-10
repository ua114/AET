clc
% Define Variables.........
rev = 431.39; % rev/s
N = 43; % Number of blades
r_blade = 22/1000; % m, blade length
r_0 = 0.2; % m, outer diameter of disc 
r_i = 0.1; % m, inner diamter of disc 
h = 5/1000; % m, blade thickness
width = 22/1000; %m, blade width
rho = 8193; % kg/m3, density of high strength nickel-chromium alloy
nu = 0.3; % Poisson ratio
%................

omega = rev * 2*pi; %rad/s

m_blade = rho * h * r_blade * width; % kg, mass of individual blade
fprintf('Mass of one blade: %1.2f kg\n',m_blade);

F_rim = m_blade * omega^2 * r_blade; % N, force exerted by each blade
fprintf('Force exerted by each blade on the disc: %1.0f kN\n', F_rim/1000);

% Radial stress......
i = 1:10;
r(i) = (0.2-0.1)/10 * i + 0.1;

sigma_r(i) = ((3+nu)/8 * rho * omega^2 * (r_i^2 + r_0^2 - ...
(r_i^2*r_0^2)./r.^2- r.^2) + ( N * F_rim * r_0)/(2*pi*h*(r_0^2-r_i^2)) ...
*(1-(r_i./r).^2))/10^6;

