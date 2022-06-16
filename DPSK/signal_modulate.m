% **********************************************************************
%
% Project           : DPSK-Over-Audio Communication System
%
% Program name      : signal_modulate.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This function modulates the envelope according to
%                     the input sampling frequency and carrier frequency
%
% **********************************************************************

function [signal_out, t] = signal_modulate(envelope_in, fs, fc)
    
    % Determine sampling period
    Ts = 1/fs;
    % Create time vector
    N  = length(envelope_in);
    t  = 0:Ts:Ts*(N-1);
    
    % Generate carrier
    carrier = cos(2*pi*fc*t);
    
    % Modulate signal
    signal_out = envelope_in.*carrier;
    
end
