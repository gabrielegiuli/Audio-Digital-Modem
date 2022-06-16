% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : TEST_TX.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : File for testing the whole process
%
% **********************************************************************


% Reset workspace
close all; 
clear all; 
clc;

% Modulation pulse paramenters
BITSTREAM_LENGTH   = 10000;
PULSE_DURATION     = 2E-3;
WINDOW_DURATION    = 0.9*PULSE_DURATION;
GAIN = 0.5;
    
% Noise settings
ENABLE_NOISE = 1;
NOISE_SIGMA = 0.6;

% Frequency settings
Fs = 44E3;
F0 = 2000;
F1 = 4000;

% Hamming(7,4) Channel coding
CODING_ENABLED = 0;

% Output file's name
AUDIO_FILENAME = 'audio_out.wav';

% Randomly generate a bitstream
data = data_generate(BITSTREAM_LENGTH);

% Channel coding using Hamming(7,4)
if CODING_ENABLED == 1
    sent_data = channel_encode(data);
else
    sent_data = data;
end

% FSK-modulate
mod_signal = FSK_modulate(sent_data, PULSE_DURATION, Fs, F0, F1, GAIN);

% Add noise if enabled
if ENABLE_NOISE == 1
    mod_signal = add_awgn(mod_signal, NOISE_SIGMA);
end

% Save file for sending
audiowrite(AUDIO_FILENAME, mod_signal, Fs);

% Demodulating data
demod_data = FSK_demodulate(mod_signal, PULSE_DURATION, WINDOW_DURATION, Fs, F0, F1);

% Channel coding using Hamming(7,4)
if CODING_ENABLED == 1
    demod_data = channel_decode(demod_data);
end

errors = xor(demod_data, data);

count = 0;
for e = errors
    if e == 1 
        count = count + 1; 
    end
end

BER = count/length(errors)
