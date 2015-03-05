function [ result ] = IMUL( self, src )
%IMUL Integer Multiply
%
%   [ result ] = IMUL( self, src )
%
%   Performs a signed multiplication of the source operand and the
%   accumulator. If the source is a byte, then it is multiplied bu the
%   register AL, and the double-length result is returned in the AH and AL.
%   If the source is a word, then is is multiplied by register AX, and the
%   double-length result is returned in registers DX and AX. If the upper
%   half of the result (AH for byte source, DX for word source) is not the
%   sign extension of the lower hald of the result, CF and OF are set;
%   otherwise they are cleared. When CF and OF are set, they indicate that
%   AH or DX contains significant digits of the result.
%
%   Flags Affected: AF(?) CF OF PF(?) SF(?) ZF(?)
%   (?) - the contents of the flag is undefined after the instruction is
%         executed
%
%   FIXME
%   - [ ] Only works with 16-bit (word) sources


if isprop(self, src) % source operand is a register
    src = self.(src); % so just get the register content
end

a = OneEightySix.util.tc(self.AX); % convert AX to two's complement
b = OneEightySix.util.tc(src); % convert src to two's complement

result = OneEightySix.util.tc(a * b,32);
result_hex = dec2hex(result,8);
self.DX = hex2dec(result_hex(1:4));
self.AX = hex2dec(result_hex(5:8));

ax_sign = bitsrl(int16(self.AX),15); % get sign of AX
dx_sign = bitsrl(int16(self.DX),15); % get sign of DX

if ( ax_sign ~= dx_sign )
    self.CF = true;
    self.OF = true;
else
    self.CF = false;
    self.OF = false;
end


