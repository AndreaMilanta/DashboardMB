classdef DBHandler < handle
    %DBINTERFACE Provides interface to a database
    
    properties (Access = private)
        p_handler
        p_username
        p_password
    end
    
    methods (Static)
        % function to obtain Singleton instance with Reader credentials
        function out = Reader()
            import DBInterface.*;
            persistent s_ReaderInstance;
            if isa(s_ReaderInstance, 'double') || ~isvalid(s_ReaderInstance)
                s_ReaderInstance = DBHandler(DBConstants.ReaderUN, DBConstants.ReaderPW);
            end
            out = s_ReaderInstance;
        end
        
        % function to obtain Singleton instance with Modifier credentials
        function out = Modifier()
            persistent s_ModifierInstance;
            import DBInterface.*;
            if isa(s_ModifierInstance, 'double') || ~isvalid(s_ModifierInstance)
                s_ModifierInstance = DBHandler(DBConstants.ModifierUN, DBConstants.ModifierPW);
            end
            out = s_ModifierInstance;
        end
    end
    
    methods (Access = private)
        % private constructor for singleton
        function obj = DBHandler(username, password)
            % Set data handling formats
            setdbprefs('DataReturnFormat','table')
            setdbprefs('NullNumberRead', 'NaN');
            setdbprefs('NullStringRead', 'null');
            obj.p_username = username;
            obj.p_password = password;
            obj.Connect();
        end
        
        function Connect(obj)
            import DBInterface.*;
            obj.p_handler = database(DBConstants.DBName, obj.p_username, obj.p_password, ...
                                 'Vendor', DBConstants.Vendor, ...
                                 'Server', DBConstants.ServerURL, ...
                                 'LoginTimeout',  DBConstants.LoginTIMEOUT);
            if ~isopen(obj.p_handler)
                throw(MException('DBHandler:ConnectionFailed' ,'Connection to Database failed'));
            end
        end
    end
    
    methods (Access = public)
        function data = select(obj, query)
        % Executes custom query and returns selected data
            % Check if DB has disconnected and reattempt connection
            if ~isopen(obj.p_handler)
                Close();
                Connect();
            end
            % Execute and validate query
            curs = exec(obj.p_handler, query);
            if ~isopen(curs)
                throw(MException('DBHandler:InvalidQuery' ,'Invalid Query'));
            end
            curs = fetch(curs);
            data = curs.Data;
        end
        
        function curs = ExecQuery(obj, query)
        % Executes custom query and returns selected data
            % Check if DB has disconnected and reattempt connection
            if ~isopen(obj.p_handler)
                Close();
                Connect();
            end
            % Execute and validate query
            curs = exec(obj.p_handler, query);
            if ~isopen(curs)
                throw(MException('DBHandler:InvalidQuery' ,'Invalid Query'));
            end
        end
        
        % Close connection and delete handler
        function Close(obj)
            if isa(obj.p_handler, 'double')
                close(obj.p_handler);
            end
        end
    end
end

