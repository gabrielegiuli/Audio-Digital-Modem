% **********************************************************************
%
% Project           : DPSK-Over-Audio Communication System
%
% Program name      : TX_side.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This project aims at building a testbench
%                     environment for a simple mean of transmitting
%                     digital data over an audio channel (e.g. 
%                     two way radios) 
%
% **********************************************************************

close all;
clear all;
clc;

FILENAME   = 'data_out.wav'; 

SPAN       = 10; 
SPS        = 50;
UPSAMPLING = 250;
BIT_LENGTH = 1000;

fs = 44E3;
fc = 10000;

% Generating signals
data        = data_generate(BIT_LENGTH);
envelope    = envelope_generate(data, UPSAMPLING, SPAN, SPS);
[signal, t] = signal_modulate(envelope, fs, fc);

% Plotting input data
subplot(3, 1, 1);
stem(data, 'red');
title('Input Bitstream');

% Complex enevelope plot
subplot(3, 1, 2);
plot(envelope, 'blue');
title('Envelope');

% Output DPSK modulated signal
subplot(3, 1, 3);
plot(t, signal, 'black');
title('Modulated Output Signal');
ylabel('s(t)');
xlabel('t (s)');

% Saving output signal
audiowrite(FILENAME, signal, fs);


