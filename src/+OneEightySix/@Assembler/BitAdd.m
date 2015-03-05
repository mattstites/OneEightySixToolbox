function [r, of, sf, zf, af, pf, cf] = BitAdd( self, a, b )
%BITADD Perform binary addition and set flags appropriately.
%       1. http://teaching.idallen.com/dat2343/10f/notes/040_overflow.txt

% initialize variables
of = false; % overflow flag
sf = false; % sign flag
zf = false; % zero flag
af = false; % aux carry flag
pf = false; % parity flag
cf = false; % carry flag

% perform addition
r = a + b;

% check for carry
if (r >= 2^16) % carry flag is set
    r = r - 2^16;
    cf = true;
end

% set sign flag and check for overflow
sf = logical(bitsrl(int32(r),15));
sa = bitsrl(int32(a),15);
sb = bitsrl(int32(b),15);
if (~sa && ~sb && sf) % addition: overflow
    of = true;
elseif (sa && sb && ~sf) % addition: overflow
    of = true;
elseif (~sa && sb && sf) % substraction: overflow
    of = true;
elseif (sa && ~sb && ~sf) % substraction: overflow
    of = true;
end

% set zero flag
zf = logical(r==0);

% set the auxiliary carry flag
af = logical(bitand(bitsrl(int16(r),8),1));

% calculate the parity flag
pf = logical(OneEightySix.util.parity(uint16(r)));

