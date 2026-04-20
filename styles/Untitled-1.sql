/*

-- 1. Drop existing tables in reverse order of their dependencies to prevent foreign key errors
DROP TABLE IF EXISTS MontraProductsInvoices;
DROP TABLE IF EXISTS MontraInvoicesServices;
DROP TABLE IF EXISTS MontraProducts;
DROP TABLE IF EXISTS MontraServices;
DROP TABLE IF EXISTS MontraInvoices;
DROP TABLE IF EXISTS MontraEmployeePaymentMethods;
DROP TABLE IF EXISTS MontraCustomerPaymentMethods;
DROP TABLE IF EXISTS MontraEmployees;
DROP TABLE IF EXISTS MontraCustomers;

-- 2. Create Base Tables
CREATE TABLE MontraCustomers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    CustomerAddress VARCHAR(100),
    City VARCHAR(50),
    CustomerState VARCHAR(2),
    Notes TEXT
);

CREATE TABLE MontraEmployees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    EIN VARCHAR(20) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    EmpAddress VARCHAR(100),
    City VARCHAR(50),
    EmpState VARCHAR(2),
    Notes TEXT
);

CREATE TABLE MontraServices (
    ServiceID INT PRIMARY KEY IDENTITY(1,1),
    ServiceName VARCHAR(100) NOT NULL,
    ServiceDescription TEXT,
    Price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE MontraProducts (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    ProductDescription TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    Barcode VARCHAR(50) NOT NULL
);

-- 3. Create Tables with Foreign Keys
CREATE TABLE MontraCustomerPaymentMethods (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    PaymentType VARCHAR(50),
    CardNumber VARCHAR(20), 
    ExpirationDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES MontraCustomers(CustomerID) ON DELETE CASCADE
);

CREATE TABLE MontraEmployeePaymentMethods (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    PaymentType VARCHAR(50),
    AccountNumber VARCHAR(50),
    RoutingNumber VARCHAR(20),
    FOREIGN KEY (EmployeeID) REFERENCES MontraEmployees(EmployeeID) ON DELETE CASCADE
);

CREATE TABLE MontraInvoices (
    InvoiceID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    EmployeeID INT,
    PaymentID INT,
    InvoiceDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES MontraCustomers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES MontraEmployees(EmployeeID),
    FOREIGN KEY (PaymentID) REFERENCES MontraCustomerPaymentMethods(PaymentID)
);

-- 4. Create Junction Tables (Many-to-Many Relationships)
CREATE TABLE MontraInvoicesServices (
    InvoiceID INT,
    ServiceID INT,
    Quantity INT,
    PRIMARY KEY (InvoiceID, ServiceID),
    FOREIGN KEY (InvoiceID) REFERENCES MontraInvoices(InvoiceID) ON DELETE CASCADE,
    FOREIGN KEY (ServiceID) REFERENCES MontraServices(ServiceID) ON DELETE CASCADE
);

CREATE TABLE MontraProductsInvoices (
    InvoiceID INT,
    ProductID INT, 
    Quantity INT,
    PRIMARY KEY (InvoiceID, ProductID),
    FOREIGN KEY (InvoiceID) REFERENCES MontraInvoices(InvoiceID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES MontraProducts(ProductID) ON DELETE CASCADE
);

*/

/*
-- create 2 views called 'Display daily sales summary' and 'display all appoint for this month'

GO

DROP VIEW IF EXISTS DisplayDailySales;
GO
CREATE VIEW DisplayDailySales
AS 
SELECT 
    CAST(InvoiceDate AS DATE) AS SaleDate,
    SUM(Amount) AS DailyTotal,
    COUNT(InvoiceID) AS InvoiceCount
FROM MontraInvoices
GROUP BY CAST(InvoiceDate AS DATE);
GO




DROP VIEW IF EXISTS DisplayAppointmentsThisMonth;
GO
CREATE VIEW DisplayAppointmentsThisMonth
AS
SELECT 
    InvoiceID,
    CustomerID,
    EmployeeID,
    InvoiceDate,
    Amount
FROM MontraInvoices
WHERE MONTH(InvoiceDate) = MONTH(GETDATE())
    AND YEAR(InvoiceDate) = YEAR(GETDATE());

*/







/*
-- Create 2 stored procedures 'TherapistPayOut' and 'SwapItemPrice'

GO
CREATE PROCEDURE TherapistPayOut
    @EmployeeID INT,
    @StartDate DATE,
    @EndDate DATE,
    @Amount DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @Amount = SUM(Amount) * 0.5
    -- Assuming therapists get 50% of the sales
    FROM MontraInvoices
    WHERE EmployeeID = @EmployeeID
        AND InvoiceDate BETWEEN @StartDate AND @EndDate;
END

GO

GO
CREATE PROCEDURE SwapItemPrice
    @ProductID INT,
    @ProductName VARCHAR(100),
    @NewPrice DECIMAL(10,2)
AS
BEGIN
    UPDATE MontraProducts
    SET ProductName = @ProductName,
        Price = @NewPrice
    WHERE ProductID = @ProductID;
END
*/