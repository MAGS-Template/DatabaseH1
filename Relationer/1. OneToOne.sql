-- Her sætter vi en database op med 1-1 relation, hvor det både er PK og FK

-- @block Opsæt databasen med følgende kommando
DROP TABLE IF EXISTS ExPassport;
DROP TABLE IF EXISTS ExPerson;

CREATE TABLE ExPerson (
  CPR_number SERIAL PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL
);

CREATE TABLE ExPassport (
  passport_id SERIAL PRIMARY KEY,
  person_id INT UNIQUE,
  expiry_date DATE,
  CONSTRAINT fk_person FOREIGN KEY(person_id) REFERENCES ExPerson(CPR_number) ON DELETE CASCADE
);
-- @block Indsætter personer, hvor PK automatisk bliver påsat
INSERT INTO ExPerson (FirstName, LastName)
VALUES
    ('Harry', 'Potter'),
    ('Hermione', 'Granger'),
    ('Ron', 'Weasley'),
    ('Albus', 'Dubmledore');

-- @block Indsætter data ind på personerne og deres passport_id
INSERT INTO ExPassport (expiry_date, person_id)
VALUES
    ('2030-05-05',  2),
    ('2031-01-01',  1),
    ('2029-12-12',  3);

-- @block Hvis det har kørt i rækkefølge, skal den kode gerne give en fejl!
INSERT INTO ExPassport (expiry_date, person_id)
VALUES
    ('2033-05-05',  2);

-- @block
SELECT * FROM expassport;
SELECT * FROM experson

-- @block Vi tager et kig på vores data
SELECT p.FirstName, p.LastName, ps.expiry_date
FROM ExPerson p
INNER JOIN ExPassport ps ON p.CPR_number = ps.person_id
WHERE ps.expiry_date < '2030-01-01';