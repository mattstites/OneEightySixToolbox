function test_suite = test_OR
   initTestSuite;
end

function test_OR_Success
    myAsm = OneEightySix.Assembler();
    myAsm.MOV('AX', 5);
    myAsm.MOV('BX', 3);
    myAsm.OR('AX','BX');
    assertEqual(myAsm.AX,7);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.PF, false);
    assertEqual(myAsm.CF, false);
    myAsm.MOV('AX', 2);
    myAsm.OR('AX',8);
    assertEqual(myAsm.AX,10);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.PF, true);
    assertEqual(myAsm.CF, false);
end

function test_OR_Exception_RegisterNotDefined
    myAsm = OneEightySix.Assembler();
    f = @() myAsm.OR('UNDEF', 5);
    assertExceptionThrown(f, 'OneEightySix:Assembler:OR:RegisterNotDefined');    
end

