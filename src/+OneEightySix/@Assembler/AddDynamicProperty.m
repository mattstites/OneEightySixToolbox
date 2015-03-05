function AddDynamicProperty(self, prop, init_val, isReadOnly)
    % input arguments
    narginchk(2,4);
    if nargin < 3, init_val = []; end
    if nargin < 4, isReadOnly = true; end

    % create dynamic property
    p = addprop(self, prop);

    % set initial value if present
    self.(prop) = init_val;

    % define property accessor methods
    % NOTE: this has to be a simple function_handle (@fun), not
    % an anonymous function (@()..) to avoid infinite recursion
    p.GetMethod = @get_method;
    p.SetMethod = @set_method;

    % nested getter/setter functions with closure
    function set_method(obj, val)
        if isReadOnly
            ME = MException('OneEightySix:Assembler:SetProhibited', sprintf(...
              'You cannot set the read-only property ''%s'' of %s', ...
              prop, class(obj)));
            throwAsCaller(ME);
        end
        obj.(prop) = val;
    end
    function val = get_method(obj)
        val = obj.(prop);
    end
end % add_dyn_prop
 

