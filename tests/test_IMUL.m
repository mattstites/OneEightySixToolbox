function test_suite = test_IMUL
   initTestSuite;
end

function test_IMUL_Success
    myAsm = OneEightySix.Assembler();
    % Multiply, result is 16-bit, source is reg
    myAsm.MOV('AX', 1);
    myAsm.MOV('BX', 1);
    myAsm.IMUL('BX');
    assertEqual(myAsm.AX,1);
    assertEqual(myAsm.DX,0);
    assertEqual(myAsm.OF,false);
    assertEqual(myAsm.CF,false);
    
    % Multiply, one negative operand, source is reg
    myAsm.MOV('AX', 65535); % -1, two's complement
    myAsm.MOV('BX', 1);
    myAsm.IMUL('BX');
    assertEqual(myAsm.AX,65535);
    assertEqual(myAsm.DX,65535);
    assertEqual(myAsm.OF,false);
    assertEqual(myAsm.CF,false);
    
    % Multiply, one negative operand, source is reg
    myAsm.MOV('AX', 1); 
    myAsm.MOV('BX', 65535); % -1, two's complement
    myAsm.IMUL('BX');
    assertEqual(myAsm.AX,65535);
    assertEqual(myAsm.DX,65535);
    assertEqual(myAsm.OF,false);
    assertEqual(myAsm.CF,false);
    
    % Multiply, two negative operands, source is reg
    myAsm.MOV('AX', 65535); % -1, two's complement
    myAsm.MOV('BX', 65535); % -1, two's complement
    myAsm.IMUL('BX');
    assertEqual(myAsm.AX,1);
    assertEqual(myAsm.DX,0);
    assertEqual(myAsm.OF,false);
    assertEqual(myAsm.CF,false);
    
    % Multiply, one negative operand, source is immed
    myAsm.MOV('AX', 32768); % -32768, two's complement
    myAsm.IMUL(32767);
    assertEqual(myAsm.AX,32768);
    assertEqual(myAsm.DX,49152);
    assertEqual(myAsm.OF,false);
    assertEqual(myAsm.CF,false);
end



