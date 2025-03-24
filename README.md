# DB-Caplan-and-Gold-LLP
This project is a database design for the Caplan &amp; Gold LLP Employee Management System, which efficiently manages employee records, roles, departments, and salaries. It includes a UML-based ERD, DDL scripts for table creation, and key definitions to ensure structured data management.

**Project: CaplanandGold LLP Employee Management System**

### Project Description
This project is a database design for the **CaplanandGold LLP Employee Management System**, which efficiently manages employee records, roles, departments, and salaries. It includes a **UML-based ERD**, **DDL scripts for table creation**, and **key definitions** to ensure structured data management.

### Contents:
- **Conceptual ERD** (UML notation)
- **SQL DDL Statements** (Table creation with primary keys)
- **Key Definitions** (Candidate, Primary, Composite, Surrogate, and Foreign Keys)

This repository is ideal for learning database design principles and best practices.

---

### How to Run and Implement the Database

#### **Prerequisites**
Ensure you have the following installed:
- MySQL Server (or any other SQL-compatible database system)
- MySQL Workbench or any SQL client
- A tool for viewing ER diagrams (e.g., Lucidchart, Draw.io, Visio)

#### **Steps to Implement**
1. **Clone the Repository**
   ```sh
   git clone https://github.com/yourusername/caplan-gold-employee-db.git
   cd caplan-gold-employee-db
   ```

2. **Set Up the Database**
   - Open MySQL Workbench or connect to MySQL Server.
   - Create a new database:
     ```sql
     CREATE DATABASE CaplanandGold;
     USE CaplanandGold;
     ```
   - Run the `caplanandgoldllp.sql` file to create the required tables:
     ```sh
     mysql -u your_user -p CaplanandGold < caplanandgoldllp.sql
     ```

3. **Insert Sample Data (Optional)**
   - Run the `caplanandgoldllp.sql` file to insert test data:
     ```sh
     mysql -u your_user -p CaplanandGold < caplanandgoldllp.sql
     ```

4. **Verify the Setup**
   - Check if tables are created:
     ```sql
     SHOW TABLES;
     ```
   - Retrieve sample data:
     ```sql
     SELECT * FROM Employee;
     ```

5. **Modify & Extend the Database**
   - Update `caplanandgoldllp.sql` for additional fields.
   - Use `queries.sql` to write and test SQL queries.
   - Modify and extend based on project requirements.


