% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : hamming74_encode.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 15/07/2020
%
% Purpose           : This function takes in a 4-bit sequence and it
%                     encodes it into a 7-bit long sequence with 3 parity
%                     bits that allow for error detection/correction
%
% **********************************************************************

function data_out = hamming74_encode(data_in)
    
    % Code generator matrix
    G = [1 1 0 1
         1 0 1 1
         1 0 0 0
         0 1 1 1
         0 1 0 0
         0 0 1 0
         0 0 0 1];
     
     % Obtain encoded bit sequence
     tmp = G*data_in';
     % Need to find result in mod 2
     data_out = mod(tmp', 2);
     
end