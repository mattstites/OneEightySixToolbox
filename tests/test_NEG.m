function test_suite = test_NEG
   initTestSuite;
end

function test_NEG_Success
    myAsm = OneEightySix.Assembler();
    % Negate a positive number
    myAsm.MOV('AX', 2);
    myAsm.NEG('AX');
    assertEqual(myAsm.AX, 65534);
    assertEqual(myAsm.OF, true);
    assertEqual(myAsm.SF, true);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, true);
    assertEqual(myAsm.PF, false);
    assertEqual(myAsm.CF, true);
    
    % Negate a negative number
    myAsm.NEG('AX');
    assertEqual(myAsm.AX, 2);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, false);
    assertEqual(myAsm.CF, true);
    
    % Negate -32768
    myAsm.MOV('AX', 32768);
    myAsm.NEG('AX');
    assertEqual(myAsm.AX, 32768);
    assertEqual(myAsm.OF, true);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, false);
    assertEqual(myAsm.CF, true);    
    
end



