% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : FSK_demodulate.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 15/07/2020
%
% Purpose           : This function generates demodulates a FSK-modulated
%                     signal into a series of bits
%
% **********************************************************************

function data_out = FSK_demodulate(signal_in, pulse_duration, win_duration, fs, f0, f1)
    
    % Determine sampling period and number of samples
    Ts = 1/fs;
    samples_number = length(signal_in);

    pulse_length = fix(pulse_duration/Ts);
    win_length = fix(win_duration/Ts);
    
    index = pulse_length/2:pulse_length:samples_number;
    
    data_out = [];
    for i = index
        win = signal_in(i - fix(win_length/2):i + fix(win_length/2));
        N = length(win);
        
        win = win.*blackman(N)';
        f = [f1, f0];
        freq_indices = round(f/fs*N) + 1;   
        dft = abs(goertzel(win, freq_indices));
        
        result = dft(:, 1) - dft(:, 2);
        bit = (result > 0);
        data_out = [data_out, bit];
    end 
    
end