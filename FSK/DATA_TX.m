% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : DATA_TX.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This project aims to generate a FSK-modulated
%                     audio file that can be used to transmit data
%                     over any audio commumication link (e.g. two
%                     way radios)
%
% **********************************************************************

function DATA_TX()

    % Reset workspace
    close all; 
    clear all; 
    clc;

    % Modulation pulse paramenters
    BITSTREAM_LENGTH   = 8000;
    PULSE_DURATION     = 2E-3;
    GAIN = 0.5;
    
    % Noise settings
    ENABLE_NOISE = 1;
    NOISE_SIGMA = 0.5;

    % Frequency settings
    Fs = 44E3;
    F0 = 2000;
    F1 = 2500;
    FF = 3000;

    % Output file's name
    AUDIO_FILENAME = 'audio_out.wav';
    DATA_FILENAME  = 'mod.csv';
    DATA_CODED_FILENAME = 'mod_cod.csv';

    % When set to 1, plots are generated for input and
    % output signals
    ENABLE_PLOTS = 0;
    ENABLE_DATA_CSV = 1;
    
    % Channel Coding setting
    ENABLE_CODING = 1;

    % Randomly generate a bitstream
    data = data_generate(BITSTREAM_LENGTH); 
    
    % Channel coding
    if ENABLE_CODING == 1
        
        % Find sequence length
        N = length(data);
    
        % Zero extend to get to a multiple of 4
        if mod(N, 4) > 0
            data = [zeros(1, 4 - mod(N, 4)), data];
        end
        
        % Apply coding
        data_to_send = channel_encode(data);
        
        if ENABLE_DATA_CSV == 1
            csvwrite(DATA_CODED_FILENAME, data_to_send);
        end
        
    else
        data_to_send = data;
        
    end
    
    % Call FSK_modulate to modulate the signal
    [mod_signal, t] = FSK_modulate(data_to_send, PULSE_DURATION, Fs, F0, F1, FF, GAIN); 
    
    % Add noise if enabled
    if ENABLE_NOISE == 1
        mod_signal = add_awgn(mod_signal, NOISE_SIGMA);
    end

    if ENABLE_PLOTS == 1
        % Plot bistream contents
        figure;
        subplot(2, 1, 1);
        stem(data, 'red');
    
        % Plot modulated output signal
        subplot(2, 1, 2);
        plot(t, mod_signal, 'blue');
    end

    % Save the modulated signal as an audio file
    audiowrite(AUDIO_FILENAME, mod_signal, Fs);

    % Save bitstream for comparison
    if ENABLE_DATA_CSV == 1
        csvwrite(DATA_FILENAME, data);
    end

end
