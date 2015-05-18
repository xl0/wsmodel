function dxdt = wsmodel_ode(t, x, k)

% wsmodel_ode(time, variables_vector, parameter_vector)
% Function that implements the right hand side of the ODE for wsmodel. 


    function v_imp = import_rate(x, k)
        v_imp = x.et * k.vt * s / (k.Kt + s);
    end

    function v_cat = cat_rate(x, k)
        v_cat = x.em * K.vm * x.si / (k.Km + x.si);
    end

    function gamma = elongation_rate(x, k)
        gamma = k.gamma_max * x.a / (k.K_gamma + a);
    end

    function lambda = growth_rate (x, k)
        % Number of bound ribosomes.
        Rt = x.c_r + x.c_et + x.c_em + x.c_q;
        % Translation rate. XXX The limit looks a bit sketchy to me right
        % now.
        
        lambda = Rx * elongation_rate(x, k) / k.M;
    end

    % Elongtion rates for all proteins.
    function vr = v_r(x, k)
            vr = x.c_r * elongation_rate(x, k) / a.nr;
    end

    function vet = v_et(x, k)
            vet = x.c_tr * elongation_rate(x, k) / a.nx;
    end

    function vem = v_em(x, k)
            vem = x.c_em * elongation_rate(x, k) / a.nx;
    end

    function vq = v_r(x, k)
            vq = x.c_q * elongation_rate(x, k) / a.nx;
    end

%% rename variables

x = var_vect_to_struct(x);

dxdt = var_vect_to_struct(zeros(length(fieldnames(x))))

dxdt.si = import_rate(x, k) - cat_rate(x, k) - growth_rate(x, k);

dxdt.a = 


%% initialize the rates of change for each variable with 0


%% for each reaction - add up contributions to rates of changes


%% output vector of rates of change of all variables
dxdt    = var_struct_to_vect(x);
end