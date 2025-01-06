-- Create Database
CREATE DATABASE IF NOT EXISTS BloodBankManagement;

-- Use Database
USE BloodBankManagement;

-- Create Tables
CREATE TABLE Patientinfo (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    PatientName VARCHAR(40) NOT NULL,
    ContactAddress VARCHAR(100),
    PhoneNo VARCHAR(15) UNIQUE,
    Bloodgroup VARCHAR(10) CHECK (Bloodgroup IN ('A(+ve)', 'A(-ve)', 'B(+ve)', 'B(-ve)', 'AB(+ve)', 'AB(-ve)', 'O(+ve)', 'O(-ve)'))
);

CREATE TABLE Donarinfo (
    DonarID INT PRIMARY KEY AUTO_INCREMENT,
    DonarName VARCHAR(40) NOT NULL,
    ContactAddress VARCHAR(100),
    PhoneNo VARCHAR(15) UNIQUE,
    BloodGroup VARCHAR(10),
    LastDonationDate DATE,
    DonarStatus VARCHAR(20)
);

CREATE TABLE Bloodbank (
    Bloodgroupid INT PRIMARY KEY AUTO_INCREMENT,
    Bloodgroupname VARCHAR(10)
);

CREATE TABLE Registration (
    Registrationid INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DonarID INT,
    Bloodgroupid INT,
    FOREIGN KEY (PatientID) REFERENCES Patientinfo(PatientID),
    FOREIGN KEY (DonarID) REFERENCES Donarinfo(DonarID),
    FOREIGN KEY (Bloodgroupid) REFERENCES Bloodbank(Bloodgroupid)
);

CREATE TABLE AuditDonarinfo (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    DonarID INT,
    DonarName VARCHAR(40) NOT NULL,
    ContactAddress VARCHAR(100),
    PhoneNo VARCHAR(15) UNIQUE,
    BloodGroup VARCHAR(10),
    LastDonationDate DATE,
    DonarStatus VARCHAR(20),
    Auditaction VARCHAR(50),
    Auditactiontime DATETIME
);

-- Insert data into Patientinfo
INSERT INTO Patientinfo (PatientName, ContactAddress, PhoneNo, Bloodgroup)
VALUES ('Fahad', 'Chattagram', '01822335159', 'B(+ve)'),
       ('Iqbal', 'Dhaka', '01114001459', 'A(+ve)'),
       ('Iqram', 'Comilla', '01922005333', 'A(-ve)'),
       ('Mahadi', 'Khulna', '01722005444', 'B(-ve)'),
       ('Sarwar', 'Syleth', '01622005551', 'O(-ve)'),
       ('Amdadul', 'Noakhali', '01522005666', 'AB(+ve)'),
       ('Rafiq', 'Barishal', '01422005777', 'O(+ve)'),
       ('Arosh', 'Rangpur', '01322005888', 'AB(-ve)');
       
-- Insert data into Donarinfo table
INSERT INTO Donarinfo (DonarName, ContactAddress, PhoneNo, BloodGroup, LastDonationDate, DonarStatus)
VALUES ('Max', 'Chattagram', '01952335159', 'B(+ve)', '2021-01-01', 'unable'),
       ('Milton', 'Dhaka', '01165481459', 'A(+ve)', '2021-10-01', 'Capable'),
       ('Imran', 'Comilla', '01998745333', 'A(-ve)', '2021-09-01', 'Capable'),
       ('Marup', 'Khulna', '01722154444', 'B(-ve)', '2021-08-01', 'Capable'),
       ('Sam', 'Syleth', '01636985551', 'O(-ve)', '2021-07-01', 'Capable'),
       ('Alex', 'Noakhali', '01574125666', 'AB(+ve)', '2020-01-01', 'Capable'),
       ('Roman', 'Barishal', '01426542777', 'O(+ve)', '2021-01-01', 'Unable'),
       ('Alan', 'Rangpur', '01354125888', 'AB(-ve)', '2021-01-01', 'Unable');

-- Insert data into Bloodbank table
INSERT INTO Bloodbank (Bloodgroupid, Bloodgroupname)
VALUES (1, 'A(+ve)'), (2, 'A(-ve)'), (3, 'B(+ve)'), (4, 'B(-ve)'),
       (5, 'AB(+ve)'), (6, 'AB(-ve)'), (7, 'O(+ve)'), (8, 'O(-ve)');

-- Insert data into Registration table
INSERT INTO Registration (PatientID, DonarID, Bloodgroupid)
VALUES (1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4),
       (5, 5, 5), (6, 6, 6), (7, 7, 7), (8, 8, 8);
-- Insert into auditdonarinfo
INSERT INTO AuditDonarinfo (DonarName, ContactAddress, PhoneNo, BloodGroup, LastDonationDate, DonarStatus, AuditAction, AuditActionTime)
VALUES 
    ('John Doe', '123 Main St', '555-1234', 'A+', '2023-01-01', 'Active', 'Insert', NOW()),
    ('Alice Smith', '456 Elm St', '555-5678', 'O-', '2023-02-15', 'Inactive', 'Insert', NOW()),
    ('Bob Johnson', '789 Oak St', '555-9012', 'B+', '2023-03-10', 'Active', 'Insert', NOW()),
    ('Emily Wilson', '101 Pine St', '555-2468', 'AB+', '2023-04-20', 'Active', 'Insert', NOW()),
    ('Michael Brown', '202 Cedar St', '555-3698', 'A-', '2023-05-05', 'Inactive', 'Insert', NOW()),
    ('Sophia Miller', '303 Maple St', '555-4812', 'B-', '2023-06-15', 'Active', 'Insert', NOW()),
    ('Jacob Davis', '404 Birch St', '555-5963', 'AB-', '2023-07-25', 'Active', 'Insert', NOW()),
    ('Emma Martinez', '505 Walnut St', '555-6789', 'O+', '2023-08-30', 'Inactive', 'Insert', NOW());


-- Update Patientinfo
UPDATE Patientinfo
SET PatientName = 'Mohin'
WHERE PatientID = 5;

-- Update Donarinfo
UPDATE Donarinfo
SET PhoneNo = '01892938278'
WHERE DonarID = 5;

-- Delete from Patientinfo
DELETE FROM Patientinfo
WHERE PatientID = 7;

-- Delete from Donarinfo
DELETE FROM Donarinfo
WHERE DonarID = 3;

-- Select data from Patientinfo
SELECT * FROM Patientinfo;

-- Select data from Donarinfo
SELECT * FROM Donarinfo;

-- Select data from Bloodbank
SELECT * FROM Bloodbank;

-- Select data from Registration
SELECT * FROM Registration;

-- Select data from AuditDonarinfo
SELECT * FROM AuditDonarinfo;

-- This query joins the "Patientinfo", "Registration", "Donarinfo", and "Bloodbank" tables, 
-- groups the results by blood group name, filters out blood groups with no registrations, 
-- and then sorts the results by blood group name in descending order.
SELECT Bloodgroupname, COUNT(Registrationid) AS RegistrationCount
FROM Patientinfo
JOIN Registration ON Patientinfo.PatientID = Registration.PatientID
JOIN Donarinfo ON Donarinfo.DonarID = Registration.DonarID
JOIN Bloodbank ON Bloodbank.Bloodgroupid = Registration.Bloodgroupid
GROUP BY Bloodgroupname
HAVING RegistrationCount > 0
ORDER BY Bloodgroupname DESC;

-- Add Age column to Donarinfo table
ALTER TABLE Donarinfo
ADD Age VARCHAR(10);

-- Delete Age column from Donarinfo table
ALTER TABLE Donarinfo
DROP COLUMN Age;

-- Inner Join
SELECT Donarinfo.DonarName, Patientinfo.PatientName
FROM Donarinfo
INNER JOIN Patientinfo ON Patientinfo.PatientID = Donarinfo.DonarID;

-- Right Join
SELECT Donarinfo.DonarName, Patientinfo.PatientName
FROM Donarinfo
RIGHT JOIN Patientinfo ON Patientinfo.PatientID = Donarinfo.DonarID;

-- Left Join
SELECT Donarinfo.DonarName, Patientinfo.PatientName
FROM Donarinfo
LEFT JOIN Patientinfo ON Patientinfo.PatientID = Donarinfo.DonarID;

-- Full Join (MySQL does not support FULL JOIN directly)
SELECT Donarinfo.DonarName, Patientinfo.PatientName
FROM Donarinfo
LEFT JOIN Patientinfo ON Patientinfo.PatientID = Donarinfo.DonarID
UNION
SELECT Donarinfo.DonarName, Patientinfo.PatientName
FROM Donarinfo
RIGHT JOIN Patientinfo ON Patientinfo.PatientID = Donarinfo.DonarID;

-- Cross Join
SELECT Donarinfo.DonarName, Patientinfo.PatientName
FROM Donarinfo
CROSS JOIN Patientinfo;

-- Self Join
SELECT *
FROM Patientinfo AS a
JOIN Patientinfo AS b ON a.PatientID <> b.PatientID;

-- Union Operator
SELECT PatientID FROM Patientinfo
UNION
SELECT DonarID FROM Donarinfo
ORDER BY PatientID;

-- Case
SELECT 
    Bloodgroupid,
    Bloodgroupname,
    CASE
        WHEN Bloodgroupid IN (1, 3, 5) THEN 'Available'
        WHEN Bloodgroupid IN (2, 4) THEN 'less Available'
        WHEN Bloodgroupid = 6 THEN 'Rare'
        ELSE 'Expensive'
    END AS Availability
FROM Bloodbank;

-- Casting in MySQL is done using the CAST() function.
-- For example:
SELECT CAST('2-may 2024 10:00AM' AS DATETIME) AS Today;

-- Converting in MySQL is done using the CONVERT() function.
-- For example:
SELECT CONVERT('8-feb 2021 10:00AM', DATETIME) AS Time;

-- In MySQL, local temporary tables are created without the # prefix.
-- For example:
CREATE TEMPORARY TABLE Donor (
    Donorid INT PRIMARY KEY AUTO_INCREMENT,
    DonorName VARCHAR(30)
);

-- In MySQL, global temporary tables are created with the ## prefix, but they are not supported directly like in SQL Server.
-- You typically use session-based temporary tables in MySQL, which are similar to local temporary tables.
-- For example:
CREATE TEMPORARY TABLE Patient (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    PatientName VARCHAR(30)
);

-- Creating View
CREATE VIEW vw_myview AS
SELECT Patientinfo.PatientName, Donarinfo.DonarName
FROM Patientinfo
JOIN Donarinfo ON Patientinfo.PatientID = Donarinfo.DonarID
WHERE Patientinfo.PatientID = Donarinfo.DonarID;

SELECT * from vw_myview;

-- retrive donor info
DELIMITER //

CREATE PROCEDURE GetDonorInfo (IN donor_id INT)
BEGIN
    SELECT * FROM Donarinfo WHERE DonarID = donor_id;
END//

DELIMITER ;
CALL GetDonorInfo(1);


-- update donor status
DELIMITER //

CREATE PROCEDURE UpdateDonorStatus (
    IN donor_id INT,
    IN new_status VARCHAR(20)
)
BEGIN
    UPDATE Donarinfo SET DonarStatus = new_status WHERE DonarID = donor_id;
END//

DELIMITER ;
CALL UpdateDonorStatus(2, 'Inactive');

-- delete patient info

DELIMITER //

CREATE PROCEDURE DeletePatientInfo (IN patient_id INT)
BEGIN
    DELETE FROM Patientinfo WHERE PatientID = patient_id;
END//

DELIMITER ;
CALL DeletePatientInfo(22);

select *from Patientinfo;

-- retrive blood bank information procedure
DELIMITER //

CREATE PROCEDURE GetBloodBankInfo ()
BEGIN
    SELECT * FROM Bloodbank;
END//

DELIMITER ;
CALL GetBloodBankInfo();

DELIMITER //

-- Insert patient info 
CREATE PROCEDURE insertInPatientInfo (
    IN patientid INT,
    IN patientname VARCHAR(40),
    IN contactaddress VARCHAR(100),
    IN phoneno VARCHAR(15),
    IN bloodgroup VARCHAR(10)
)
BEGIN
    INSERT INTO Patientinfo (PatientID, PatientName, ContactAddress, PhoneNo, Bloodgroup)
    VALUES (patientid, patientname, contactaddress, phoneno, bloodgroup);
END//

DELIMITER ;
CALL insertInPatientInfo(13,'John Doe', '123 Main St', '5551234', 'A(+ve)');
