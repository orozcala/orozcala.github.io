/*

1. Write a script that declares and sets a variable that’s equal to the count of all rows in the Invoices table that have a
balance due that’s greater than $5,000.00. Then, the script should display a message that looks like this: “2
invoices exceed $5,000.”
*/ 

DECLARE @InvoiceCount INT;

SELECT @InvoiceCount = COUNT(*)
FROM Invoices
WHERE (InvoiceTotal - PaymentTotal - CreditTotal) > 5000;

PRINT CAST(@InvoiceCount AS VARCHAR) + ' invoices exceed $5,000.';
GO

/*
2. Write a script that uses variables to get (1) the count of all the invoices in the Invoices table that have a balance due
and (2) the sum of the balances due for all those invoices. If that total balance due is greater than or equal to
$10,000, the script should return a result set consisting of VendorName, InvoiceNumber, InvoiceDueDate, and
Balance for each invoice with a balance due, sorted with the oldest due date first. The script should also display a
message like this:
Number of unpaid invoices is 11.
Total balance due is $32,020.42.
Otherwise, the script should display: “Total balance due is less than $10,000.”
Stored Procedures */


DECLARE @InvoiceCount INT;
DECLARE @TotalBalance DECIMAL(18, 2);

SELECT @InvoiceCount = COUNT(*), 
       @TotalBalance = SUM(InvoiceTotal - PaymentTotal - CreditTotal)
FROM Invoices
WHERE (InvoiceTotal - PaymentTotal - CreditTotal) > 0;

IF @TotalBalance >= 10000
BEGIN
    SELECT v.VendorName, i.InvoiceNumber, i.InvoiceDueDate, 
           (i.InvoiceTotal - i.PaymentTotal - i.CreditTotal) AS Balance
    FROM Vendors v JOIN Invoices i ON v.VendorID = i.VendorID
    WHERE (i.InvoiceTotal - i.PaymentTotal - i.CreditTotal) > 0
    ORDER BY i.InvoiceDueDate ASC;

    PRINT 'Number of unpaid invoices is ' + CAST(@InvoiceCount AS VARCHAR) + '.';
    PRINT 'Total balance due is $' + CAST(@TotalBalance AS VARCHAR) + '.';
END
ELSE
BEGIN
    PRINT 'Total balance due is less than $10,000.';
END
GO

/*
3. Create a stored procedure named spVendorsWithoutInvoices that accepts @VendorName as a required parameter.
The procedure returns a result set consisting of VendorID and VendorName for each vendor that has no invoices,
sorted with VendorName. Call the procedure with vendor names that contain the word ‘service’ or ‘services’. (5
row(s) affected) */

GO
CREATE PROCEDURE spVendorsWithoutInvoices
    @VendorName NVARCHAR (255)
    AS
    BEGIN
        SELECT VendorID, VendorName
        FROM Vendors
        WHERE VendorName LIKE '%' + @VendorName + '%'
        AND VendorID NOT IN (SELECT DISTINCT VendorID FROM Invoices)
        ORDER BY VendorName;
        END;
GO


/*
4. Create a stored procedure named spVendorStateInvTotal that accepts @VendorState as an optional parameter and
@SumInvoiceTotal (i.e. the sum of all the invoices) as an output parameter. Then, call the procedure as follows and
print out the value of the output parameter:
a. Without providing @VendorState. (214290.51)
b. With @VendorState = ‘tx’. (2154.42)
c. With @VendorState = ‘t%’. (6532.44) */

DROP PROCEDURE IF EXISTS spVendorStateInvTotal;
GO

CREATE PROCEDURE spVendorStateInvTotal
    @VendorState NVARCHAR(10) = NULL, 
    @SumInvoiceTotal DECIMAL(18,2) OUTPUT
AS
BEGIN
    IF @VendorState IS NULL
    BEGIN
        SELECT @SumInvoiceTotal = SUM(InvoiceTotal)
        FROM Invoices;
    END
    ELSE
    BEGIN
        SELECT @SumInvoiceTotal = SUM(InvoiceTotal)
        FROM Invoices
        JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
        WHERE Vendors.VendorState LIKE @VendorState;
    END
END; 
GO 

