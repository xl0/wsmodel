function dxdt = wsmodel_ode(t, x, k)

% wsmodel_ode(time, variables_vector, parameter_vector)
% Function that implements the right hand side of the ODE for wsmodel. 


    function v_imp = import_rate(x, k)
        v_imp = x.et * k.vt * k.s / (k.Kt + k.s);
    end

    function v_cat = cat_rate(x, k)
        v_cat = x.em * k.vm * x.si / (k.Km + x.si);
    end

    function gamma = elongation_rate(x, k)
        gamma = k.gamma_max * x.a / (k.K_gamma + x.a);
    end

    function lambda = growth_rate (x, k)
        % Number of bound ribosomes.
        Rt = x.c_r + x.c_et + x.c_em + x.c_q;
        % Translation rate. XXX The limit looks a bit sketchy to me right
        % now.
        
        lambda = Rt * elongation_rate(x, k) / k.M;
    end

    % Elongtion rates for all proteins.
    function vr = v_r(x, k)
            vr = x.c_r * elongation_rate(x, k) / k.nr;
    end

    function vet = v_et(x, k)
            vet = x.c_et * elongation_rate(x, k) / k.nx;
    end

    function vem = v_em(x, k)
            vem = x.c_em * elongation_rate(x, k) / k.nx;
    end

    function vq = v_q(x, k)
            vq = x.c_q * elongation_rate(x, k) / k.nx;
    end

%% rename variables

x = var_vect_to_struct(x);

dxdt = var_vect_to_struct(zeros(length(fieldnames(x))))

% Nutrients
% Import rate
dxdt.si = dxdt.si + import_rate(x, k);
% minus food catalysis rate
dxdt.si = dxdt.si + cat_rate(x, k);
% minus growth dilution
dxdt.si = dxdt.si + x.si * growth_rate(x, k);

% Energy
% Food catalysis rate metabolism - elongation expenses - growth dilution.
dxdt.a = dxdt.a + k.ns * cat_rate(x, k);
% elongation expenses for all proteins
dxdt.a = dxdt.a - k.nr * v_r(x, k) ...
                - k.nx * v_et(x, k) ...
                - k.nx * v_em(x, k) ...
                - k.nx * v_q(x, k);
% Dilution by growth
dxdt.a = dxdt.a - growth_rate(x, k) * x.a;

% Number of ribosomes
% Ribosome production
dxdt.r = dxdt.r + v_r(x, k)
% Monus growth dilution
dxdt.r = dxdt.r - x.r * growth_rate(x, k) 

% Now for each protein:
% ribosome:
dxdt.r = dxdt.r + v_r(x, k) ... % ribosomes freed after termination
    - x.r * k.kb * x.m_r ...     % minus ribosomes that bind to free mRNA
    + x.c_r * k.ku;              % plus ribosomes that un-bound from free mRNA

% transporter:
dxdt.r = dxdt.r + v_et(x, k) ... % ribosomes freed after termination
    - x.r * k.kb * x.m_et ...     % minus ribosomes that bind to free mRNA
    + x.c_et * k.ku;              % plus ribosomes that un-bound from free mRNA
    
% enzyme:
dxdt.r = dxdt.r + v_em(x, k) ... % ribosomes freed after termination
    - x.r * k.kb * x.m_em ...     % minus ribosomes that bind to free mRNA
    + x.c_em * k.ku;              % plus ribosomes that un-bound from free mRNA

% q:
dxdt.r = dxdt.r + v_q(x, k) ... % ribosomes freed after termination
    - x.r * k.kb * x.m_q ...     % minus ribosomes that bind to free mRNA
    + x.c_q * k.ku;              % plus ribosomes that un-bound from free mRNA




%% initialize the rates of change for each variable with 0


%% for each reaction - add up contributions to rates of changes


%% output vector of rates of change of all variables
dxdt    = var_struct_to_vect(dxdt);
end