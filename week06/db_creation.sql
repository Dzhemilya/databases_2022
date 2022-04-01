createdb mydb;
psql mydb
  --creating tables 
create table Suppliers (sid int NOT NULL, sname varchar(255) NOT NULL, address varchar(255) NOT NULL);
CREATE TABLE IF NOT EXISTS Parts (pid int NOT NULL PRIMARY KEY, pname varchar(255) NOT NULL, color varchar(255) NOT NULL);
CREATE TABLE IF NOT EXISTS Catalog (sid integer, pid integer, cost float NOT NULL, primary key(sid, pid));
--insert values into tables
INSERT INTO Suppliers (sid, sname, address) VALUES (1, 'Yosemite Sham', E'Devil\'s canyon, AZ'), (2, 'Whiley E.Coyote', 'RR Asylum, NV'), (3, 'Elmer Fudd', 'Carrot Patch, MN');
 
INSERT INTO Parts (pid, pname, color) VALUES (1, 'Red1', 'Red'), (2, 'Red2', 'Red'), (3, 'Green1', 'Green'), (4, 'Blue1', 'Blue'), (5, 'Red3', 'Red');
  
INSERT INTO Catalog (sid, pid, cost) VALUES (1, 1, 10), (1, 2, 20), (1, 3, 30), (1, 4, 40), (1, 5, 50), (2, 1, 9), (2, 3, 34), (2, 5, 48);

