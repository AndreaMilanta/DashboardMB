classdef DBInterface
    %DBINTERFACE Provides interface to a database
    
    methods (Static)
        % function to obtain Singleton instance
        function out = Instance()
            persistent p_instance;
            if isEmpty(p_instance)
                p_instance = DBInterface();
            end
            out = p_instance;
        end
    end
    
    methods (Access = private)
        % private constructor for singleton
        function obj = DBInterface()
            
        end
    end
    
    methods (Access = public)

    end
end

