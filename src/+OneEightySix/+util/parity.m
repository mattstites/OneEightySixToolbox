function [ p ] = parity( a )
%PARITY Calculate the parity of the 16-bit input A.
%   References:
%       1. https://graphics.stanford.edu/~seander/bithacks.html#ParityParallel

% unsigned int v;  // word value to compute the parity of
% v ^= v >> 16;
% v ^= v >> 8;
% v ^= v >> 4;
% v &= 0xf;
% return (0x6996 >> v) & 1;

a = bitxor(uint16(a),bitsrl(uint16(a),4));
a = bitand(a,15);
%p = bitand(bitsrl(uint16(27030), a),1);
p = bitand(bitsrl(uint16(38505), a),1);

end
