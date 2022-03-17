clear all
close all
clc
%% PSO
% Guess and limit values
LengthX = 2;
XGuess  = [0,0];
XLim    = [0, 0; 1, 0.1];
VLim    = [-0.25, -0.025; 0.25, 0.025];
% PSO parameters
win  = 0.3;
wend = 0.0;
c1 = 1;
c2 = 1;
% Number of particles / families of particles
Sett.NumPar = 8;
Sett.NumFam = 1;
% Termination criteria
Sett.NumIterMin = 5;
Sett.NumIterMax = 10;
Sett.VarRelObjFunTrgt   = 0;
Sett.RelErrAvObjFunTrgt = 0;
% Robustness
Sett.NumIterBtwnRestarts  = inf;
Sett.NumIterBtwnZeroTests = 5;
% Flags
Sett.FlagXGuess = false;
Sett.FlagPlots  = true;
% Additional data
Data.sim.tend = 1;
% Run PSO
[X,SSE, Data] = Optimization_PSO_v03(XGuess, XLim, VLim, win, wend, c1, c2, Sett, Data);