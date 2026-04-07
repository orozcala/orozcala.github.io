SELECT *
FROM Vendors
WHERE VendorName LIKE 'A%' OR VendorName LIKE 'B%'
ORDER BY VendorName;