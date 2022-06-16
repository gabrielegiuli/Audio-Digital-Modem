% **********************************************************************
%
% Project           : DPSK-Over-Audio Communication System
%
% Program name      : DPSK_encode.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This function encodes a sequence +/- 1 symbols 
%                     using DPSK
%
% **********************************************************************

function pulses_out = DPSK_encode(pulses_in)
    
    % Add leading one
    N = length(pulses_in);
    pulses_out  = ones(1, N+1);
    
    % Iteratively DPSK encode
    for i = 1:N
        % b_n = b_(n-1)*a_n
        pulses_out(i+1) = pulses_out(i)*pulses_in(i);
    end
    
end