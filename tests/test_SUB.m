function test_suite = test_SUB
   initTestSuite;
end

function test_SUB_Success
    myAsm = OneEightySix.Assembler();
    % two positive numbers, src is immed
    myAsm.MOV('AX', 2);
    myAsm.SUB('AX', 1);
    assertEqual(myAsm.AX, 1); % positive result
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, false);
    assertEqual(myAsm.CF, true);
    
    % Consecutive subtraction
    myAsm.SUB('AX', 1);
    assertEqual(myAsm.AX, 0); % zero result
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, true);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, true);
    assertEqual(myAsm.CF, true);
    
    % two negative numbers, src is immed, overflow
    myAsm.MOV('BX', 65535);
    myAsm.SUB('BX', 65535);
    assertEqual(myAsm.BX, 0); % zero result
    assertEqual(myAsm.OF, true);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, true);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, true);
    assertEqual(myAsm.CF, true);
    
    % one positive and one negative number, src is reg
    myAsm.MOV('AX', 5);
    myAsm.MOV('BX', 65535);
    myAsm.SUB('AX', 'BX');
    assertEqual(myAsm.AX, 6); % positive result
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, true);
    assertEqual(myAsm.CF, false);
    
    % one negative and one positive number, src is reg
    myAsm.MOV('AX', 65535);
    myAsm.MOV('BX', 2);
    myAsm.SUB('AX', 'BX');
    assertEqual(myAsm.AX, 65533); % negative result
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, true);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, true);
    assertEqual(myAsm.PF, false);
    assertEqual(myAsm.CF, true);
    
    % positive to negative overflow
    myAsm.MOV('AX', 0);
    myAsm.SUB('AX', 1);
    assertEqual(myAsm.AX, 65535); % negative result
    assertEqual(myAsm.OF, true);
    assertEqual(myAsm.SF, true);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, true);
    assertEqual(myAsm.PF, true);
    assertEqual(myAsm.CF, false);
    
end



