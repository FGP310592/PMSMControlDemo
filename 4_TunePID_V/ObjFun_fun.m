function [ObjFun] = ObjFun_fun(X, Data)
% Parameters
run('Parameters');
inverter.kP_V = X(1);
inverter.kI_V = X(2);

% Simulation
options = simset('SrcWorkspace','current');
out = sim('Model', Data.sim.tend, options);

% Objective function
Data.n_V = length(out.e_V);
SSE = 0;
for k = 1:5:Data.n_V
    SSE = SSE + (out.e_V(k) - 0)^2;
end
ObjFun = SSE;
end