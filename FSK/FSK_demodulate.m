% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : FSK_demodulate.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This function generates demodulates a FSK-modulated
%                     signal into a series of bits
%
% **********************************************************************

function data_out = FSK_demodulate(signal_in, pulse_duration, fs, f0, f1, ff, b)

    % Find sampling period
    Ts = 1/fs; 
    
    % Calculate symbol frequency bands
    f0_b = [f0 - b/2, f0 + b/2]; 
    f1_b = [f1 - b/2, f1 + b/2];
    ff_b = [ff - b/2, ff + b/2];
    
    % Extract header
    sf = bandpass(signal_in, ff_b, fs);
    
    % Extract symbols
    s0 = bandpass(signal_in, f0_b, fs);
    s1 = bandpass(signal_in, f1_b, fs);
    
    % Envelope detection, rectify the signal
    sf_abs = abs(sf);
    s0_abs = abs(s0);
    s1_abs = abs(s1);
    
    % Low-pass filter
    sf_abs_lpf = lowpass(sf_abs, 2/pulse_duration, fs);
    s0_abs_lpf = lowpass(s0_abs, 2/pulse_duration, fs);
    s1_abs_lpf = lowpass(s1_abs, 2/pulse_duration, fs);
    
    % Find difference
    result = s1_abs_lpf - s0_abs_lpf;
    
    % Find frame header
    [m, header_index] = max(sf_abs_lpf);
    pulse_length = fix(pulse_duration/Ts);
    total_length = size(result);
    
    index = header_index+pulse_length:pulse_length:total_length;
    
    c = 1;
    for i = index
        if result(i) > 0
            data_out(c) = 1;
        else
            data_out(c) = 0;
        end
        c = c + 1;
    end
    
end