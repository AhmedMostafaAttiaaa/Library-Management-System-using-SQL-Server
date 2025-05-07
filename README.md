# 📚 Library Management System using SQL Server

## 🧾 Overview

This project implements a **Library Management System** using **SQL Server Management Studio (SSMS)**. It simulates real-world operations of a library, such as managing books, branches, members, employees, issuing and returning books, and generating reports.

> 🔗 GitHub Repo: [AhmedMostafaAttiaaa](https://github.com/AhmedMostafaAttiaaa)

---

## 📂 Project Structure

| File/Folder               | Description                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
| `TASKfrom1TO12.sql`       | Contains tasks 1–12: table creation, data insertion, and CRUD operations.  |
| `AdvancedTasksFrom12TOend.sql` | Contains tasks 13–16: CTAS, reports, procedures, and analysis.          |
| `Project_Tasks.sql`       | Contains task descriptions and instructions.                               |
| `insert_books.sql`        | Script to insert sample book data.                                         |
| `insert_members.sql`      | Script to insert sample member data.                                       |
| `insert_employees.sql`    | Script to insert sample employee data.                                     |
| `insert_issued_status.sql`| Script to insert sample issued books data.                                 |
| `insert_return_status.sql`| Script to insert sample return records.                                    |
| `dataset_books.json`      | Contains book dataset used for insertion.                                  |
| `dataset_members.json`    | Contains member dataset used for insertion.                                |
| `dataset_employees.json`  | Contains employee dataset used for insertion.                              |

---

## 🏛️ Database Structure

The system uses a **relational schema** with the following tables:

- **`branch`**: Stores branch info (`branch_id`, `manager_id`, `address`, `contact_no`)
- **`employees`**: Staff working in branches; each assigned to a branch
- **`members`**: Registered library users
- **`books`**: Library book inventory
- **`issued_status`**: Records of issued books (who issued, when, and by whom)
- **`return_status`**: Records of book returns

### 🔗 Table Relationships

- `employees.branch_id` → `branch.branch_id`
- `issued_status.issued_member_id` → `members.member_id`
- `issued_status.issued_emp_id` → `employees.emp_id`
- `issued_status.issued_book_isbn` → `books.isbn`
- `return_status.issued_id` → `issued_status.issued_id`
- `return_status.return_book_isbn` → `books.isbn`
- `branch.manager_id` → `employees.emp_id` (optional)

---

## ⚙️ Prerequisites

Before using this project, make sure you have:

- ✅ **SQL Server Management Studio (SSMS)** installed
- ✅ A running instance of **Microsoft SQL Server**
- ✅ Enabled **execution of stored procedures**
- ✅ Downloaded all required `.sql` and `.json` files from this repository

---

## 🚀 How to Use

1. **Create the Database**:
    ```sql
    CREATE DATABASE library_db;
    USE library_db;
    ```

2. **Run Setup Scripts**:
    - Open `TASKfrom1TO12.sql` in SSMS and execute to create tables and insert sample data
    - Then run `AdvancedTasksFrom12TOend.sql` for advanced queries and reports

3. **Insert Data from Files**:
    Execute the following insert scripts as needed:
    ```sql
    -- Sample insert scripts
    :r insert_books.sql
    :r insert_members.sql
    :r insert_employees.sql
    :r insert_issued_status.sql
    :r insert_return_status.sql
    ```

4. **Run Functional Procedures**:
    Example: Issue a book
    ```sql
    EXEC issue_book 'IS155', 'C108', '978-0-553-29698-2', 'E104';
    ```

    Example: Return a book
    ```sql
    EXEC add_return_records 'RS138', 'IS135', 'Good';
    ```

---

## ✅ Features

- ✅ Table creation with keys & constraints
- ✅ Foreign key enforcement for integrity
- ✅ Insert, Update, Delete, Select operations
- ✅ CTAS for reporting
- ✅ Advanced analytical queries (top employees, overdue fines, revenue)
- ✅ Stored procedures for real workflow automation (issue & return)

---

## 📈 Example Reports

- Books issued by an employee
- Active members in last 2 months
- Overdue books and fine calculation
- Branch-level revenue and book counts
- Most active employees

---

## 📬 Contact

For questions, suggestions, or contributions, feel free to fork the repo or open an issue.

GitHub: [AhmedMostafaAttiaaa](https://github.com/AhmedMostafaAttiaaa)
---
