function [ result ] = MOV( self, dest, src )
%MOV Move Byte or Word
%
%   [ result ] = MOV( self, dest, src )
%
%   Transfers a byte or a word from the source operand to the destination
%   operand.
%
%   Flags Affected: None
%
%   FIXME
%   - Only works with 16-bit register destinations

if isprop(self, src) % source operand is a register
    src = self.(src); % so just get the register content
else % src is an immed, do input validation
    if ( isnumeric(src) ) % it's numeric
        if (src >= 0 && src <= 65535) % it's within unsigned range
        elseif (src >= -32768 && src < 0) % it's in the negative signed range
            src = OneEightySix.util.tc(src); % two's complement conversion
        else % Not in range
            msgID = 'OneEightySix:Assembler:MOV:SrcNotInRange';
            msg = sprintf(['The src argument %s is not in range. ' ...
                'Value must be within range of uint16 or int16.'], num2str(src));
            baseException = MException(msgID,msg);
            throw(baseException);
        end
    else
        msgID = 'OneEightySix:Assembler:MOV:SrcNotNumeric';
        msg = sprintf('The src argument must be a numeric type.');
        baseException = MException(msgID,msg);
        throw(baseException);
    end
end

if ( ~isprop(self, dest) ) % Destination register doesn't exist
    self.AddDynamicProperty(dest, src, false); % so add it
else % Destination register exists
    self.(dest) = src;
    result = self.(dest);
end

