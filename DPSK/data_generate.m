% **********************************************************************
%
% Project           : DPSK-Over-Audio Communication System
%
% Program name      : data_generate.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This function geenrates a pseudo-random bit
%                     sequence useful for testing purposes
%
% **********************************************************************

function data_out = data_generate(sequence_length)
    data_out = rand(1, sequence_length) > 0.5;
end