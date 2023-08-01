# Week 2 Adding sales reports

# Virtual Table to summarize data  
#Task 1 : create virtual table: OrderView
CREATE VIEW OrdersView AS
SELECT orders.OrderID, orders.Quantity, orders.BillAmount
FROM orders
WHERE orders.Quantity > 2

#Task 2 : filter data  cost more than 150
CREATE VIEW OrdersView2 AS
SELECT customerInformation.CustomerID, customerInformation.Name, orders.OrderID, orders.Billamount
FROM customerInformation INNER JOIN orders
WHERE orders.Billamount > 150
ORDER BY orders.Billamount DESC;

#Task 3 : filter data  cost more than 150
SELECT menuName from menus where MenuID=any (select MenuID from orders where Quantity>2);

# Optimized queries to manage and analyze data 
#Task 1 : create procedue: GetMaxQuantity 
CREATE PROCEDURE GetMaxQuantity() SELECT max(quantity) from orders;

#Task 2 : create prepared statement: GetOrderDetail
PREPARE GetOrderDetail FROM 'SELECT orderID, quantity, Billamount from orders WHERE orderID = ?'
SET @orderid= 1;
EXECUTE GetOrderDetail USING@orderID;

#Task 3 : create stored procedure: CancelOrder
CREATE PROCEDURE CancelOrder(IN OrderID INT)
DELETE FROM orders;
