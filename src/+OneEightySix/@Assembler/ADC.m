function [ result ] = ADC( self, dest, src )
%ADC Add with Carry
%
%   [ result ] = ADC( self, dest, src )
%
%   Sums the operands, which may be bytes or words, adds one if CF is set
%   and replaces the destination operand with the result. Both operands may
%   be signed or unsigned binary numbers (see AAA and DAA). Since ADC
%   incorporates a carry from a previous operation, it can be used to write
%   routines to add numbers longer than 16 bits.
%
%   Flags Affected: AF, CF, OF, PF, SF, ZF
%
%   FIXME:
  

try
    self.ADD(dest,src);
catch E
    rethrow(E);
end
if self.CF
    try
        self.ADD(dest,1);
    catch E
        rethrow(E);
    end
end
result = self.(dest);

