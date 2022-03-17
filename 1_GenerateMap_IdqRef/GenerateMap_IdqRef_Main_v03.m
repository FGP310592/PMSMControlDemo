clear all
close all
clc
%% Parameters
% Inputs
p         = 4;
Rd        = 360e-3;
Rq        = 360e-3;
Ld        = 200e-6;
Lq        = 400e-6;
lambdadPM = 6.395415186893e-03;
nm_max    = 6600;
I_max     = 7.1;
V_max     = 24/sqrt(3);
C_max     = 0.3;
Pm_max    = 117.0478;
%% Map generation
run('GenerateMap_IdqRef_Func_v03.p');