clc
% Define Variables.........
HP_ratio = 13; % Overall HP pressure ratio
rp_stage = 1.6; % Max pressire rise across a stage
Fan_diameter = 0.9582; % in m
C_a = 170; 
Core_area = 0.0351; %m^2
%.................

stages = HP_ratio/rp_stage;
fprintf('Number of compressor stages is : %d\n', floor(stages) +1);
fprintf('The last stage will have a pressure ratio of: %f\n',stages...
    - floor(stages));

