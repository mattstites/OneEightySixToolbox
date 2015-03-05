function [ result ] = NEG( self, dest )
%NEG Negate
%
%   [ result ] = NEG( self, dest )
%
%   Subtracts the destination operand, which may be a byte or a word, from
%   0 and returns the result to the destination. This forms the two's
%   complement of the number, effectively reversing the sign of an integer.
%   If the operand is zero, its sign is not changed. Attempting to negate a
%   byte containing -128 or a word containing -32768 causes no change to
%   the operand and set OF.
%
%   Flags Affected: AF, CF, OF, PF, SF, ZF
%
%   FIXME:
%   - [ ] Only works with 16-bit register destinations

if ( OneEightySix.util.tc(self.(dest)) == -32768 )
    self.OF = true;
    result = self.(dest);
else
    carry_flag = ( self.(dest)~=0 ); % CF is a bit different for NEG
    
    % negate the dest value first
    if ( self.(dest) >= 2^15 ) % negative number
        src = OneEightySix.util.tc(self.(dest)) * -1; % convert and negate
    else % positive number
        if ( self.(dest) ~= 0 ) % only need to negate if non-zero
            src = OneEightySix.util.tc(self.(dest)*-1); % negate and convert
        end
    end

    % then perform subtraction: 0 - dest
    [self.(dest), self.OF, self.SF, self.ZF, self.AF, self.PF, self.CF] ...
        = BitAdd(self, 0, src);

    self.CF = carry_flag;
    result = self.(dest);
end

