function test_suite = test_ADD
   initTestSuite;
end

function test_ADD_Success
    myAsm = OneEightySix.Assembler();
    % Positive addition with constant src
    myAsm.MOV('AX', 0);
    myAsm.ADD('AX', 1);
    assertEqual(myAsm.AX, 1);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, false);
    assertEqual(myAsm.CF, false);
    
    % Consecutive addition with constant src
    myAsm.ADD('AX', 1);
    assertEqual(myAsm.AX, 2);
    
    % Negative addition with constant src
    myAsm.MOV('BX', 65535);
    myAsm.ADD('BX', 65535);
    assertEqual(myAsm.BX, 65534);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, true);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, true);
    assertEqual(myAsm.PF, false);
    assertEqual(myAsm.CF, true);
    
    % Positive addition with register src
    myAsm.MOV('AX', 0);
    myAsm.MOV('BX', 0);
    myAsm.ADD('AX', 'BX');
    assertEqual(myAsm.AX, 0);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, true);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, true);
    assertEqual(myAsm.CF, false);
    
    % Negative addition with overflow
    myAsm.MOV('CX', 32768);
    myAsm.ADD('CX', 32768);
    assertEqual(myAsm.CX, 0);
    assertEqual(myAsm.OF, true);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, true);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, true);
    assertEqual(myAsm.CF, true);
end



