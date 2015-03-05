function test_suite = test_INC
   initTestSuite;
end

function test_INC_Success
    myAsm = OneEightySix.Assembler();
    % Increment from 0
    myAsm.MOV('AX', 0);
    myAsm.INC('AX');
    assertEqual(myAsm.AX,1);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, false);
    
    % Increment a positive
    myAsm.INC('AX');
    assertEqual(myAsm.AX, 2);
    assertEqual(myAsm.OF, false);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, false);
  
    % Increment 32767
    myAsm.MOV('AX', 32767);
    myAsm.INC('AX');
    assertEqual(myAsm.AX, 32768);
    assertEqual(myAsm.OF, true);
    assertEqual(myAsm.SF, true);
    assertEqual(myAsm.ZF, false);
    assertEqual(myAsm.AF, true);
    assertEqual(myAsm.PF, true);   
    
    % Increment max value
    myAsm.MOV('AX', 65535);
    myAsm.INC('AX');
    assertEqual(myAsm.AX,0);
    assertEqual(myAsm.OF, true);
    assertEqual(myAsm.SF, false);
    assertEqual(myAsm.ZF, true);
    assertEqual(myAsm.AF, false);
    assertEqual(myAsm.PF, true);    
end



