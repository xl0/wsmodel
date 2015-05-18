function [ var_vect ] = var_struct_to_vect( var_struct )

var_array = [];

var_array(1) = x.si;   % internal food,
var_array(2) = x.a;    % energy
var_array(3) = x.r;    % ribosomes
var_array(4) = x.et;   % transporter
var_array(5) = x.em;   % metabolic enzyme
var_array(6) = x.q;    % q protein

var_array(7) = x.m_r;  % free ribosomal mRNA
var_array(8) = x.m_et; % free transporter mRNA
var_array(9) = x.m_em; % free metabolic enzyme mRNA
var_array(10) = x.m_q;  % free q mRNA

var_array(11) = x.c_r;  % ribosome-bound ribosomal mRNA
var_array(12) = x.c_et; % ribosome-bound transporter mRNA
var_array(13) = x.c_em; % ribosome-bound metabolic enzyme mRNA
var_array(14) = x.c_q;  % ribosome-bound q mRNA


end

