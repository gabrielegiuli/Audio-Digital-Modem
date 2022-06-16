% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : TEST.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This file allows to check if it has worked
%
% **********************************************************************

% Reset workspace
close all; 
clear all; 
clc; 

CODING_ENABLED = 1;

DATA_TX();
DATA_RX();

mod = csvread('mod.csv');
demod = csvread('demod.csv');

errors = xor(mod, demod);

count = 0;
for e = errors
    if e == 1 
        count = count + 1; 
    end
end

BER = count/length(errors)

if CODING_ENABLED == 1
    mod_cod = csvread('mod_cod.csv');
    demod_cod = csvread('demod_cod.csv');
    
    errors_cod = xor(mod_cod, demod_cod);
    
    count = 0;
    for e = errors_cod
        if e == 1 
            count = count + 1; 
        end
    end
    BER_cod = count/length(errors)
    
end