function [ result ] = OR( self, dest, src )
%OR Logical OR
%
%   [ result ] = OR( self, dest, src )
%
%   Performs the logical "inclusive or" of the two operands (bytes or
%   words) and returns the results to the destination operand. A bit in the
%   result is set if wither or both corresponding buts in the original
%   operands are setl otherwise the result bit is cleared.
%
%   Flags Affected: AF(?), CF, OF, PF, SF, ZF
%   (?) - the contents of the flag is undefined after the instruction is
%         executed
%
%   FIXME
%   - Only works with 16-bit register sources

if ( ~isprop(self, dest) ) % Destination register doesn't exist
    msgID = 'OneEightySix:Assembler:OR:RegisterNotDefined';
    msg = sprintf(['The destination register %s is not defined. ' ...
        'Define new registers with the DW method.'], dest);
    baseException = MException(msgID,msg);
    throw(baseException);
end

if ( isprop(self, src) ) % source operand is a register
    src = self.(src); % so just get the register content
else % source operand is an immed, do input validation
    % TODO: Need to to input validation on immed src
end

self.(dest) = double(bitor(uint16(self.(dest)),uint16(src)));
result = self.(dest);

self.CF = false; % clear the carry flag
self.OF = false; % clear the overflow flag
self.SF = logical(bitsrl(int32(result),15)); % determine the sign flag
self.ZF = logical(result==0); % determine the zero flag
self.PF = logical(OneEightySix.util.parity(uint16(result))); % determine the parity flag

