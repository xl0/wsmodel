function [ var_vect ] = var_struct_to_vect( x )

%var_vect = [];

var_vect(1) = x.si;   % internal food,
var_vect(2) = x.a;    % energy
var_vect(3) = x.r;    % ribosomes
var_vect(4) = x.et;   % transporter
var_vect(5) = x.em;   % metabolic enzyme
var_vect(6) = x.q;    % q protein

var_vect(7) = x.m_r;  % free ribosomal mRNA
var_vect(8) = x.m_et; % free transporter mRNA
var_vect(9) = x.m_em; % free metabolic enzyme mRNA
var_vect(10) = x.m_q;  % free q mRNA

var_vect(11) = x.c_r;  % ribosome-bound ribosomal mRNA
var_vect(12) = x.c_et; % ribosome-bound transporter mRNA
var_vect(13) = x.c_em; % ribosome-bound metabolic enzyme mRNA
var_vect(14) = x.c_q;  % ribosome-bound q mRNA

var_vect = var_vect';
end

