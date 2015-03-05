function [ result ] = MUL( self, src )
%MUL Multiply
%
%   [ result ] = MUL( self, src )
%
%   Performs an unsigned multiplication of the source operand and teh
%   accumulator. If the source is a byte, then it is multiplied by register
%   AL, and the double-length result is returned in AH and AL. If the
%   source operand is a word, then it is multiplied by register AX, and the
%   double-length result is returned in registers DX and AX. The operands
%   are treated as unsigned binary numbers (see AAM). If the upper half of
%   the result (AH for byte source, DX for word source) is non-zero, CF and
%   OF are set; otherwise they are cleared.
%
%   Flags Affected: AF(?) CF OF PF(?) SF(?) ZF(?)
%   (?) - the contents of the flag is undefined after the instruction is
%         executed
%
%   FIXME
%   - [ ] Only works with 16-bit register sources

if isprop(self, src) % source operand must a register
    result_hex = dec2hex((self.AX * self.(src)),8);
    self.DX = hex2dec(result_hex(1:4));
    self.AX = hex2dec(result_hex(5:8));
    if ( self.DX )
        self.CF = true;
        self.OF = true;
    else
        self.CF = false;
        self.OF = false;
    end
else
    msgID = 'OneEightySix:Assembler:MUL:SourceMustBeRegister';
    msg = sprintf(['The source operand must be a register for this ' ...
        'instruction.']);
    baseException = MException(msgID,msg);
    throw(baseException);
end

