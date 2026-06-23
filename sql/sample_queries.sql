-- 1. JOIN: List all customers and their assigned consultants
SELECT c.First_Name || ' ' || c.Last_Name AS Customer,
       e.First_Name || ' ' || e.Last_Name AS Consultant
FROM CUSTOMER c
JOIN PERSONAL_GEEK_SQUAD_CONSULTANT e ON c.Employee_ID = e.Employee_ID;

-- 2. GROUP BY & Aggregator: Count service tickets per status
SELECT Status, COUNT(*) AS Total_Tickets
FROM SERVICE_TICKET
GROUP BY Status;

-- 3. INTERSECT: Find customers who have both a Service Ticket and an Order
SELECT Customer_ID FROM SERVICE_TICKET
INTERSECT
SELECT Customer_ID FROM ORDER_TABLE;

-- 4. MINUS (EXCEPT): Customers with no orders
SELECT Customer_ID FROM CUSTOMER
EXCEPT
SELECT Customer_ID FROM ORDER_TABLE;

-- 5. UNION: Unique list of all email addresses (Customers + Suppliers)
SELECT Email_Address FROM CUSTOMER
UNION
SELECT Contact_Email FROM SUPPLIER;

-- 6. Aggregator: Find the average price of laptops
SELECT AVG(Unit_Price) FROM PRODUCT WHERE Category = 'Laptop';

-- 7. JOIN & Group By: Total spending per customer
SELECT c.First_Name, SUM(o.Total_Amount)
FROM CUSTOMER c
JOIN ORDER_TABLE o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID;

-- 8. View 1
DROP VIEW IF EXISTS ACTIVE_TICKETS_VIEW;

CREATE VIEW ACTIVE_TICKETS_VIEW AS
SELECT Ticket_ID, Problem_Description, Status, Customer_ID
FROM SERVICE_TICKET
WHERE Status != 'Resolved';

-- 9. View 2
DROP VIEW IF EXISTS PRODUCT_SALES_VIEW;

CREATE VIEW PRODUCT_SALES_VIEW AS
SELECT p.Model_Name, SUM(op.Quantity) as Times_Ordered
FROM PRODUCT p
JOIN ORDER_PRODUCT op ON p.Product_ID = op.Product_ID
GROUP BY p.Product_ID;

-- 10. Complex Join: Shipment details for resolved tickets
SELECT st.Ticket_ID, sh.Tracking_Number, s.Company_Name
FROM SERVICE_TICKET st
JOIN SHIPMENT sh ON st.Customer_ID = sh.Customer_ID
JOIN SUPPLIER s ON sh.Supplier_ID = s.Supplier_ID
WHERE st.Status = 'Resolved';
