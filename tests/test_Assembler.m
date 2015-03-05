function test_suite = test_Assembler
    initTestSuite;
end

function test_Assembler_noArg
    myAssembler = OneEightySix.Assembler();
    assertEqual(class(myAssembler),'OneEightySix.Assembler');
end