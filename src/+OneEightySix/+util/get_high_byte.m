function [ h ] = get_high_byte( x )
%GET_HIGH_BYTE Returns the high-order byte value of the input X

h = floor(x/256);

end

