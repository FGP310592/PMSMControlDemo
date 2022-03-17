function [ObjFun] = ObjFun_fun(X, Data)
% Parameters
run('Parameters');
inverter.RiseTmMax_Id = X(1);
inverter.OvrShtMax_Id = X(2);
inverter.RiseTmMax_Iq = X(3);
inverter.OvrShtMax_Iq = X(4);
inverter.kP_Id = (1+(pi/log(inverter.OvrShtMax_Id))^2)/4/inverter.RiseTmMax_Id*inverter.Ld;
inverter.kI_Id = (1+(pi/log(inverter.OvrShtMax_Id))^2)/4/inverter.RiseTmMax_Id*inverter.Rd;
inverter.kP_Iq = (1+(pi/log(inverter.OvrShtMax_Iq))^2)/4/inverter.RiseTmMax_Iq*inverter.Lq;
inverter.kI_Iq = (1+(pi/log(inverter.OvrShtMax_Iq))^2)/4/inverter.RiseTmMax_Iq*inverter.Rq;
pmsm.J     = pmsm.J/70; % ... to make the speed varying in the whole range
inverter.J = pmsm.J;    % ... to make the speed varying in the whole range
pmsm.omegam_in = 0;

% Simulation
options = simset('SrcWorkspace','current');
out     = sim('Model', Data.sim.tend, options);

% Settings
V_max               = 24/sqrt(3);
dk                  = 0.25e-3/inverter.ts;
MovingAverageWindow = 50*dk;

% Objective function
Coeff_Id = 1;
Coeff_Iq = 1;
Coeff_Vd = 0.05;
Coeff_Vq = 0.05;
Data.n_e_Id     = length(out.e_Id);
Data.n_e_Iq     = length(out.e_Iq);
Data.n_Vd_ref = length(out.Vd_ref);
Data.n_Vq_ref = length(out.Vq_ref);
SSE = 0;
for k = 1:dk:Data.n_e_Id
    SSE = SSE + Coeff_Id*(out.e_Id(k)/inverter.I_max)^2;
end
for k = 1:dk:Data.n_e_Iq
    SSE = SSE + Coeff_Iq*(out.e_Iq(k)/inverter.I_max)^2;
end
for k = 1:dk:Data.n_Vd_ref
    k1 = max(k-MovingAverageWindow,1);
    k2 = min(k+MovingAverageWindow,Data.n_Vd_ref);
    Vd_ref_filtered(k) = mean(out.Vd_ref(k1:k2));
    SSE = SSE + Coeff_Vd*((out.Vd_ref(k)-Vd_ref_filtered(k))/V_max)^2;
end
for k = 1:dk:Data.n_Vq_ref
    k1 = max(k-MovingAverageWindow,1);
    k2 = min(k+MovingAverageWindow,Data.n_Vq_ref);
    Vq_ref_filtered(k) = mean(out.Vq_ref(k1:k2));
    SSE = SSE + Coeff_Vq*((out.Vq_ref(k)-Vq_ref_filtered(k))/V_max)^2;
end
ObjFun = SSE;
end