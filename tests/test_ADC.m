function test_suite = test_ADC
   initTestSuite;
end

function test_ADC_Success
    myAsm = OneEightySix.Assembler();
    % Addition with no carry
    myAsm.MOV('AX', 0);
    myAsm.ADC('AX', 1);
    assertEqual(myAsm.AX, 1);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, false);
    assertEqual(myAsm.CF, false);
    
    % Addition with carry
    myAsm.MOV('BX', 65535);
    myAsm.ADC('BX', 65535);
    assertEqual(myAsm.BX, 65535);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, true);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, true);
    assertEqual(myAsm.PF, true);
    assertEqual(myAsm.CF, false);
    
end



