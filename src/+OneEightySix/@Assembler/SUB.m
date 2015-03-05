function [ result ] = SUB( self, dest, src )
%SUB Subtract
%
%   [ result ] = SUB( self, dest, src )
%
%   The source operand is subtracted from the destination operand, and the
%   result replaces the destination operand. The operands may be bytes or
%   words. Both operands may be signed or unsigned binary numbers (see AAS
%   and DAS).
%
%   Flags Affected: AF, CF, OF, PF, SF, ZF
%
%   FIXME
%   - [ ] Only works with 16-bit register destinations

if isprop(self, src) % source operand is a register
    src = self.(src); % so just get the register content
end

% negate the src value first
if ( src >= 2^15 ) % negative number
    src = OneEightySix.util.tc(src) * -1; % convert and negate
else % positive number
    if ( src ~= 0 ) % only need to negate if non-zero
        src = OneEightySix.util.tc(src*-1); % negate and convert
    end
end

% then perform subtraction by adding the negative
[self.(dest), self.OF, self.SF, self.ZF, self.AF, self.PF, self.CF] ...
    = BitAdd(self, self.(dest), src);

result = self.(dest);

end

