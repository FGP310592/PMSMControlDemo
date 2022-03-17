clear all
close all
clc

%% PSO
% Guess and limit values
LengthX = 4;
XGuess  = zeros(1,LengthX);
XLim    = [0.01e-3, 0.05e-2, 0.01e-3, 0.05e-2;   1e-3,  15e-2,   1e-3,  15e-2];
VLim    = [-0.5e-3, -7.5e-2, -0.5e-3, -7.5e-2; 0.5e-3, 7.5e-2, 0.5e-3, 7.5e-2];
% PSO parameters
win  = 0.3;
wend = 0.0;
c1 = 1;
c2 = 1;
% Number of particles / families of particles
Sett.NumFam = 6;
Sett.NumPar = 10;
% Termination criteria
Sett.NumIterMin = 5;
Sett.NumIterMax = 8;
Sett.VarRelObjFunTrgt   = 0;
Sett.RelErrAvObjFunTrgt = 0;
% Robustness
Sett.NumIterBtwnRestarts  = inf;
Sett.NumIterBtwnZeroTests = inf;
% Flags
Sett.FlagXGuess = false;
Sett.FlagPlots  = true;
% Additional data
Data.sim.tend = 0.3;
% Run PSO
[X,SSE, Data] = Optimization_PSO_v03(XGuess, XLim, VLim, win, wend, c1, c2, Sett, Data);