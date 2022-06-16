% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : FSK_modulate.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This function generates a FSK-modulated
%                     signal from an input bit sequence
%
% **********************************************************************

function [signal_out, t] = FSK_modulate(data_in, pulse_duration, fs, f0, f1, ff, gain)
    
    % Insert frame haeder
    data_in = [2, data_in];

    % Determine sampling period
    Ts = 1/fs;

    % Create pulses
    pulse_length = fix(pulse_duration/Ts);
    pulses = repelem(data_in, pulse_length);
    
    % Generate time vector for plotting
    N = length(pulses);
    t = 0:Ts:Ts*(N-1);
    
    % Initialize angle and output signal vector
    theta = 0;
    signal_out = zeros(1, N);
    
    % FSK modulation
    for i = 1:N
        
        % Update output signal
        signal_out(i) = cos(theta)*gain;
        
        % Update angle based on pulse value
        if pulses(i) == 0
            % Symbol : '0'
            theta = theta + 2*pi*Ts*f0;
        elseif pulses(i) == 1
            % Symbol : '1'
            theta = theta + 2*pi*Ts*f1;
        else
            % Frame header frequency
            theta = theta + 2*pi*Ts*ff;
        end
        
    end
    
end