function test_suite = test_MUL
   initTestSuite;
end

function test_MUL_Success
    myAsm = OneEightySix.Assembler();
    % Multiply, result is 16-bit
    myAsm.MOV('AX', 1);
    myAsm.MOV('BX', 1);
    myAsm.MUL('BX');
    assertEqual(myAsm.AX,1);
    assertEqual(myAsm.DX,0);
    assertEqual(myAsm.OF,false);
    assertEqual(myAsm.CF,false);
    
    % Multiply, result is 32-bit
    myAsm.MOV('AX', 32767);
    myAsm.MOV('BX', 32767);
    myAsm.MUL('BX');
    assertEqual(myAsm.AX,1);
    assertEqual(myAsm.DX,16383);
    assertEqual(myAsm.OF,true);
    assertEqual(myAsm.CF,true);
    
    % Multiply, smallest result
    myAsm.MOV('AX', 0);
    myAsm.MOV('BX', 0);
    myAsm.MUL('BX');
    assertEqual(myAsm.AX,0);
    assertEqual(myAsm.DX,0);
    assertEqual(myAsm.OF,false);
    assertEqual(myAsm.CF,false);
    
    % Multiply, biggest result
    myAsm.MOV('AX', 65535);
    myAsm.MOV('BX', 65535);
    myAsm.MUL('BX');
    assertEqual(myAsm.AX,1);
    assertEqual(myAsm.DX,65534);
    assertEqual(myAsm.OF,true);
    assertEqual(myAsm.CF,true);
end

function test_MUL_Exception_SourceMustBeRegister
    myAsm = OneEightySix.Assembler();
    % Multiply, exception
    myAsm.MOV('AX', 1);
    f = @() myAsm.MUL(1);
    assertExceptionThrown(f, 'OneEightySix:Assembler:MUL:SourceMustBeRegister'); 
end



