GO
USE master --Goes into the master as the first thing
GO

IF DB_ID('BookNick464c') IS NOT NULL
	BEGIN 
	ALTER DATABASE BookNick464c SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		DROP DATABASE BookNick464c
	END
--Creates the database
CREATE DATABASE BookNick464c

GO
USE BookNick464c --Uses the BookNick464c database
GO
--Creating the table for Authors
DROP TABLE IF EXISTS Authors
CREATE TABLE Authors(
AuthorID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --Gives a ID for the authors
[Name] VARCHAR(50),
)

--Creating the table for Borrowers
DROP TABLE IF EXISTS Borrowers
CREATE TABLE Borrowers(
BorrowID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --Gives a ID for the borrowers
Borrowname VARCHAR(20),
Email VARCHAR(50) UNIQUE
)

--Creating the table for Books
DROP TABLE IF EXISTS Books
CREATE TABLE Books(
BooksID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --Gives a ID for the books
Author_ID INT FOREIGN KEY REFERENCES Authors(AuthorID), --References authorID
Borrow_ID INT FOREIGN KEY REFERENCES Borrowers(BorrowID), --References BorrowID
Title VARCHAR(50)
)

--Inserting data into the Authors table
INSERT INTO Authors([Name]) 
VALUES 
('J.K Rowling'),
('Harper Lee'),
('F. Scott Fitzgerald'),
('Jane Austen'),
('J.D Salinger')

--Inserting data into the Borrowers table
INSERT INTO Borrowers(Borrowname, Email) 
VALUES 
('John Smith','johnsmith@example.com'),
('Emma Johnson','emmajohnson@example.com'),
('Michael Brown','michaelbrown@example.com'),
('Sophia Davis','sophiadavis@example.com'),
('William Wilson','williamwilson@example.com')

--Inserting data into the Books table
INSERT INTO Books(Title, Author_ID, Borrow_ID) 
VALUES 
('Harry Potter and the Philospher Stone', 1, 1),
('To Kill a Mockingbird', 2, 2),
('The Great Gastby', 3, 3),
('Pride and Prejudice', 4, 4),
('The Catcher in the Rye', 5, 5)

--Selects booksID, Title and authors to put them together
SELECT Books.BooksID, Books.Title, Authors.[Name]
FROM Books
INNER JOIN Authors
ON Books.Author_ID = Authors.AuthorID;

--Selects booksID, Title, Borrowname and email and puts them together
SELECT Books.BooksID, Books.Title, Borrowers.Borrowname, Borrowers.Email
FROM Books
INNER JOIN Borrowers
ON Books.Borrow_ID = Borrowers.BorrowID;


GO
CREATE PROCEDURE GetBooks --This procedure is made to SELECT everything from Books 
AS
BEGIN
	SELECT * FROM Books;
END;
--Here it executes the prodecure
EXEC GetBooks
GO