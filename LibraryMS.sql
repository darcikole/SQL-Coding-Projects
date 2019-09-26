CREATE DATABASE db_libraryMS
GO

USE db_libraryMS

	CREATE TABLE library_branch (
	BranchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	BranchName VARCHAR(50) NOT NULL,
	BranchAddress VARCHAR(100) NOT NULL
	);

	CREATE TABLE Publisher (
	PublisherID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	PublisherName VARCHAR(50) NOT NULL,
	PubPhone VARCHAR(20) NOT NULL,
	PubAddress VARCHAR(100) NOT NULL
	);

	CREATE TABLE Books (
	BookID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	Title VARCHAR(50) NOT NULL,
	PublisherID INT NOT NULL CONSTRAINT fk_PublisherName FOREIGN KEY REFERENCES Publisher(PublisherID) ON UPDATE CASCADE ON DELETE CASCADE,
	AuthorID INT NOT NULL CONSTRAINT fk_AuthorID FOREIGN KEY REFERENCES Book_Authors(AuthorID) ON UPDATE CASCADE ON DELETE CASCADE
	);

	CREATE TABLE Book_Authors (
	AuthorID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	AuthorName VARCHAR(50) NOT NULL
	);

	CREATE TABLE Book_Copies (
	BookID INT NOT NULL  CONSTRAINT fk_B_C_BookID FOREIGN KEY REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	Number_Of_Copies INT NOT NULL,
	BranchID INT NOT NULL CONSTRAINT fk_B_C_BranchID FOREIGN KEY REFERENCES library_branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE 
	);

	CREATE TABLE Book_Loans (
	BookID INT NOT NULL CONSTRAINT fk_B_L_BookID FOREIGN KEY REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	DateOut DATE NOT NULL,
	DateDue DATE NOT NULL,
	BranchID INT NOT NULL CONSTRAINT fk_BranchID FOREIGN KEY REFERENCES library_branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	CardNo INT NOT NULL CONSTRAINT fk_CardNo FOREIGN KEY REFERENCES Borrower(CardNo) ON UPDATE CASCADE ON DELETE CASCADE
	);

	CREATE TABLE Borrower (
	CardNo INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	B_Name VARCHAR(100) NOT NULL,
	B_Address VARCHAR(100) NOT NULL,
	B_Phone VARCHAR(50) NOT NULL
	);



	INSERT INTO library_branch 
	(BranchName, BranchAddress)
	VALUES
	('Sharpstown','9720 8th Ave SW, Seattle, WA 98106'),
	('Central','100 Mill Ave S, Renton, WA 98057'),
	('Burien','400 SW 152nd St, Burien, WA 98166'),
	('Des Moines','21620 11th Ave S, Des Moines, WA 98198')
	;

	

	INSERT INTO Publisher
	([PublisherName],[PubAddress],[PubPhone])
	VALUES
	('Penguin Random House','345 Hudson Street, New York, NY 10014','646-674-4000'),
	('HarperCollins','195 Broadway, New York, NY 10007','212-207-7000'),
	('Hachette Book Group','1290 6th Ave, New York, NY 10104','212-364-1100'),
	('Macmillan','4 crinan st, London N1 9XW, UK','44-20-7843-3600'),
	('Simon & Schuster','1230 6th AVe, New York, NY 10020','212-698-7000')
	;

		SELECT * FROM dbo.Book_Authors;
		


	INSERT INTO Books 
	([Title],[AuthorID],[PublisherID])
	VALUES
	('The Lost Tribe',1,1),
	('IT',2,2),
	('Cujo',2,2),
	('Dreamcatcher',2,2),
	('High Fidelity',3,4),
	('Fever Pitch',3,4),
	('Juliet, Naked',3,4),
	('The Bourne Identity',4,3),
	('The Bourne Supremacy',4,3),
	('The Bourne Ultimatum',4,3),
	('Killing Floor',5,1),
	('Tripwire',5,1),
	('Pride and Prejudice',10,4),
	('Death on the Nile',6,4),
	('The Hobbit',8,4),
	('The Adventures of Sherlock Holmes',7,4),
	('The Sign of Four',7,4),
	('The Firm',9,5),
	('The Pelican Brief',9,5),
	('The Associate',9,5)
	;

	SELECT * FROM Books;

	INSERT INTO Book_Authors
	([AuthorName])
	VALUES
	('Matthew Caldwell'),
	('Stephen King'),
	('Nick Hornby'),
	('Robert Ludlum'),
	('Lee Child'),
	('Agatha Christie'),
	('Sir Arthur Conan Doyle'),
	('J.R.R. Tolkein'),
	('John Grisham'),	
	('Jane Austen ')
	; 
	
	SELECT * FROM Book_Authors;

	INSERT INTO Borrower
	([B_Name], [B_Address], [B_Phone])
	VALUES
	('Darci','Burien','206-771-4468'),
	('Dalia','Burien','206-794-4938'),
	('Ryan','Renton','509-638-5596'),
	('Jerry','Seattle','973-978-4571'),
	('Will','Tukwila','509-218-3820'),
	('Tara','Renton','253-653-1790'),
	('Ann','Des Moines','206-849-1678'),
	('Dina','Des Moines','509-594-1822')
	;

	SELECT * FROM library_branch;

	INSERT INTO dbo.Book_Copies
	([BranchID], [BookID],[Number_Of_Copies])
	VALUES
	(1,2,3),
	(1,5,3),
	(1,8,3),
	(1,9,3),
	(1,10,3),
	(1,14,3),
	(1,16,3),
	(1,17,3),
	(1,20,3),
	(1,21,3),
	(2,3,3),
	(2,4,3),
	(2,12,3),
	(2,13,3),
	(2,15,3),
	(2,17,3),
	(2,18,3),
	(2,6,3),
	(2,14,3),
	(2,2,3),
	(3,2,3),
	(3,3,3),
	(3,4,3),
	(3,5,3),
	(3,6,3),
	(3,7,3),
	(3,8,3),
	(3,9,3),
	(3,10,3),
	(3,11,3),
	(4,12,3),
	(4,13,3),
	(4,14,3),
	(4,15,3),
	(4,16,3),
	(4,17,3),
	(4,18,3),
	(4,19,3),
	(4,20,3),
	(4,21,3)
	;

	INSERT INTO dbo.Book_Loans
	([CardNo],[BranchID],[BookID],[DateOut],[DateDue])
	VALUES
	(1, 3, 2, '20190415', '20191015'),
	(1, 3, 3, '20190515', '20191115'),
	(1, 3, 4, '20190615', '20191215'),
	(1, 3, 5, '20190615', '20191215'),
	(1, 3, 6, '20190615', '20191215'),
	(1, 3, 8, '20190615', '20191215'),
	(1, 3, 9, '20190326', '20190926'),
	(1, 3, 11, '20190615', '20191215'),
	(1, 3, 12, '20190401', '20191001'),
	(1, 3, 13, '20190615', '20191215'),
	(1, 3, 14, '20190615', '20191215'),
	(1, 3, 16, '20190501', '20191101'),
	(1, 3, 15, '20190601', '20191201'),
	(1, 3, 17, '20190615', '20191215'),
	(1, 3, 18, '20190326', '20190926'),
	(1, 3, 19, '20190615', '20191215'),
	(1, 3, 21, '20190615', '20191215'),
	(1, 3, 7,  '20190601', '20191201'),
	(1, 3, 10, '20190601', '20191201'),
	(1, 3, 20, '20190601', '20191201'),
	(2, 3, 3,  '20190430', '20191030'),
	(2, 3, 16, '20190430', '20191030'),
	(2, 3, 14, '20190415', '20191015'),
	(3, 2, 2, '20190430', '20191030'),
	(3, 2, 3,  '20190415', '20191015'),
	(3, 2, 4, '20190430', '20191030'),
	(3, 2, 5, '20190430', '20191030'),
	(3, 2, 6, '20190430', '20191030'),
	(3, 2, 7, '20190430', '20191030'),
	(3, 2, 8, '20190430', '20191030'),
	(3, 2, 9, '20190430', '20191030'),
	(3, 2, 10, '20190430', '20191030'),
	(3, 2, 11, '20190515', '20191115'),
	(3, 2, 12, '20190415', '20191015'),
	(3, 2, 13, '20190430', '20191030'),
	(3, 2, 14, '20190430', '20191030'),
	(3, 2, 15, '20190430', '20191030'),
	(3, 2, 16, '20190415', '20191015'),
	(3, 2, 17, '20190430', '20191030'),
	(3, 2, 18, '20190415', '20191015'),
	(3, 2, 19, '20190415', '20191015'),
	(3, 2, 20, '20190430', '20191030'),
	(3, 2, 21, '20190430', '20191030'),
	(4, 1, 4,  '20190415', '20191015'),
	(4, 1, 2,  '20190515', '20191115'),
	(4, 1, 17, '20190326', '20190926'),
	(6, 2, 8,  '20190415', '20191015'),
	(7, 4, 21, '20190515', '20191115'),
	(8, 4, 5,  '20190415', '20191015')
	;

	SELECT * FROM Book_Loans;