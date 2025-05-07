SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;

  

-- Advanced SQL Operations


/*
Task 13: 
Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 380-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue.
*/

-- SOLUION 

/* we need to do multiple join here
	we will firslty join issued_statues with members so we've issue data with members id and name
	then we will join the last q with books so we've title of the book
	then we will join them with return_status so we calculate the days overdue from return_date
	also we will use reg_date from members col

	overdue should be >380 days
*/

select * from issued_status; -- here we have issued_book_isbn
select * from books; -- here we have isbn which will join the last query (issued_book_isbn) in multiple rows
select * from members; -- here we have id and name of members 

SELECT *
FROM issued_status as ist
JOIN 
members as m ON m.member_id = ist.issued_member_id
join
books as b ON b.isbn = ist.issued_book_isbn
left join 
return_status as rs ON rs.issued_id = ist.issued_id

--Display the member's_id, member's name, book title, issue date, and days overdue.


SELECT ist.issued_emp_id, m.member_name, b.book_title , ist.issued_date, rs.return_date,
	DATEDIFF(DAY, ist.issued_date, GETDATE()) AS days_overdue
FROM issued_status as ist
JOIN 
members as m ON m.member_id = ist.issued_member_id
join
books as b ON b.isbn = ist.issued_book_isbn
left join 
return_status as rs ON rs.issued_id = ist.issued_id
where rs.return_date is not null AND (DATEDIFF(DAY, ist.issued_date, GETDATE()) ) > 380;



/* 
Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" 
when they are returned (based on entries in the return_status table).
*/

CREATE PROCEDURE add_return_records
    @p_return_id VARCHAR(10),
    @p_issued_id VARCHAR(10),
    @p_book_quality VARCHAR(10)
AS
BEGIN
    DECLARE @v_isbn VARCHAR(50);
    DECLARE @v_book_name VARCHAR(80);

    -- Step 1: Insert into return_status
    INSERT INTO return_status (return_id, issued_id, return_date, book_quality)
    VALUES (@p_return_id, @p_issued_id, GETDATE(), @p_book_quality);

    -- Step 2: Get book details from issued_status
    SELECT 
        @v_isbn = issued_book_isbn,
        @v_book_name = issued_book_name
    FROM issued_status
    WHERE issued_id = @p_issued_id;

    -- Step 3: Update book status to 'yes'
    UPDATE books
    SET status = 'yes'
    WHERE isbn = @v_isbn;

    -- Step 4: Print a thank-you message
    PRINT 'Thank you for returning the book: ' + @v_book_name;
END;


/* Task 15: Branch Performance Report
Create a query that generates a performance report for each branch, 
showing the number of books issued, the number of books returned,
and the total revenue generated from book rentals. */
SELECT * FROM branch;

-- أولًا: إنشاء الجدول يدويًا بتحديد الأعمدة
CREATE TABLE branch_reports (
    branch_id VARCHAR(10),
    manager_id VARCHAR(10),
    number_book_issued INT,
    number_of_book_return INT,
    total_revenue DECIMAL(10,2)
);

SELECT 
    b.branch_id,
    b.manager_id,
    COUNT(ist.issued_id) AS number_book_issued,
    COUNT(rs.return_id) AS number_of_book_return,
    SUM(bk.rental_price) AS total_revenue
INTO branch_reports
FROM issued_status AS ist
JOIN employees AS e ON e.emp_id = ist.issued_emp_id
JOIN branch AS b ON e.branch_id = b.branch_id
LEFT JOIN return_status AS rs ON rs.issued_id = ist.issued_id
JOIN books AS bk ON ist.issued_book_isbn = bk.isbn
GROUP BY b.branch_id, b.manager_id;

select * from branch_reports;


/* Task 16: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing 
members who have issued at least one book in the last 2 months.*/ 

SELECT DISTINCT m.*
INTO active_members
FROM members AS m
JOIN issued_status AS ist
    ON m.member_id = ist.issued_member_id
WHERE ist.issued_date >= DATEADD(DAY, -60, GETDATE());

select * from active_members

select * from members