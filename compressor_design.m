clc
% Define Variables.........
HP_ratio = 13; % Overall HP pressure ratio
rp_stage = 1.6; % Max pressire rise across a stage
%.................

stages = HP_ratio/rp_stage;
fprintf('Number of compressor stages is : %d\n', floor(stages) +1);
fprintf('The last stage will have a pressure ratio of: %f\n',stages - floor(stages));

