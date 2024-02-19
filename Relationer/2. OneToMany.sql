-- @block Lav databasen
DROP TABLE IF EXISTS ExCitizens;
DROP TABLE IF EXISTS ExAddresses;

CREATE TABLE ExAddresses (
  address_id SERIAL PRIMARY KEY,
  roadname VARCHAR(100) NOT NULL,
  house_number INT NOT NULL
);

CREATE TABLE ExCitizens (
    CPR_number SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address_id INT,
    CONSTRAINT fk_address FOREIGN KEY (address_id) REFERENCES ExAddresses(address_id)
);

-- @block Insert dummy data into ExAddresses table
INSERT INTO ExAddresses (roadname, house_number) VALUES
('Main Street',  123),
('Broadway',  456),
('Elm Street',  789);

-- @block Insert dummy data into ExCitizens table
INSERT INTO ExCitizens (name, address_id) VALUES
('John Doe',  1),
('Jane Smith',  1),
('Bob Johnson',  2),
('Alice Brown',  2),
('Charlie White',  3);

-- @block 
SELECT name FROM ExCitizens WHERE address_id =  1;

-- @block 
SELECT roadname, house_number FROM ExAddresses WHERE address_id = (SELECT address_id FROM ExCitizens WHERE name = 'John Doe');

-- @block 
SELECT ExAddresses.roadname, ExAddresses.house_number, ExCitizens.name  
FROM ExAddresses  
JOIN ExCitizens ON ExAddresses.address_id = ExCitizens.address_id;