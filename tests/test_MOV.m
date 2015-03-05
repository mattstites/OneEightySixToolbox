function test_suite = test_MOV
   initTestSuite;
end

function test_MOV_Success
    myAsm = OneEightySix.Assembler();
    myAsm.MOV('AX', 5);
    assertEqual(myAsm.AX,5);
    myAsm.MOV('AX', -1);
    assertEqual(myAsm.AX,65535);    
end

function test_MOV_Exception_SrcNotInRange
    myAsm = OneEightySix.Assembler();
    f = @() myAsm.MOV('AX', -32769);
    assertExceptionThrown(f, 'OneEightySix:Assembler:MOV:SrcNotInRange');  
    f = @() myAsm.MOV('AX', 655356);
    assertExceptionThrown(f, 'OneEightySix:Assembler:MOV:SrcNotInRange');
end

function test_MOV_Exception_SrcNotNumeric
    myAsm = OneEightySix.Assembler();
    f = @() myAsm.MOV('AX', '1');
    assertExceptionThrown(f, 'OneEightySix:Assembler:MOV:SrcNotNumeric');  
end