CREATE DATABASE IF NOT EXISTS MyJoinsDB;

USE MyJoinsDB;

DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS EmployeeSalary;
DROP TABLE IF EXISTS EmployeePersonalInfo;
-- Создание первой таблицы для имен и номеров телефонов сотрудников
CREATE TABLE Employees (
    EmployeeID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL
);

-- Вставка примерных данных в таблицу Employees
INSERT INTO Employees (FirstName, LastName, PhoneNumber)
VALUES
('Иван', 'Иванов', '123-456-7890'),
('Анна', 'Петрова', '987-654-3210'),
('Сергей', 'Сидоров', '555-123-4567'),
('Ольга', 'Кузнецова', '789-012-3456');

-- Создание второй таблицы для информации о зарплате и должностях сотрудников
CREATE TABLE EmployeeSalary (
    EmployeeID INT NOT NULL PRIMARY KEY,
    Position VARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL
);

-- Вставка примерных данных в таблицу EmployeeSalary
INSERT INTO EmployeeSalary (EmployeeID, Position, Salary)
VALUES
(1, 'Генеральный директор', 100000.00),
(2, 'Менеджер', 60000.00),
(3, 'Рабочий', 45000.00),
(4, 'Рабочий', 60000.00);

-- Создание третьей таблицы для личной информации
CREATE TABLE EmployeePersonalInfo (
    EmployeeID INT NOT NULL PRIMARY KEY,
    MaritalStatus VARCHAR(20),
    BirthDate DATE,
    Residence VARCHAR(100)
);

-- Вставка примерных данных в таблицу EmployeePersonalInfo
INSERT INTO EmployeePersonalInfo (EmployeeID, MaritalStatus, BirthDate, Residence)
VALUES
(1, 'Женат', '1980-05-15', 'ул. Главная, Город А'),
(2, 'Не замужем', '1990-02-28', 'ул. Дубовая, Город Б'),
(3, 'Женат', '1985-11-10', 'ул. Сосновая, Город В'),
(4, 'Не замужем', '1995-07-22', 'ул. Вязовая, Город Г');


SELECT FirstName, LastName, PhoneNumber, 
    (SELECT Residence FROM EmployeePersonalInfo WHERE EmployeePersonalInfo.EmployeeID = Employees.EmployeeID) AS Residence
FROM Employees;


SELECT FirstName, LastName, 
    (SELECT BirthDate FROM EmployeePersonalInfo WHERE EmployeePersonalInfo.EmployeeID = Employees.EmployeeID) AS BirthDate
FROM Employees
WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeePersonalInfo WHERE MaritalStatus = 'Не замужем');

SELECT FirstName, LastName, 
    (SELECT BirthDate FROM EmployeePersonalInfo WHERE EmployeePersonalInfo.EmployeeID = Employees.EmployeeID) AS BirthDate,
    PhoneNumber
FROM Employees
WHERE EmployeeID IN (
    SELECT EmployeeID FROM EmployeeSalary WHERE Position = 'Менеджер'
);