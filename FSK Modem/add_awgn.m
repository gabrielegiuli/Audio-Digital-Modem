% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : add_awgn.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This function adds awgn noise to signal
%
% **********************************************************************

function signal_out = add_awgn(signal_in, sigma)
    N = length(signal_in);
    
    noise = randn(1, N).*sigma;
    signal_out = signal_in + noise;
end