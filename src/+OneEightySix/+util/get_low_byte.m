function [ l ] = get_low_byte( x )
%GET_LOW_BYTE Returns the low-order byte value of the input X

l = bitand(x, 255);

end

