
--Procedure 1
CREATE PROCEDURE dbo.uspGetBookCopyNum @BookName nvarchar(50), @BranchName nvarchar(50) 
AS
SELECT Book_Copies.Number_Of_Copies
FROM Book_Copies
INNER JOIN Books ON Book_Copies.BookID = Books.BookID
INNER JOIN library_branch ON Book_Copies.BranchID = library_branch.BranchID
WHERE Books.Title = @BookName
And library_branch.BranchName = @BranchName
Go

--Procedure 2
CREATE PROCEDURE dbo.uspGetCopyperBranch @BookName nvarchar(50)
AS
SELECT Book_Copies.Number_Of_Copies, library_branch.BranchID
FROM Book_Copies
INNER JOIN Books ON Book_Copies.BookID = Books.BookID
INNER JOIN library_branch ON Book_Copies.BranchID = library_branch.BranchID
WHERE Books.Title = @BookName

Go

-- Procedure 3
CREATE PROCEDURE dbo.uspGetNoBorrows
AS
SELECT B_Name
FROM Borrower
LEFT OUTER JOIN Book_Loans ON Borrower.CardNo = Book_Loans.CardNo
WHERE Book_Loans.CardNo IS NULL
Go

-- Procedure 4
CREATE PROCEDURE dbo.uspGetDueToday @BranchName nvarchar(50), @TodaysDate date
AS
SELECT Books.Title, Borrower.B_Name, Borrower.B_Address
FROM Book_Loans
INNER JOIN Books ON Book_Loans.BookID = Books.BookID
INNER JOIN Borrower ON Book_Loans.CardNo = Borrower.CardNo
INNER JOIN library_branch ON Book_Loans.BranchID = library_branch.BranchID
WHERE BranchName = @BranchName
AND DateDue = @TodaysDate
GO
 

 -- Procedure 5
 CREATE PROCEDURE dbo.uspGetBranchLoanTotals @BranchName nvarchar(50)
 AS
 SELECT BranchName, COUNT(*)
 FROM Book_Loans
 FULL OUTER JOIN library_branch ON Book_Loans.BranchID = library_branch.BranchID
 WHERE BranchName = @BranchName
 GROUP BY BranchName
 GO



 -- Procedure 6
 CREATE PROCEDURE dbo.uspGetBigReaders 
 AS
 SELECT B_Name, B_Address, COUNT(BookID)
 FROM Borrower
 INNER JOIN Book_Loans ON Borrower.CardNo = Book_Loans.CardNo
 GROUP BY B_Name, B_Address
 HAVING COUNT(BookID) > 5
 GO

 -- Procedure 7
 CREATE PROCEDURE dbo.uspGetAuthorByBranch @BranchName nvarchar(50), @AuthorName nvarchar(50)
 AS 
 SELECT Title, Number_Of_Copies
 FROM Books
 INNER JOIN Book_Copies ON Books.BookID = Book_Copies.BookID
 INNER JOIN Book_Authors ON Books.AuthorID = Book_Authors.AuthorID
 FULL JOIN library_branch ON Book_Copies.BranchID = library_branch.BranchID
 WHERE BranchName = @BranchName AND AuthorName = @AuthorName
 GO 