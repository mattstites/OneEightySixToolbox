function test_suite = test_SAL
   initTestSuite;
end

function test_SAL_Success
    myAsm = OneEightySix.Assembler();
    myAsm.MOV('AX', -5);
    myAsm.SAL('AX',1);
    assertEqual(myAsm.AX,-10);
    assertEqual(myAsm.OF,false);
    assertEqual(myAsm.SF,true);
    assertEqual(myAsm.ZF,false);
    assertEqual(myAsm.PF,true);
    assertEqual(myAsm.CF,true);
    myAsm.MOV('AX', 1);
    myAsm.SAL('AX',8);
    assertEqual(myAsm.AX,256);
    assertEqual(myAsm.OF,false);
    assertEqual(myAsm.SF,false);
    assertEqual(myAsm.ZF,false);
    assertEqual(myAsm.PF,true);
    assertEqual(myAsm.CF,false);
end

function test_SAL_Exception_RegisterNotDefined
    myAsm = OneEightySix.Assembler();
    f = @() myAsm.SAL('UNDEF', 5);
    assertExceptionThrown(f, 'OneEightySix:Assembler:SAL:RegisterNotDefined');    
end

