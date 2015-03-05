function DW( self, var_name, value )
%DW Declare a 2-byte initialized variable
%   obj.DW(

if ( isprop(self, var_name) ) % var_name already exists, overwrite it
    try
        self.MOV(var_name, value);
    catch E
        rethrow(E);
    end     
else % var_name doesn't exist, create it and MOV the value into it
    self.AddDynamicProperty(var_name, value, false);
    try
        self.MOV(var_name, value);
    catch E
        rethrow(E);
    end     
end

end

