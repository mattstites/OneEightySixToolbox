function test_suite = test_XCHG
   initTestSuite;
end

function test_XCHG_Success
    myAsm = OneEightySix.Assembler();
    myAsm.MOV('AX', 1);
    myAsm.MOV('BX', -1);
    myAsm.XCHG('AX', 'BX');
    assertEqual(myAsm.AX,65535);
    assertEqual(myAsm.BX,1);
    myAsm.XCHG('AX', 'BX');
    assertEqual(myAsm.AX,1);
    assertEqual(myAsm.BX,65535);
end