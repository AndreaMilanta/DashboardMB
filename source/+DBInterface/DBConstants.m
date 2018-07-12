classdef DBConstants
    %DBCONSTANTS Defines constants for DB connection    
    properties (Constant)
    % Connection properties
        DBName = 'USES4DB';
        Vendor = 'MySQL';
        ServerURL = 'uses4.cq31yhydznth.eu-central-1.rds.amazonaws.com';
%         ServerURL = 'uses4.cq31yhydznth.eu-central-1.rds.amazonaws.com';
        ServerPort = 3306;
        LoginTIMEOUT = 10;
        
    % Credentials
        % Reader credentials
        ReaderUN = 'reader';
        ReaderPW = 'readerpw';
        % Modifier credentials
        ModifierUN = 'dashboard';
        ModifierPW = 'dashboardpw';
    end
    
    % Methods to build query easily
    methods (Static, Access = public)
        function joined = Join(tb1, tb2)
            joined = strcat(tb1, " JOIN ", tb2);
        end

        function joined = JoinOnExt(tb1, tb2, oncl)
            joined = strcat(Join(tb1, tb2), " ON ", oncl);
        end

        function joined = JoinOn(tb1, tb2, cl1, cl2)
            comp = strcat(tb1, ".", cl1, " = ", tb2, ".", cl2);
            joined = JoinOn(tb1, tb2, comp);
        end
    end
end

