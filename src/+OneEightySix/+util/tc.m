function [ x ] = tc( x, n )
%TC Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
  n = 16;
end
if x < 0 % convert from negative decimal to tc
    x = x + (x<0).*2^n; 
else % convert from tc to negative decimal
    x = x - (x >= 2.^(n-1)).*2.^n;
end

end

