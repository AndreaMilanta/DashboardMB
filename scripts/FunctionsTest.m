% scripts to test functions 

import DBInterface.*;

try
    h_read = DBHandler.Reader();
    data = h_read.select('SELECT * from DefectTypes');
    disp(data);
    h_read.Close();
    delete(h_read);
    clear h_read;
catch ME
    disp(getReport(ME, 'basic'));
end
