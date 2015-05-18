%% set simulation time
tfinal  = 1e2;                              % final time

%% configure integrator (check 'doc ode15s' for more info)
options = odeset('NonNegative',[1:4]);      % ensures variables stay positive 
                                            % (this is not always necessary 
                                            % but can be helpful, but make sure 
                                            % your system is actually a positive system!)

options = odeset(options, 'RelTol', 1e-3,...
                          'AbsTol', 1e-6);  % accuracy of integrator 
                                            % (here set to default values)

%% set parameters

k = struct();

k.s = 10e4;     % External nutrient, molecules.
k.dm = 0.1;     % mRNA degradation rate, /min.
k.ns = 0.5;     % Nutrient efficiency.

k.nr = 7459;    % ribosome length, aa.
k.nx = 300;     % other proteins, aa.

k.gamma_max = 1260; % maximal translation elongation rate, aa/min.
k.K_gamma = 7;  % translation elongation threshold, molecules/cell.

k.vt = 726;     % max nutrient import rate, /min.
k.Kt = 1000;    % nutrient import threshold, molecules.

k.vm = 5800;    % max enzymatic rate, /min;
k.Km = 1000;    % enzymatic threshold, molecules/cell.

k.wr = 930;     % max ribosome transcription rate, molecules/min.
k.we = 4.14; 
k.wt = 4.14;
k.wm = 4.14; % max enzyme transcription rate, molecules/min.

k.wq = 948.93;  % max q protein transcription rate, molecules/min.
k.Tetta_r = 426.87; % ribosomal transcription threshold, molecules/cell.

k.Tetta_nr = 4.83; % non-ribosomal transcription threshold, molecules/cell.

k.Kq = 152219;  % q protein autoinhibition threshold, molecules/cell.
k.hq = 4;       % q protein autoinhibition Hill coefficient.

k.kb = 1;       % mRNA-ribosime binding rate, /(min * molecs)
k.ku = 1;       % mRNA-ribosome unbinding rate, /min.

M = 10e8;       % Total cell mass, aa.
k.k_cm = 0.00599; % chloramphinicol binding rate, /(min * uM)



%% variables

x = struct();


x.si = 0;   % internal food,
x.a = 0;    % energy
x.r = 0;    % ribosomes
x.et = 0;   % transporter
x.em = 0;   % metabolic enzyme
x.q = 0;    % q protein

x.m_r = 0;  % free ribosomal mRNA
x.m_et = 0; % free transporter mRNA
x.m_em = 0; % free metabolic enzyme mRNA
x.m_q = 0;  % free q mRNA

x.c_r = 0;  % ribosome-bound ribosomal mRNA
x.c_et = 0; % ribosome-bound transporter mRNA
x.c_em = 0; % ribosome-bound metabolic enzyme mRNA
x.c_q = 0;  % ribosome-bound q mRNA




x0      = var_struct_to_vect(x); % definition of the initial vector of variables


%% simulate
[t,result] = ode15s(@(t,result) wsmodel_ode(t,result,k),[0,tfinal],x0,options);

%% rename variables
a = result(:,1);    % a = first column of result
b = result(:,2);    % b = second column of result
c = result(:,3);    % ... 
d = result(:,4);

%% plot results
figure(1); clf; 
subplot(4,1,1)
plot(t,a); ylabel('a', 'fontsize', 14);

subplot(4,1,2)
plot(t,b); ylabel('b', 'fontsize', 14);

subplot(4,1,3)
plot(t,c); ylabel('c', 'fontsize', 14);

subplot(4,1,4)
plot(t,d); ylabel('d', 'fontsize', 14); xlabel('time', 'fontsize', 14)