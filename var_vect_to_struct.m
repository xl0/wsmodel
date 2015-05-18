function [ struct ] = var_vect_to_struct( vect )

x.si = vect(1);   % internal food,
x.a = vect(2);    % energy
x.r = vect(3);    % ribosomes
x.et = vect(4);   % transporter
x.em = vect(5);   % metabolic enzyme
x.q = vect(6);    % q protein

x.m_r = vect(7);  % free ribosomal mRNA
x.m_et = vect(8); % free transporter mRNA
x.m_em = vect(9); % free metabolic enzyme mRNA
x.m_q = vect(10);  % free q mRNA

x.c_r = vect(11);  % ribosome-bound ribosomal mRNA
x.c_et = vect(12); % ribosome-bound transporter mRNA
x.c_em = vect(13); % ribosome-bound metabolic enzyme mRNA
x.c_q = vect(14);  % ribosome-bound q mRNA

end

