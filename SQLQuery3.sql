SELECT * FROM books;
Select * FROM members;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;

---------------- NOW LET'S Solve our task&problems :

 -- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books (isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books
where rental_price = 6.00;


-- Task 2: Update an Existing Member's Address
update members
set member_address = '14 mansoura st'
Where member_id = 'C109';


-- Task 3: Delete a Record from the Issued Status Table 

DELETE FROM issued_status
WHERE issued_id = 'IS108';
--- last query can't be done cuz There's another table (named return_status) that depends on the record you're trying to delete from the issued_status table — specifically, the issued_id column there is linked by a Foreign Key relationship to issued_status.issued_id.
SELECT * FROM issued_status
WHERE issued_id = 'IS121';

DELETE FROM issued_status
WHERE issued_id = 'IS121';


-- Task 4: Retrieve All Books Issued by a Specific Employee 
select * from issued_status
where issued_emp_id = 'E107'


-- Task 5: List Members Who Have Issued More Than One Book 

SELECT m.member_id, COUNT(*) AS total_books_issued
FROM members m
INNER JOIN issued_status i ON m.member_id = i.issued_member_id
GROUP BY m.member_id
HAVING COUNT(*) > 1;
------------ OR
SELECT issued_member_id, COUNT(*) AS total_books_issued
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(*) > 1;



-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
-- CTAS = Create Table As Select
SELECT issued_book_name, COUNT(*) AS book_issued_cnt
INTO book_issued_summary
FROM issued_status
GROUP BY issued_book_name;

select * from book_issued_summary;

-- Task 7. Retrieve All Books in a Specific Category:
select * from books 
where category = 'History';

-- Task 8: Find Total Rental Income by Category:
SELECT b.category, SUM(b.rental_price) AS total_rental_income
FROM books b
JOIN issued_status i ON b.isbn = i.issued_book_isbn
GROUP BY b.category;


-- Task 9: List Members Who Registered in the Last 985 Days:
SELECT *
FROM members
WHERE reg_date >= DATEADD(DAY, -985, GETDATE());

-- Task 10: List Employees with Their Branch Manager's Name and Branch Details

SELECT 
    e1.*,
    b.manager_id,
    e2.emp_name as manager
FROM employees as e1
JOIN branch as b ON b.branch_id = e1.branch_id
JOIN employees as e2 ON b.manager_id = e2.emp_id


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
SELECT *
INTO books_price_greater_than_seven
FROM Books
WHERE rental_price > 7;
SELECT * FROM books_price_greater_than_seven;


-- Task 12: Retrieve the List of Books Not Yet Returned

SELECT 
    DISTINCT ist.issued_book_name
FROM issued_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL

    
SELECT * FROM return_status

"""
USE library_project;
GO
"""
