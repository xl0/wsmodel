function dxdt = wsmodel_ode(t, x, k)

% wsmodel_ode(time, variables_vector, parameter_vector)
% Function that implements the right hand side of the ODE for wsmodel. 

%% rename variables

x = var_vect_to_struct(x);


%% initialize the rates of change for each variable with 0


%% for each reaction - add up contributions to rates of changes


%% output vector of rates of change of all variables
dxdt    = var_struct_to_vect(x);