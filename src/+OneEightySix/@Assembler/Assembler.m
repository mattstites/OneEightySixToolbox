classdef Assembler < dynamicprops
    %ASSEMBLER Emulates the Intel 80186 assembler instructions.
    %   This class performs emulation of the Intel 80186 assembler
    %   intructions. The class was developed to aid in the development of
    %   simulating and porting Intel 80186 code in MATLAB.
    %
    %   TODO
    %   - Add mutators for the dependent byte registers
    %
    
    %% Default Properties
    properties (GetAccess = public, SetAccess = private)
        % General Registers
        AX; % Accumulator register
        BX; % Base register
        CX; % Count register
        DX; % Data Register
        
        SI; % 
        DI; % 
        BP; % 
        
        % Status Flags
        AF; % Auxiliary flag
        CF; % Carry flag
        OF; % Overflow flag
        SF; % Sign flag
        PF; % Parity flag
        ZF; % Zero flag            
    end % default properties
    
    %% Dependent Properties
    properties (Dependent = true, GetAccess = public, SetAccess = private)
        AL; % Accumulator register low byte
        AH; % Accumulator register high byte
        BL; % Base register low byte
        BH; % Base register high byte
        CL; % Counter register low byte
        CH; % Counter register high byte
        DL; % Data register low byte
        DH; % Data register high byte
    end % dependednt properties
    
    %% Class Constructor
    methods
        function self = Assembler()
            % Assembler constructor
            %   myAssembler() creates a new Assembler object with its own
            %   set of registers and flags.
            
        end % Assembler
    end % constructor method
    
    %% Accessor and Mutator Methods
    methods
        function AL = get.AL(self)
            AL = get_low_byte(self.AX);
        end
        function AH = get.AH(self)
            AH = get_high_byte(self.AX);
        end
        function BL = get.BL(self)
            BL = get_low_byte(self.BX);
        end
        function BH = get.BH(self)
            BH = get_high_byte(self.BX);
        end
        function CL = get.CL(self)
            CL = get_low_byte(self.CX);
        end
        function CH = get.CH(self)
            CH = get_high_byte(self.CX);
        end
        function DL = get.DL(self)
            DL = get_low_byte(self.DX);
        end
        function DH = get.DH(self)
            DH = get_high_byte(self.DX);
        end
    end % accessor and mutator methods
    
    %% Public Methods
    methods ( Access = public )
        % Assembler directives
        DW(self, var_name, value) % Define Word (assembler directive)
                
        % Transfer instructions
        MOV(self, dest, src) % Move
        XCHG(self, dest, src) % Exchange
        
        % Arithmetic instructions
        ADD(self, dest, src) % Add
        ADC(self, dest, src) % Add with Carry
        DEC(self, dest) % Decrement
        IDIV(self, src) % Integer Divide
        IMUL(self, src) % Integer Multiply
        INC(self, dest) % Increment
        MUL(self, dest, src) % Multiply
        NEG(self, dest) % Negate
        SAL(self, dest, count) % Shift Arithmetic Left
        SAR(self, dest, count) % Shift Arithmetic Right
        SUB(self, dest, src) % Subtract
        
        % Logic instructions
        OR(self, dest, src) % Logical OR 
        SHL(self, dest, count) % Shift Logical Left
        
    end % public methods
    
    %% Private Methods
    methods (Access = private)
        [r, of, sf, zf, af, pf, cf] = BitAdd(self, a, b)
        AddDynamicProperty(self, prop, init_val, isReadOnly)
   end % private methods
   
end % Assembler

