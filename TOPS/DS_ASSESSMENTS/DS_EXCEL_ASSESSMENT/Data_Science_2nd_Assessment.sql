CREATE DATABASE Assessment_MYSQL;

USE Assessment_MYSQL;

CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10,2),
    Hire_Date DATE
);

CREATE TABLE Employee_Audit (
    Audit_Id INT PRIMARY KEY AUTO_INCREMENT,
    Employee_Id INT,
    Name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10,2),
    Hire_Date DATE,
    Action VARCHAR(50),
    Action_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER After_Employee_Insert
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit (Employee_Id, Name, Position, Salary, Hire_Date, Action)
    VALUES (NEW.Employee_ID, NEW.Name, NEW.Position, NEW.Salary, NEW.Hire_Date, 'INSERT');
END;
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE Add_Employee (
    IN Emp_Name VARCHAR(100),
    IN Emp_Position VARCHAR(100),
    IN Emp_Salary DECIMAL(10,2),
    IN Emp_Hire_Date DATE
)
BEGIN
    INSERT INTO Employees (Name, Position, Salary, Hire_Date)
    VALUES (Emp_Name, Emp_Position, Emp_Salary, Emp_Hire_Date);
END;
//

DELIMITER ;

CALL Add_Employee ('John Doe', 'Software Engineer', 80000.00, '2023-10-01');
CALL Add_Employee ('Jane Smith', 'Project Manager', 90000.00, '2021-03-01');
CALL Add_Employee ('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

SELECT * FROM Employee_Audit;
SELECT * FROM Employees;