function test_suite = test_SAR
   initTestSuite;
end

function test_SAR_Success
    myAsm = OneEightySix.Assembler();
    myAsm.MOV('AX', -5);
    myAsm.SAR('AX',1);
    assertEqual(myAsm.AX,-3);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, true);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.PF, true);
    assertEqual(myAsm.CF, true);
end

function test_SAR_Exception_RegisterNotDefined
    myAsm = OneEightySix.Assembler();
    f = @() myAsm.SAR('UNDEF', 5);
    assertExceptionThrown(f, 'OneEightySix:Assembler:SAR:RegisterNotDefined');    
end

