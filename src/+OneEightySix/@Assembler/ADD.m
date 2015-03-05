function [ result ] = ADD( self, dest, src )
%ADD Addition
%
%   [ result ] = ADD( self, dest, src )
%
%   Sums two operands, which may be bytes or words, replaces the
%   destination operand. Both operands may be signed or unsigned binary
%   numbers (see AAA and DAA).
%
%   Flags Affected: AF, CF, OF, PF, SF, ZF
%
%   FIXME:
%   - Only works with 16-bit register destinations

if isprop(self, src) % source operand is a register
    src = self.(src); % so just get the register content
end

[self.(dest), self.OF, self.SF, self.ZF, self.AF, self.PF, self.CF] ...
    = BitAdd(self, self.(dest), src);

result = self.(dest);

