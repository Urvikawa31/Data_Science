CREATE DATABASE MarketCo;

USE MarketCo;

CREATE TABLE Company(
	CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10)
);

INSERT INTO Company (CompanyID, CompanyName, Street, City, State, Zip)
VALUES 
(111, 'Tech Vision Ltd', '101 Birch St', 'Phoenix', 'AZ', '85001'),
(112, 'Toll Brothers', '250 Gibraltar Rd.', 'Horsham', 'PA', '19044'),
(113, 'GreenTech Solutions', '303 Walnut Blvd', 'Miami', 'FL', '33101'),
(114, 'Urban Outfitters, Inc.', '5000 South Broad St.', 'Philadelphia', 'PA', '19112');

-- 1) Statement to create the Contact table 
CREATE TABLE Contact (
    ContactID INT  PRIMARY KEY,
	CompanyID INT,
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID),
    FirstName VARCHAR(45) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10),
    IsMain Boolean,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(12)
);

INSERT INTO Contact (ContactID, CompanyID, FirstName, LastName, Street, City, State, Zip, IsMain, Email, Phone) 
VALUES
(211, 111, 'John', 'Doe', '101 Birch St', 'Phoenix', 'AZ', '85001', TRUE, 'john.doe@example.com', '555-123-4567'),
(212, 112, 'Emily', 'Johnson', '303 Walnut Blvd', 'Miami', 'FL', '33101', TRUE, 'emily.johnson@example.com', '555-456-7890'),
(213, 113, 'Jack', 'Lee', '4777 Cameron Rd.', 'Buffalo', 'NY', '14209', 1, 'jlee@urbanout.com', '215-454-5500'),
(214, 114, 'Michael', 'Brown', '404 Maple Ln', 'Seattle', 'WA', '98101', FALSE, 'michael.brown@example.com', '555-321-6548');

-- 2) Statement to create the Employee table 
CREATE TABLE Employee (
	EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(45) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    Salary DECIMAL(10,2),
    HireDate DATE,
    JobTitle VARCHAR(25),
    Email VARCHAR(45) UNIQUE,
    Phone VARCHAR(12)
);

INSERT INTO Employee (EmployeeID, FirstName, LastName, Salary, HireDate, JobTitle, Email, Phone)
VALUES
(201, 'Alice', 'Williams', 75000.00, '2020-06-15', 'Software Engineer', 'alice.williams@example.com', '555-123-4567'),
(202, 'Bob', 'Anderson', 68000.00, '2019-04-22', 'Data Analyst', 'bob.anderson@example.com', '555-234-5678'),
(203, 'Dianne', 'Connor', 85000.00, '2011-08-12', 'Project Manager', 'dconnor@marketco.com', '215-555-5679'),
(204, 'Lesley', 'Bland', 72000.26, '2024-12-31', 'Marketing', 'lesley.bland@ravaltextile.com', '555-456-7890');

/*3) Statement to create the ContactEmployee table  
HINT: Use DATE as the datatype for ContactDate. It allows you to store the 
date in this format: YYYY-MM-DD (i.e., ‘2014-03-12’ for March 12, 2014).*/
CREATE TABLE ContactEmployee (
    ContactEmployeeID INT PRIMARY KEY,
    ContactID INT,
    FOREIGN KEY (ContactID) REFERENCES Contact(ContactID),
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    ContactDate DATE,
    Description VARCHAR(100)
);

INSERT INTO ContactEmployee (ContactEmployeeID, ContactID, EmployeeID, ContactDate, Description) 
VALUES
(501, 211, 201, '2023-06-15', 'Discussed project requirements and deadlines'),
(502, 212, 202, '2023-07-20', 'Reviewed data analysis progress'),
(503, 213, 203, '2023-08-10', 'Introduced new software features'),
(504, 214, 204, '2023-09-05', 'Discussed HR policies and updates');

-- 4) In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800  
UPDATE Employee
SET Phone = '215-555-8800'
WHERE EmployeeID = 204;

-- 5) In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters” .
UPDATE Company
SET CompanyName = 'Urban Outfitters'
WHERE CompanyID = 114 AND CompanyName = 'Urban Outfitters, Inc.';

/*6)  In ContactEmployee table, the statement that removes Dianne Connor’s contact 
event with Jack Lee (one statement). 
HINT: Use the primary key of the ContactEmployee table to specify the correct record to remove.*/
DELETE FROM ContactEmployee
WHERE ContactEmployeeID = 503;

/*7) Write the SQL SELECT query that displays the names of the employees that 
have contacted Toll Brothers (one statement). Run the SQL SELECT query in 
MySQL Workbench. Copy the results below as well.*/

SELECT  e.FirstName, e.LastName
FROM Employee as e
JOIN ContactEmployee as ce ON e.EmployeeID = ce.EmployeeID
JOIN Contact as c ON ce.ContactID = c.ContactID
JOIN Company as co ON c.CompanyID = co.CompanyID
WHERE co.CompanyName = 'Toll Brothers';

-- 8) What is the significance of “%” and “_” operators in the LIKE statement? 

/*The % and _ operators are wildcard characters that help define the pattern:
1) "%"(percent sign) :- Allows you to match any string of any length. where length of character is zero, one, or multiple characters in a string.
	Ex:LIKE 'A%' :- Means start with A. (ex; Appu, ABC)
	   %B- Means anything thats end with B.(ex; BOB ,ROB)
2) "_"(Underscore) :- Allows you to match on a single character.
			-If you use single underscore(_) means single character find
            -IF you use more than one underscore means find more than more character(ex; use two underscore it means find two characters.)
	Ex:LIKE 'P_' :- means find exact one character after P.(ex; PR,PC)
		LIKE 'P___':- means find 3 character after P.(ex; Peer,Pick)
*/

-- 9) Explain normalization in the context of databases.

/*Normalization in databases is the process of organizing data to reduce redundancy and improve efficiency.
 It involves breaking down large tables into smaller, related ones, ensuring each table focuses on a single entity.
 This helps prevent data duplication, ensures consistency, and simplifies updates. */
 
 -- 10) What does a join in MySQL mean?  
 
/*Join in MySql is a SQL operation used to combine records from two or more tables based on a related column between them.
It allows you to retrieve data that is spread across multiple tables and bring it together into a single result set. 
Joins are used when there is a logical relationship between the tables.
- THERE ARE FIVE TYPES OF JOIN:
1)INNER JOIN
2)LEFT OUTER JOIN(Left JOIN)
3)RIGHT OUTER JOIN(Right JOIN)
4)FULL OUTER JOIN(Full JOIN)
5)CROSS JOIN(Cartesian JOIN)
*/

-- 11)What do you understand about DDL, DCL, and DML in MySQL?

/*1)DDL (Data Definition Language): Defines the structure of the database.
 Commands like CREATE, ALTER, and DROP are used to create and modify tables and databases.

2)DCL (Data Control Language): Controls access to data and manages user permissions 
Commands like GRANT and REVOKE are used to give or take away access rights for users.

3)DML (Data Manipulation Language): Handles data inside the database. 
Commands like SELECT, INSERT, UPDATE, and DELETE are used to retrieve, add, change, or remove data.
*/

-- 12) What is the role of the MySQL JOIN clause in a query, and what are some common types of joins? 

/*The JOIN clause in MySQL is used to combine rows from two or more tables based on a related column between them.
The primary role of the JOIN is to enable you to retrieve and present data that resides in multiple tables,based on relationships between those tables.

1)INNER JOIN:- Returns only the rows that have matching values in both tables. 
If there is no match, those rows are excluded from the result.

2)LEFT JOIN :- Returns all records from the left table (the first table), and the matched records from the right table.
If no match is found, it will return NULL for columns from the right table.

3)RIGHT JOIN:- Returns all records from the right table (the second table), and the matched records from the left table. 
If no match is found, it will return NULL for columns from the left table.

4. FULL JOIN:- Returns all records when there is a match in either the left or the right table. 
It combines the results of both LEFT JOIN and RIGHT JOIN. 
If there is no match, it returns NULL for the missing side.

5)CROSS JOIN:- Returns the Cartesian product of two tables.
It combines each row from the first table with each row from the second table. 
This results in every possible combination of rows from both tables.
*/