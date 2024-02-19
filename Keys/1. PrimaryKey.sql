-- Her er der opsætning af en tabel, med en PK. 
-- Det er opsat så simpelt som muligt, og beskrevet inden for de 3 største DB udbydere, MSSQL, MySQL og PostgreSQL. 
-- @block Primary key i MSSQL
CREATE TABLE person (
    CPR_Number int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FirstName varchar(50),
    LastName varchar(50)
    );

-- @block Primary key i MySQL
CREATE TABLE person (
    CPR_Number int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FirstName varchar(50),
    LastName varchar(50)
    );


-- @block Primary key i PostgreSQL
CREATE TABLE person (
    CPR_Number serial PRIMARY KEY,
    FirstName varchar(50),
    LastName varchar(50)
    );


