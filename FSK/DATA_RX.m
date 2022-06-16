% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : DATA_RX.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This program allows to demodulated the audio
%                     file generated with DATA_TX.m 
%
% **********************************************************************

function DATA_RX()

    % Reset workspace
    %close all; 
    %clear all; 
    %clc; 

    % Modulation pulse paramenters
    PULSE_DURATION     = 2E-3;
    GAIN = 1;

    % Frequency settings
    F0 = 2000;
    F1 = 2500;
    FF = 3000;
    BW = 50;

    % Output file's name
    AUDIO_FILENAME = 'audio_out.wav';
    DATA_FILENAME  = 'demod.csv';
    DATA_CODED_FILENAME = 'demod_cod.csv';

    % When set to 1, plots are generated for input and
    % output signals
    ENABLE_PLOTS = 0;
    ENABLE_DATA_CSV = 1;
    
    % Channel Coding setting
    ENABLE_CODING = 1;

    % Read modulated signal from file and obtain spectrum
    [mod_signal, Fs] = audioread(AUDIO_FILENAME);
    signal_FFT = fft(mod_signal);

    data = FSK_demodulate(mod_signal, PULSE_DURATION, Fs, F0, F1, FF, BW);
    
    if ENABLE_CODING == 1
        % Save bitstream for comparison
        if ENABLE_DATA_CSV == 1
            csvwrite(DATA_CODED_FILENAME, data);
        end
        data = channel_decode(data);
    end
    
    if ENABLE_PLOTS == 1
        % Plot magnitude and phase spectra
        figure;
        plot_FFT(signal_FFT, Fs);
    
        % Plot obtained bitstream
        figure;
        stem(data);
    end

    % Save bitstream for comparison
    if ENABLE_DATA_CSV == 1
        csvwrite(DATA_FILENAME, data);
    end

end 


