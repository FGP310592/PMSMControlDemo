clear all
close all
clc
%% Parameters
% Inputs
ts        = 1/40e+3;
p         = 3;
Rd        = 51.2e-3;
Rq        = 51.2e-3;
Ld        = 0.71e-3;
Lq        = 1.94e-3;
lambdadPM = 112.1e-03;
B         = 1e-05;
nm_max    = 6700;
I_max     = 118;
V_max     = 400/sqrt(3);
C_max     = 100;
Pm_max    = C_max*(nm_max*2*pi/60);
% Settings
% 1: < base speed: MTPA, > base speed: CVCT
% 2: < base speed: Zero Id, > base speed: CVCT
SETT.Config = 1;
%% Map generation
if(SETT.Config == 1)
    run('GenerateMap_IdqRef_Func_v05.p');
elseif(SETT.Config == 2)
    run('GenerateMap_IdqRef_Func_v05_ZeroId.p');
end