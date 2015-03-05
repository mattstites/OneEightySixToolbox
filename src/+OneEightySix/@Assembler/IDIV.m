function [ result ] = IDIV( self, src )
%IDIV Integer Division
%
%   [ result ] = IDIV( self, src )
%
%   Performs a signed division of the accumulator (and its extension) by
%   the source operand. If the source operand is a byte, it is divided into
%   the double-length dividend assumed to be in registers AL and AH; the
%   single-length quotient is returned in AL, and the single-length
%   remainder is returned in AH. For byte integer division, the maximum
%   positive quotient is +127 (&FH) and the minimum negative quotient is
%   -127 (81H).
%
%   If the source operand is a word, it is divided into the double-length
%   dividend in registers AX and DX; the single-length quotient is returned
%   in AX, and the single-length remainder is returned in DX. For word
%   integer division, the maximum positive quotient is +32,767 (7FFFH) and
%   the minimum negative quotient is -32767 (8001H).
%
%   If the quotient is positive and exceeds the maximum, or is negative and
%   is less than the minimum, the quotient and remainder are undefined, and
%   a type 0 interrupt is generated. In particular, this occurs if division
%   by 0 is attempted. Nonintegral quotients are truncated (toward 0) to
%   integers, and the remainder has the same sign as the dividend.
%
%   Flags Affected: AF(?) CF(?) OF(?) PF(?) SF(?) ZF(?)
%   (?) - the contents of the flag is undefined after the instruction is
%         executed
%
%   FIXME
%   - [ ] Only works with 16-bit (word) sources

if isprop(self, src) % source operand is a register
    src = self.(src); % so just get the register content
end

if ( src == 0 ) % Denominator is zero, do not allow division by zero
    msgID = 'OneEightySix:Assembler:IDIV:DivideByZero';
    msg = sprintf('Division by zero is not allowed.');
    baseException = MException(msgID,msg);
    throw(baseException);
else % denominator is not zero
    src = OneEightySix.util.tc(src); % convert src to two's complement
    %dx = OneEightySix.util.tc(self.AX); % convert AX to two's complement
    %ax = OneEightySix.util.tc(self.DX); % convert DX to two's complement
    dxax = hex2dec(strcat(dec2hex(self.DX,4),dec2hex(self.AX,4)));
    dxax = OneEightySix.util.tc(dxax,32); % convert dxax to two's complement

    result = dxax / src;
    if result < 0 % result is negative
        self.AX = OneEightySix.util.tc(ceil(result));
        self.DX = OneEightySix.util.tc(rem(dxax,src));
    else % result is positive
        self.AX = floor(result);
        self.DX = rem(dxax,src);    
    end
end

