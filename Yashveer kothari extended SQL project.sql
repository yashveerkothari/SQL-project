#	Q1
SELECT * FROM fastkart.products;
SELECT ProductID, ProductName, QuantityAvailable
FROM products
ORDER BY QuantityAvailable DESC
LIMIT 3;

#Q2
SELECT * FROM fastkart.purchasedetails;
SELECT pd.EmailId
FROM purchasedetails pd
JOIN Products p ON pd.ProductId = p.ProductId
GROUP BY pd.EmailId
HAVING COUNT(*) > 10;

#Q3
SELECT * FROM fastkart.products;
SELECT c.CategoryName, SUM(p.QuantityAvailable) as TotalQuantity
FROM categories c
JOIN products p ON c.CategoryId = p.CategoryId
GROUP BY c.CategoryName
ORDER BY TotalQuantity DESC;

# Q4
SELECT * FROM fastkart.purchasedetails;
SELECT p.ProductId, p.ProductName, c.CategoryName, SUM(pd.QuantityPurchased) as Total_Purchased_Quantity
FROM Purchasedetails pd
JOIN products p ON pd.ProductId = p.ProductId
JOIN Categories c ON p.CategoryId = c.CategoryId
GROUP BY p.ProductId, p.ProductName, c.CategoryName
HAVING SUM(pd.QuantityPurchased) = (
    SELECT MAX(QuantityPurchased_sum)
    FROM (
        SELECT SUM(QuantityPurchased) as QuantityPurchased_sum
        FROM Purchasedetails
        GROUP BY ProductId
    ) as subquery
)

#Q5
SELECT * FROM fastkart.roles;
SELECT r.RoleName, COUNT(u.Gender) as Count
FROM users u
JOIN roles r ON u.RoleID = r.RoleId
WHERE r.RoleName = 'Customer'
GROUP BY u.Gender;

#Q6
SELECT * FROM fastkart.products;
SELECT ProductId, ProductName, Price, 
    CASE
        WHEN Price < 2000 THEN 'Affordable'
        WHEN Price >= 2000 AND price <= 50000 THEN 'High End Stuff'
        ELSE 'Luxury'
    END as Item_Classes
FROM products;

#Q7
SELECT * FROM fastkart.categories;
SELECT p.ProductId, p.ProductName, c.CategoryName, p.Price AS Old_Price, 
    CASE
        WHEN c.CategoryName = 'Motors' THEN p.Price - 3000
        WHEN c.CategoryName = 'Electronics' THEN p.Price + 50
        WHEN c.CategoryName = 'Fashion' THEN p.Price + 150
        ELSE p.Price
    END AS New_Price
FROM products p
JOIN categories c ON p.CategoryId = c.CategoryId;

#Q8
SELECT * FROM fastkart.users;
SELECT CONCAT(ROUND((COUNT(CASE WHEN Gender = 'female' THEN 1 END) / COUNT(*) * 100), 2), '%') AS Percentage_Females
FROM users;

#Q9
SELECT * FROM fastkart.carddetails;
SELECT CardType, AVG(Balance) AS Average_Balance
FROM carddetails
WHERE CVVNumber > 333 AND NameOnCard LIKE '%e'
GROUP BY CardType;

#Q10
SELECT * FROM fastkart.products;
SELECT p.ProductName, c.CategoryName, (p.Price * p.QuantityAvailable) AS value
FROM products p
JOIN categories c ON p.CategoryId = c.CategoryId
WHERE c.CategoryName != 'Motors'
ORDER BY value DESC
LIMIT 1 OFFSET 1;