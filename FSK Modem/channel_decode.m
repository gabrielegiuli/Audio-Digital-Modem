% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : channel_decode.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This function divides a bit sequence into 4-bit
%                     sequences and uses Hamming(7,4) encoding
%
% **********************************************************************


function data_out = channel_decode(data_in)
    
    % Apply Hamming to sequence
    N = length(data_in);
    data_out = zeros(1, N*4/7);
    
    % Iteratively add encoded sequence
    count = 1;
    for i = 1:7:N
        sequence = hamming74_decode(data_in(i:i+6));
        data_out(count:count+3) = sequence;
        count = count + 4;
    end
    
end