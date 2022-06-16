% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : plot_FFT.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This function allows to easily plot the FFT 
%                     magnitude and phase plot for a given signal 
%
% **********************************************************************

function plot_FFT(fft, fs)

    % Plot magnitude spectrum
    subplot(2, 1, 1);
    % Find magnitde of FFT
    mag = abs(fft./length(fft));
    plot((0:length(fft)-1).*fs/length(fft), mag);
    title('Magnitude');
    
    % Plot Phase spectrum
    subplot(2, 1, 2);
    % Find phase of FFT
    phase = unwrap(angle(fft));
    phase(mag < 0.01) = 0;
    plot((0:length(fft)-1).*fs/length(fft), unwrap(phase), 'r');
    title('Phase');
    
end