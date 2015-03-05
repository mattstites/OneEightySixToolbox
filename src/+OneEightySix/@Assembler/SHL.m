function [ result ] = SHL( self, dest, count )
%SHL Shift Logical Left
%
%   [ result ] = SHL( self, dest, count )
%
%   Shifts the destination byte or word left by the number of bits
%   specified in the count operand. Zeros are shifted in on the right. If
%   the sign bit retains its original value, then OF is cleared.
%
%   Flags Affected: AF(?), CF, OF, PF, SF, ZF
%   (?) - the contents of the flag is undefined after the instruction is
%         executed
%
%   FIXME
%   - Only works with 16-bit register sources

if ( ~isprop(self, dest) ) % Destination register doesn't exist
    msgID = 'OneEightySix:Assembler:SHL:RegisterNotDefined';
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
    dest_tc = floor(dest_tc*2);
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


