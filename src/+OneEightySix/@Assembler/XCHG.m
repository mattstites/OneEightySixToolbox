function XCHG( self, dest, src )
%XCHG Exchange
%
%   XCHG( self, dest, src )
%
%   Switches the contents of the source and destination operands (bytes or
%   words). When used in conjunction with the LOCK prefix, XCHG can test
%   and set a semaphore that contrls access to a resource shared by
%   multiple processors.
%
%   Flags Affected: None
%
%   FIXME
%   - Only works with 16-bit register destinations

if ( ~isprop(self, dest) ) % Destination register doesn't exist
    msgID = 'OneEightySix:Assembler:XCHG:RegisterNotDefined';
    msg = sprintf(['The destination register %s is not defined. ' ...
        'Define new registers with the DW method.'], dest);
    baseException = MException(msgID,msg);
    throw(baseException);
elseif ( ~isprop(self, src) ) % Source register doesn't exist
    msgID = 'OneEightySix:Assembler:XCHG:RegisterNotDefined';
    msg = sprintf(['The source register %s is not defined. ' ...
        'Define new registers with the DW method.'], src);
    baseException = MException(msgID,msg);
    throw(baseException);
else % Destination and source registers exists
    temp = self.(dest);
    self.(dest) = self.(src);
    self.(src) = temp;
end


