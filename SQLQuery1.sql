-- lib management system porject 


-- Let's create our first table = BRANCH which has : branch_id manager_id branch_address contact_no

drop table if exists branch;
CREATE TABLE branch(
	branch_id VARCHAR (15) primary key,
	manager_id VARCHAR (15),
	branch_address VARCHAR (50),
	contact_no VARCHAR (15),
 );

 
 -- Now Let's create secnond table = EMPLOYEES which has : emp_id emp_name position salary branch_id
 drop table if exists employees;
 create table employees (
	 emp_id VARCHAR (15) primary key,
	 emp_name VARCHAR (25),
	 position VARCHAR (25),
	 salary INT,
	 branch_id VARCHAR (25), -- FK
 );

 -- Create books : isbn	book_title	category	rental_price	status	author	publisher
DROP TABLE IF EXISTS books;
CREATE TABLE books
(
            isbn VARCHAR(50) PRIMARY KEY,
            book_title VARCHAR(80),
            category VARCHAR(30),
            rental_price DECIMAL(10,2),
            status VARCHAR(10),
            author VARCHAR(30),
            publisher VARCHAR(30)
);

 -- Create members : member_id	member_name	member_address	reg_date

DROP TABLE IF EXISTS members;
CREATE TABLE members
(
            member_id VARCHAR(15) PRIMARY KEY,
            member_name VARCHAR(25),
            member_address VARCHAR(50),
            reg_date DATE
            
);


-- Now we have : branch , employees , books , members 
-------------------------------------------------------------------
-- Create table "IssueStatus" : issued_id issued_member_id issued_book_name issued_date	issued_book_isbn issued_emp_id
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
(
            issued_id VARCHAR(15) PRIMARY KEY,
			issued_member_id varchar (15), -- fk members_id
			issued_book_name VARCHAR(50), -- fk book_name
            issued_emp_id VARCHAR(25), -- fk emp_id
            issued_book_isbn VARCHAR(50), -- fk isbn from books
            issued_date DATE -- fk members date reg --
            
);


-- last table, return issued : return_id	issued_id	return_book_name	return_date	return_book_isbn

DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status
(
            return_id VARCHAR(15) PRIMARY KEY,
			issued_id varchar (15), -- fk
			return_book_name VARCHAR(50), -- fk
            return_book_isbn VARCHAR(25), -- fk
            return_date DATE 
);



ALTER TABLE issued_status
ADD CONSTRAINT fk_member
foreign key (issued_member_id)
References members(member_id);

ALTER TABLE issued_status
ADD CONSTRAINT fk_books
foreign key (issued_book_isbn)
References books(isbn);


-------------
ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
foreign key (issued_emp_id)
References employees(emp_id);

-----

-- so i've to edit lenght again
"""
Msg 1753, Level 16, State 0, Line 89
Column 'employees.emp_id' is not the same length or scale as referencing column 'issued_status.issued_emp_id' in foreign key 'fk_employees'. Columns participating in a foreign key relationship must be defined with the same length and scale.
Msg 1750, Level 16, State 1, Line 89
Could not create constraint or index. See previous errors.
"""
---

ALTER TABLE employees
ALTER COLUMN emp_id varchar(25);
-------- we can't update it cuz it's a PK so we will change in issued_status
ALTER TABLE issued_status
ALTER COLUMN issued_emp_id varchar(15);

ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
foreign key (issued_emp_id)
References employees(emp_id);


--
""" 
ALTER TABLE employees
ALTER COLUMN branch_id varchar(15); 
-- we did it to change the lenght of the forgin key --
"""

ALTER TABLE employees
ADD CONSTRAINT fk_branch
foreign key (branch_id)
References branch(branch_id);


ALTER TABLE return_status
ADD CONSTRAINT fk_issued_status
foreign key (issued_id)
References issued_status(issued_id);




------ add some other relations 
ALTER TABLE return_status
ALTER COLUMN return_book_isbn VARCHAR(50);

ALTER TABLE return_status
ADD CONSTRAINT fk_return_book
FOREIGN KEY (return_book_isbn)
REFERENCES books(isbn);






ALTER TABLE branch
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id)
REFERENCES employees(emp_id);

ALTER TABLE branch
DROP CONSTRAINT fk_manager;


ALTER TABLE employees
ALTER COLUMN emp_name VARCHAR(50); 


ALTER TABLE branch
ALTER COLUMN manager_id VARCHAR(15) NULL;

ALTER TABLE employees
ALTER COLUMN branch_id VARCHAR(15);


ALTER TABLE return_status
ALTER COLUMN return_book_isbn VARCHAR(50);


ALTER TABLE employees
ALTER COLUMN emp_name VARCHAR(50);





ALTER TABLE return_status
DROP CONSTRAINT fk_return_book_name;

SELECT name
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('return_status');



SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'return_status'
  AND COLUMN_NAME = 'return_book_name';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'issued_status'
  AND COLUMN_NAME = 'issued_book_name';


ALTER TABLE return_status
ALTER COLUMN return_book_name VARCHAR(255);




