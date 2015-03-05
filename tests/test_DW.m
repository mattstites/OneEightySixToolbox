function test_suite = test_DW
   initTestSuite;
end

function test_DW_Success
    myAsm = OneEightySix.Assembler();
    myAsm.DW('UNDEF', 5);
    assertEqual( myAsm.UNDEF, 5 );
    myAsm.DW('UNDEF', 0);
    assertEqual( myAsm.UNDEF, 0 );
end