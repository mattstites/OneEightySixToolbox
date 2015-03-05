function test_suite = test_SHL
   initTestSuite;
end

function test_SHL_Success
    myAsm = OneEightySix.Assembler();
    myAsm.MOV('AX', -5);
    myAsm.SHL('AX',1);
    assertEqual(myAsm.AX,-10);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, true);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.PF, true);
    assertEqual(myAsm.CF, true);
end

function test_SHL_Exception_RegisterNotDefined
    myAsm = OneEightySix.Assembler();
    f = @() myAsm.SHL('UNDEF', 5);
    assertExceptionThrown(f, 'OneEightySix:Assembler:SHL:RegisterNotDefined');    
end

