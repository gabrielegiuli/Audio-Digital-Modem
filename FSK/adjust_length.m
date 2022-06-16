function data_out = adjust_length(data_in)
    % Find sequence length
    N = length(data_in);
    
    % Zero extend to get to a multiple of 4
    if mod(N, 4) > 0
        data_out = [zeros(1, 4 - mod(N, 4)), data_in];
    end
end