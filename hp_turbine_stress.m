clc
% Define Variables.........
rev = 431.39; % rev/s
N = 43; % Number of blades
m_blade = 0.1; % kg, Mass of each blade
r_blade = 22; % mm, blade length
%................

omega = rev * 2*pi; %rad/s

F = m_blade * omega^2 * r_blade; % N, force exerted by each blade on the disc
fprintf('Force exerted by each blade on the disc: %1.0f kN\n', F/1000);


