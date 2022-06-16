% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : channel_encode.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 14/07/2020
%
% Purpose           : This function divides a bit sequence into 4-bit
%                     sequences and uses Hamming(7,4) encoding
%
% **********************************************************************


function data_out = channel_encode(data_in)
    
    % Find sequence length
    N = length(data_in);
    
    % Zero extend to get to a multiple of 4
    if mod(N, 4) > 0
        data_in = [zeros(1, 4 - mod(N, 4)), data_in];
    end
    
    % Apply Hamming to sequence
    N = length(data_in);
    data_out = zeros(1, N*7/4);
    
    % Iteratively add encoded sequence
    count = 1;
    for i = 1:4:N
        sequence = hamming74_encode(data_in(i:i+3));
        data_out(count:count+6) = sequence;
        count = count + 7;
    end
    
end