% **********************************************************************
%
% Project           : FSK-Over-Audio Communication System
%
% Program name      : hamming74_decode.m
%
% Author            : Gabriele Johannes Giuli
%
% Date created      : 15/07/2020
%
% Purpose           : This function takes in a 7-bit sequence that was
%                     previously encoded with Hamming(7,4) algorithm
%                     it then performs error correction
%
% **********************************************************************

function [data_out, rx_error] = hamming74_decode(data_in) 
    
    H = [1 0 1 0 1 0 1
         0 1 1 0 0 1 1
         0 0 0 1 1 1 1];
     
     % Calculate syndrome
     tmp = H*data_in';
     z = mod(tmp', 2);
     
     % Find decimal value of syndrome for error correction
     z_dec = bin2dec_convert(z);
     
     % Set flag and perform error correction
     if z_dec == 0
         rx_error = 0;
     else 
         rx_error = 1;
         % Error location is given by syndrome value
         data_in(z_dec) = data_in(z_dec) + 1;
         data_in = mod(data_in, 2);
     end
     
     data_in = mod(data_in, 2);
     
     % Decode sequence
     R = [0 0 1 0 0 0 0
          0 0 0 0 1 0 0
          0 0 0 0 0 1 0
          0 0 0 0 0 0 1];
      
      % Return decoded sequence
      data_out = (R*data_in')';

end