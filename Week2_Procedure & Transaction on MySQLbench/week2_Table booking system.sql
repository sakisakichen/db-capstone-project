# Week 2 Table booking system

# Check available bookings based on user input
#Task 1 : add data into bookings
INSERT INTO bookings(BookingID,TableNo, BookingDate)
VALUES 
(1, 5,'2022-10-10'),
(2, 3,'2022-11-12'),
(3, 2,'2022-10-11'),
(4, 2,'2022-10-13');

#Task 2: create a stored procedure:CheckBooking
CREATE PROCEDURE CheckBooking(BookingDate Date, Tableno INT)
SELECT BookingDate, Tableno 
WHERE exists( SELECT * FROM Bookings where bookingdate = BookingDate AND Tableno = tableno);

Call CheckBooking('2022-11-12',3);
USE littleLemonDB
#Task 3: create a new procedure :AddValidBooking.
CREATE PROCEDURE AddValidBooking (IN BookingDate DATE, IN TableNo INT)

START TRANSACTION;
SELECT BookingDate, Tableno
WHERE exists (SELECT * from Bookings where bookingDate = BookingDate and TableNo = TableNo);

INSERT INTO bookings (date, tableno)
VALUES (BookingDate, TableNo);
    
COMMIT;


# Add & Update bookings
#Task 1 : create a new procedure :AddBooking.
DROP PROCEDURE IF EXISTS AddBooking; 
DELIMITER $$ 
CREATE PROCEDURE AddBooking(IN BookingID INT, IN CustomerID INT, IN TableNo INT, IN BookingDate DATE)
BEGIN 
INSERT INTO bookings (bookingid, customerid, tableno, bookingdate) VALUES (BookingID, CustomerID, TableNo, BookingDate); 
SELECT "New booking added" AS "Confirmation";
END$$ 
DELIMITER ; 
CALL AddBooking(9, 3, 4, "2022-12-30");

#Task 2 : create a new procedure :UpdateBooking.
DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER $$ 
CREATE PROCEDURE UpdateBooking(IN BookingID INT, IN BookingDate DATE) 
BEGIN
UPDATE bookings SET date = BookingDate WHERE bookingid = BookingID; 
SELECT CONCAT("Booking ", BookingID, " updated") AS "Confirmation"; 
END$$ 
DELIMITER ; 
CALL UpdateBooking(9, "2022-12-17");

#Task 3 : create a new procedure :CancelBooking.
DROP PROCEDURE IF EXISTS CancelBooking; 
DELIMITER $$ 
CREATE PROCEDURE CancelBooking(IN BookingID INT) 
BEGIN 
DELETE FROM bookings WHERE bookingid = BookingID; 
SELECT CONCAT("Booking ", BookingID, " cancelled") AS "Confirmation"; 
END$$ 
DELIMITER ; 
CALL CancelBooking(9);
