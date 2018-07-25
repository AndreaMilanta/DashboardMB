% Script to test DB
 import DBInterface.*;
 
 db = DBHandler.Reader();
 
 db.select('SELECT * FROM DefectTypes')