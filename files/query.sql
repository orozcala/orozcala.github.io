/*1.	Find FullName (e.g. “Doe, John”) of contacts whose first names begin with the letter A, B, C, or F. Sort the result set by VendorContactFName. (21 row(s) affected)
2.	Write a SELECT statement that returns the following four columns from the Invoices table:
Invoice No         Column alias for the InvoiceNumber column
Total	    Column alias for the InvoiceTotal column
Credits	    Sum of the PaymentTotal and CreditTotal columns
Balance	    InvoiceTotal minus the sum of PaymentTotal and CreditTotal
Return only either those InvoiceNumbers that begin with the letter A-Z and have a balance of at least 1,000, or those InvoiceNumbers that do not contain the letter A-Z and have a non-zero balance.
(11 row(s) affected)

3.	Write a SELECT statement that returns VendorName, InvoiceNumber, InvoiceDate, and Balance. Sort the result set by VendorName in ascending order. (114 row(s) affected)

4.	Write a SELECT statement that returns VendorName, InvoiceNumber, InvoiceDate, InvoiceLineItemAmount, and AccountDescription. Return only invoices in March with a non-zero balance. Sort the result set by VendorName in ascending order, and then by InvoiceLineItemAmount in descending order. 
(10 row(s) affected) 

5.	Write a SELECT statement that returns two columns from the Vendors table: VendorID and VendorName, and a column from the Invoices table: InvoiceID. Include only vendors that do not have any invoices. Sort the final result set by InvoiceID.  (88 row(s) affected)

6.	Write a SELECT statement that returns two columns from the Vendors table: VendorID and VendorName, and a column from the Invoices table: InvoiceID. Include only vendors that have invoices. Sort the final result set by InvoiceID.  (114 row(s) affected)

7.	Write a SELECT statement that returns two columns from the GLAccounts table: AccountNo and AccountDescription, two columns from the Vendors table: VendorID and VendorName, and two columns from the Invoices table: InvoiceNumber and InvoiceTotal. The result set should NOT include any accounts that have never been used. Sort the result set by InvoiceTotal with the largest total first. (114 row(s) affected)

8.	Use the UNION operator to generate a result set consisting of the InvoiceNumber column from the Invoices table, the VendorName column from the Vendors table, and a string literal indicating which group a vendor belongs. Use ‘Group’ as the alias for the string literal. If the VendorName begins with the letter A-I, the string literal is ‘A-I’. If the VendorName begins with the letter J-R, the string literal should be ‘J-R’. If the VendorName begins with the letter S-Z, the string literal should be ‘S-Z’. Sort the final result set by the ‘Group’ alias and then by VendorName. (114 row(s) affected)

9.	Use the INTERSECT operator to generate a result set consisting of those AccountNo from the GLAccounts table that are also in the Vendors table. Return only those AccountNo that are greater than or equal to 500 and whose AccountDescription contains the word ‘fee’ or ‘fees’. (2 row(s) affected)

10.	Write a SELECT statement to generate the same result set as in #9. (2 row(s) affected)

*/

SELECT vendorContactLName + ', ' + VendorContactLName AS FULLNAME
FROM [dbo].[Vendors]
WHERE VendorContactFName LIKE '%[abcf]' 
ORDER BY VendorContactFName DESC