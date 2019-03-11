clc
cla
clear
% Define Variables.........
rev = 431.39; % rev/s
N = 43; % Number of blades
r_blade = 22/1000; % m, blade length
R_0 = 0.2; % m, outer diameter of disc 
R_i = 0.1; % m, inner diamter of disc 
h = 5/1000; % m, blade thickness
width = 22/1000; %m, blade width
rho = 4595; % kg/m3, density of high strength nickel-chromium alloy
nu = 0.3; % Poisson ratio
%................

Omega = rev * 2*pi; %rad/s

m_blade = rho * h * r_blade * width; % kg, mass of individual blade
fprintf('Mass of one blade: %1.2f kg\n',m_blade);

F_rim = m_blade * Omega^2 * r_blade; % N, force exerted by each blade
fprintf('Force exerted by each blade on the disc: %1.0f kN\n', F_rim/1000);


i = 1:11;
r(i) = (0.2-0.1)/10 * (i-1) + 0.1;

% Radial stress in MPa......
sigma_r(i) = ((3+nu)/8 * rho * Omega^2 * (R_i^2 + R_0^2 - ...
    (R_i^2*R_0^2)./r.^2- r.^2) + ( N * F_rim * R_0)/(2*pi*h*(R_0^2-R_i^2)) ...
    *(1-(R_i./r).^2))/10^6;
%.........

% Hoop stress in MPa .......
sigma_theta(i) = ((3+nu)/8 * rho * Omega^2 * (R_i^2 + R_0^2 + ...
    (R_i^2*R_0^2)./r(i).^2 - (1+3*nu)/(3+nu)*r(i).^2) + N * F_rim * R_0/(2* pi * h * ...
    (R_0^2 - R_i^2)) * (1 + (R_i./r(1)).^2))/10^6;
%..........

r_ratio(i) = r(i)/R_0;

% Plotting tools........
r_ratio_fine = linspace(min(r_ratio),max(r_ratio),500);
hold on
plot(r_ratio,sigma_r,'ko')
plot(r_ratio_fine,spline(r_ratio,sigma_r,r_ratio_fine),'k')
plot(r_ratio,sigma_theta,'mo')
plot(r_ratio_fine,spline(r_ratio,sigma_theta,r_ratio_fine),'m')
xlabel('r/R_0'), ylabel('Stress (MPa)')
title('Radial and Hoop Stresses VS radial location')
xlim([min(r_ratio),max(r_ratio)])
ylim([0,max(sigma_theta)])
set(gca,'FontSize',20)
hold off