function [ObjFun] = ObjFun_fun(X, Data)
% Parameters
run('Parameters');
inverter.kP_omegam = X(1);
inverter.kI_omegam = X(2);
inverter.kD_omegam = 0;

% Simulation
options = simset('SrcWorkspace','current');
out     = sim('Model', Data.sim.tend, options);

% Settings
omegam_max          = ((2*pi)/60)*inverter.nm_max;
C_max               = max(abs(out.C_ref));
dk                  = 0.25e-3/inverter.ts;
MovingAverageWindow = 50*dk;

% Objective function
Coeff_omegam = 1;
Coeff_C      = 0.1;
Data.n_e_omegam = length(out.e_omegam);
Data.n_C_ref    = length(out.C_ref);
SSE = 0;
for k = 1:dk:Data.n_e_omegam
    SSE = SSE + Coeff_omegam*(out.e_omegam(k)/omegam_max)^2;
end
for k = 1:dk:Data.n_C_ref
    k1 = max(k-MovingAverageWindow,1);
    k2 = min(k+MovingAverageWindow,Data.n_C_ref);
    C_ref_filtered(k) = mean(out.C_ref(k1:k2));
    SSE = SSE + Coeff_C*((out.C_ref(k)-C_ref_filtered(k))/C_max)^2;
end
ObjFun = SSE;
end