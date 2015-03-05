function test_suite = test_IDIV
   initTestSuite;
end

function test_IDIV_Success
    myAsm = OneEightySix.Assembler();
    % Divide -21/5
    myAsm.MOV('DX', -1);
    myAsm.MOV('AX', -21);
    myAsm.MOV('BX', 5);
    myAsm.IDIV('BX');
    assertEqual(myAsm.AX,65532); %-4
    assertEqual(myAsm.DX,65535); %-1
    % Divide 21/-5
    myAsm.MOV('DX', 0);
    myAsm.MOV('AX', 21);
    myAsm.MOV('BX', -5);
    myAsm.IDIV('BX');
    assertEqual(myAsm.AX,65532); %-4
    assertEqual(myAsm.DX,1); 
    % Divide -5000/256
    myAsm.MOV('DX', -1);
    myAsm.MOV('AX', -5000);
    myAsm.MOV('BX', 256);
    myAsm.IDIV('BX');
    assertEqual(myAsm.AX,65517); %-4
    assertEqual(myAsm.DX,65400); %1
end

function test_IDIV_Exception_DivideByZero
    myAsm = OneEightySix.Assembler();
    myAsm.MOV('DX', -1);
    myAsm.MOV('AX', -5000);
    myAsm.MOV('BX', 0);
    f = @() myAsm.IDIV('BX');
    assertExceptionThrown(f, 'OneEightySix:Assembler:IDIV:DivideByZero');    
end



