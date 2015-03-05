function [ result ] = SAR( self, dest, count )
%SAR Shift Arithmetic Right
%
%   [ result ] = SAR( self, dest, count )
%
%   Shifts the bits in the destination operand (byte or word) to the right
%   by the number of bits specified in the count operand. Bits equal to the
%   original high-order (sign) bit are shifted in on the left, preserving
%   the sign of the original value. Note that SAR does not produce the same
%   result as the dividend of an "equivalent" IDIV instruction if the 
%   destination operand is negative and 1 bits are shifted out. For 
%   example, shifting –5 right by one bit yields –3, while integer
%   division –5 by 2 yields –2. The difference in the instructions is that
%   IDIV truncates all numbers toward zero, while SAR truncates positive
%   numbers toward zero and negative numbers toward negative infinity.
%
%   Flags Affected: AF(?), CF, OF, PF, SF, ZF
%   (?) - the contents of the flag is undefined after the instruction is
%         executed
%
%   FIXME
%   - Only works with 16-bit register sources

if ( ~isprop(self, dest) ) % Destination register doesn't exist
    msgID = 'OneEightySix:Assembler:SAR:RegisterNotDefined';
    msg = sprintf(['The destination register %s is not defined. ' ...
        'Define new registers with the DW method.'], dest);
    baseException = MException(msgID,msg);
    throw(baseException);
end

if ( isprop(self, count) ) % source operand is a register
    count = self.(count); % so just get the register content
else % source operand is an immed, do input validation
    % TODO: Need to to input validation on immed src
end

dest_bin = dec2bin(self.(dest),16);
dest_tc = OneEightySix.util.tc(self.(dest));
temp = count;
while ( temp )
    self.CF = logical(str2double(dest_bin(16))); % low-order bit of (dest)
    dest_tc = floor(dest_tc/2);
    dest_bin = dec2bin(OneEightySix.util.tc(dest_tc),16);
    temp = temp - 1;
end
self.(dest) = dest_tc;
result = self.(dest);

if ( count == 1 )
    if ( str2double(dest_bin(1)) ~= str2double(dest_bin(1)) )
        self.OF = true;
    else
        self.OF = false;
    end
else
    self.OF = false;
end

self.SF = logical(bitsrl(int32(result),15)); % determine the sign flag
self.ZF = logical(result==0); % determine the zero flag
self.PF = logical(OneEightySix.util.parity(uint16(result))); % determine the parity flag


