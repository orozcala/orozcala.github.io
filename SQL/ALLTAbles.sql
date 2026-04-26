GO

DROP TABLE IF EXISTS MontraServices
CREATE TABLE MontraServices
("ServiceID" INT IDENTITY PRIMARY KEY, 
"Name" VARCHAR(50) NOT NULL, 
"Description" VARCHAR(200) NULL, 
"Price" MONEY NOT NULL CHECK (Price >= 0));
GO
DROP TABLE IF EXISTS MontraProducts
CREATE TABLE MontraProducts
("ProductID" INT IDENTITY PRIMARY KEY,
"Name" VARCHAR(50) NOT NULL,
"Description" VARCHAR(200) NULL,
"Price" MONEY NULL CHECK (Price >= 0));
GO
DROP TABLE IF EXISTS MontraCustomers
CREATE TABLE MontraCustomers
("CustomerID" INT IDENTITY PRIMARY KEY NOT NULL,
"CustomerFirstName" VARCHAR(25) NOT NULL,
"CustomerLastName" VARCHAR(25) NOT NULL,
"CustomerPhone" CHAR(11) NULL,
"CustomerEmail" VARCHAR(320) NULL,
"CustomerCity" VARCHAR(50) NOT NULL,
"CustomerState" CHAR(2) NOT NULL,
"CustomerZIP" VARCHAR(9) NOT NULL, -- tell Ashley she forgot a coma on line 26
"Notes" VARCHAR(300) NULL);
GO
DROP TABLE IF EXISTS MontraCustomerPaymentMethods
CREATE TABLE MontraCustomerPaymentMethods
("PaymentID" INT IDENTITY PRIMARY KEY NOT NULL,
"CustomerID" INT REFERENCES [dbo].[MontraCustomers](CustomerID) NOT NULL,
"PaymentType" VARCHAR(25) NOT NULL CHECK (PaymentType = '%Card' or PaymentType = 'Cash'),
"CardNumber" VARCHAR(19) UNIQUE NULL,
"ExpirationDate" DATE NULL);
GO

DROP TABLE IF EXISTS MontraEmployees
CREATE TABLE MontraEmployees
("EmployeeID" INT IDENTITY PRIMARY KEY NOT NULL,
"EmployeeFirstName" VARCHAR(25) NOT NULL,
"EmployeeMiddleInitial" CHAR(1) NULL,
"EmployeeLastName" VARCHAR(25) NOT NULL,
"EmployeeDOB" SMALLDATETIME NOT NULL,
"EmployeeSSN" CHAR(11) NOT NULL,
"EmployeePhone" CHAR(11) NULL,
"EmployeeEmail" VARCHAR(320) NULL,
"EmployeeAddress" VARCHAR(100) NULL,
-- "EmployeeCity" VARCHAR(50) NOT NULL, --Alan This piece is conflicting with line 50.
"EmployeeCity" CHAR(2) NOT NULL,
"EmployeeZIP" VARCHAR(9) NOT NULL, 
[W2ID] INT REFERENCES [dbo].[MontraEmployeesW2](W2ID) NOT NULL,
[I9ID] INT REFERENCES [dbo].[MontraEmployeesI9](I9ID) NOT NULL);
GO
DROP TABLE IF EXISTS MontraEmployeePaymentMethods
CREATE TABLE MontraEmployeePaymentMethods
("PaymentID" INT PRIMARY KEY IDENTITY NOT NULL,
"EmployeeID" INT REFERENCES [dbo].[MontraEmployees](EmployeeID) NOT NULL,
"PaymentType" VARCHAR(25) NOT NULL CHECK (PaymentType = 'Cash' or PaymentType = '%Account'),
"AccountNumber" VARCHAR(30) UNIQUE NULL,
"RoutingNumber" CHAR(9) NULL);
GO
DROP TABLE IF EXISTS MontraEmployeesW2
CREATE TABLE MontraEmployeesW2
("W2ID" INT IDENTITY PRIMARY KEY,
 "EmployeeID" INT REFERENCES [dbo].[MontraEmployees](EmployeeID) NOT NULL,
 "EmployerFEDID" CHAR(10) DEFAULT '00-0000000' NOT NULL,
 "EmployerStateID" CHAR(14) DEFAULT '00000000000000' NOT NULL,
 "Year" INT NOT NULL,
 "Wages" DECIMAL(10, 2) NULL,
 "SocialSecurityWages" DECIMAL(10, 2) NULL,
 "MedicareWages" DECIMAL(10, 2) NULL,
 "FederalIncomeTaxWithheld" DECIMAL(10, 2) NULL,
 "StateIncomeTaxWithheld" DECIMAL(10, 2) NULL,
 "SocialSecurityTaxWithheld" DECIMAL(10, 2) NULL,
 "MedicareTaxWithheld" DECIMAL(10, 2) NULL,
);
GO
DROP TABLE IF EXISTS MontraEmployeesI9
CREATE TABLE MontraEmployeesI9
("I9ID" INT IDENTITY PRIMARY KEY,
"EmployeeID" INT REFERENCES [dbo].[MontraEmployees](EmployeeID) NOT NULL,
"EmployeeCitizenship" TINYINT NOT NULL CHECK (EmployeeCitizenship = 1 or EmployeeCitizenship = 2 or EmployeeCitizenship = 3 or EmployeeCitizenship = 4),
"No4 Information" VARCHAR(50) NULL CHECK (EmployeeCitizenship = 4),
"Document1Title" VARCHAR(50) NULL,
"Document1Authority" VARCHAR(50) NULL,
"Document1Number" INT NULL,
"Document1Expiration" SMALLDATETIME NULL,
"Document2Title" VARCHAR(50) NULL,
"Document2Authority" VARCHAR(50) NULL,
"Document2Number" INT NULL,
"Document2Expiration" SMALLDATETIME NULL,
"Document3Title" VARCHAR(50) NULL,
"Document3Authority" VARCHAR(50) NULL,
"Document3Number" INT NULL,
"Document3Expiration" SMALLDATETIME NULL,
"ListBTitle" VARCHAR(50) NULL,
"ListBAuthority" VARCHAR(50) NULL,
"ListBNumber" INT NULL,
"ListBExpiration" SMALLDATETIME NULL,
"ListCTitle" VARCHAR(50) NULL,
"ListCAuthority" VARCHAR(50) NULL,
"ListCNumber" INT NULL,
"ListCExpiration" SMALLDATETIME NULL,
"AlternateProcedure" BIT NULL);
GO