function test_suite = test_DEC
   initTestSuite;
end

function test_DEC_Success
    myAsm = OneEightySix.Assembler();
    % Decrement from 0
    myAsm.MOV('AX', 0);
    myAsm.DEC('AX');
    assertEqual(myAsm.AX,65535);
    assertEqual(myAsm.OF, true);
    assertEqual(myAsm.SF, true);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, true);
    assertEqual(myAsm.PF, true);
    
    % Decrement a negative
    myAsm.DEC('AX');
    assertEqual(myAsm.AX, 65534);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, true);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, true);
    assertEqual(myAsm.PF, false);
  
    % Decrement 32768
    myAsm.MOV('AX', 32768);
    myAsm.DEC('AX');
    assertEqual(myAsm.AX, 32767);
    assertEqual(myAsm.OF, true);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, true);
    assertEqual(myAsm.PF, true);   
    
    % Decrement from 1
    myAsm.MOV('AX', 1);
    myAsm.DEC('AX');
    assertEqual(myAsm.AX,0);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, true);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, true);    
end



