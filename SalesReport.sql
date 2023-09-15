CREATE VIEW OrdersView AS SELECT OrderID, Quantity, TotalCost FROM Orders WHERE Quantity>2;
Select * from OrdersView;
ALTER TABLE Menu
add column MenuItemsID INT;
ALTER TABLE Menu
ADD CONSTRAINT FK_MenuItemsID
FOREIGN KEY (MenuItemsID) REFERENCES MenuItems(MenuItemsID);
SHOW COLUMNS FROM Menu;
SELECT c.CustomerID, c.CustomerName, o.OrderID, o.TotalCost, m.MenuName,mi.CourseName, mi.StarterName 
FROM Customers c
INNER JOIN Orders o ON c.CustomerID=o.CustomerID
INNER JOIN Menu m ON o.MenuID=m.MenuID
INNER JOIN MenuItems mi ON m.MenuItemsID=mi.MenuItemsID
WHERE o.TotalCost>150
ORDER BY TotalCost ASC;
SELECT MenuName 
FROM Menu INNER JOIN Orders on Menu.MenuID=Orders.MenuID
WHERE MenuName= ANY (SELECT MenuID FROM Orders WHERE Quantity>2);

DELIMITER //
CREATE PROCEDURE GetMaxQty()
BEGIN
SELECT MAX(Quantity) 
FROM Orders;
END//
DELIMITER ;

CALL GetMaxQty();

PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE OrderID=?';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;
CREATE TABLE Cancelations(
    Cancel varchar(255));
DROP PROCEDURE CancelOrder
    
DELIMITER //

CREATE PROCEDURE CancelOrder (order_id INT)
BEGIN
    DELETE FROM Orders WHERE OrderID = order_id;
    INSERT INTO Cancelations Values (CONCAT(order_id," Order is cancelled"));
    SELECT * FROM Cancelations;
END//

DELIMITER ;


CALL CancelOrder(5);




