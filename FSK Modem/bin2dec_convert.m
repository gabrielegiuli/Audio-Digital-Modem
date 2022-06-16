% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : bin2dec_convert.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 15/07/2020
%
% Purpose           : Binary to decimal converter
%
% **********************************************************************

function dec = bin2dec_convert(bin)

    % Find bit length
    N = length(bin);
    % Calculate bases
    b = 2.^(N-1:-1:0);
    
    % Multiply and add with scalar vector
    dec = bin*b';
    
end