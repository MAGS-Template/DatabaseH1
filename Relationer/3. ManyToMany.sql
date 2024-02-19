-- @block Drop existing tables if they exist
DROP TABLE IF EXISTS ExBooksExAuthors;
DROP TABLE IF EXISTS ExAuthors;
DROP TABLE IF EXISTS ExBooks;

-- Create the ExAuthors table
CREATE TABLE ExAuthors (
  author_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL
);

-- Create the ExBooks table
CREATE TABLE ExBooks (
  book_id SERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  publication_year INT
);

-- Create the junction table for the many-to-many relationship
CREATE TABLE ExBooksExAuthors (
  book_id INT,
  author_id INT,
  CONSTRAINT fk_book FOREIGN KEY(book_id) REFERENCES ExBooks(book_id) ON DELETE CASCADE,
  CONSTRAINT fk_author FOREIGN KEY(author_id) REFERENCES ExAuthors(author_id) ON DELETE CASCADE,
  PRIMARY KEY (book_id, author_id) -- CompositKey with Book and Author
);


-- @block Insert some ExAuthors
INSERT INTO ExAuthors (first_name, last_name)
VALUES
    ('J.K.', 'Rowling'),
    ('J.R.R.', 'Tolkien'),
    ('George', 'R.R. Martin');

-- @block Insert some ExBooks
INSERT INTO ExBooks (title, publication_year)
VALUES
    ('Harry Potter and the Philosopher''s Stone',  1997),
    ('The Lord of the Rings: The Fellowship of the Ring',  1954),
    ('A Game of Thrones',  1996);

-- @block Associate ExBooks with ExAuthors
INSERT INTO ExBooksExAuthors (book_id, author_id)
VALUES
    (1,  1), -- Harry Potter and the Philosopher's Stone by J.K. Rowling
    (2,  2), -- The Lord of the Rings: The Fellowship of the Ring by J.R.R. Tolkien
    (3,  3); -- A Game of Thrones by George R.R. Martin

-- @block Try to associate a book with an author that doesn't exist (should fail)
INSERT INTO ExBooksExAuthors (book_id, author_id)
VALUES
    (1,  4);

-- @block Select all ExBooks and their ExAuthors
SELECT b.title, a.first_name, a.last_name
FROM ExBooks b
INNER JOIN ExBooksExAuthors ba ON b.book_id = ba.book_id
INNER JOIN ExAuthors a ON ba.author_id = a.author_id;

-- @block Select all ExAuthors and their ExBooks
SELECT a.first_name, a.last_name, b.title
FROM ExAuthors a
INNER JOIN ExBooksExAuthors ba ON a.author_id = ba.author_id
INNER JOIN ExBooks b ON ba.book_id = b.book_id;
