% **********************************************************************
%
% Project           : DPSK-Over-Audio Communication System
%
% Program name      : modulate.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This function accepts as input parameter a
%                     bitstream and it generates a DPSK encoded
%                     and modulated output signal
%
% **********************************************************************

function envelope_out = envelope_generate(data_in, upsampling_factor, span, sps)
    
    % Converting bitstream into figures -1 and +1
    pulses = data_in*2 - 1;
    % Encoding DPSK
    pulses = DPSK_encode(pulses);
    % Upsampling signal
    pulses = upsample(pulses, upsampling_factor);
    
    % Root-Raised-Cosine Filter response
    h = rcosdesign(0.25, span, sps);
    
    % Obtaining pulses
    pulses = conv(h, pulses);
    
    % Modulating pulses
    envelope_out = pulses;
    
end