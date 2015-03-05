function [ result ] = DEC( self, dest )
%DEC Decrement
%
%   [ result ] = DEC( self, dest )
%
%   Subtracts one from the destination operand. The operand may be a byte
%   or a word and is treated as an unsigned binary number (see AAA and
%   DAA).
%
%   Flags Affected: AF, OF, PF, SF, ZF
%
%   FIXME
%   - [ ] Only works with 16-bit register destinations

if ( ~isprop(self, dest) ) % Destination register doesn't exist
    % Right now the class does not allow lazily creating new registers with
    % the MOV method. New registers must be creating using the Define Word
    % (DW) method. So, we throw an exception.
    msgID = 'OneEightySix:Assembler:DEC:RegisterNotDefined';
    msg = sprintf(['The destination register %s is not defined. ' ...
        'Define new registers with the DW method.'], dest);
    baseException = MException(msgID,msg);
    throw(baseException);
else % Destination register exists 
    [self.(dest), self.OF, self.SF, self.ZF, self.AF, self.PF, ~] ...
        = BitAdd(self, self.(dest), 65535);
end

result = self.(dest);

end

