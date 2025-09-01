# 📚 Online Book Store Management System (SQL Project)

This project is an **Online Book Store Management System** built using SQL.  
It is designed to manage books, customers and orders  in a structured way.  
The goal of this project is to demonstrate database design, normalization, and SQL queries for a real-world use case.

---

## 🚀 Features
- 📖 Manage books (add, update, delete, search)
- 👤 Manage customer information
- 🛒 Track book orders and purchases
- 💳 Store and manage payment details
- 📊 Generate sales and revenue reports

---

## 🗂 Database Design

### Tables:
- **Books** → Stores book details (BookID, Title, Author, Price, Stock, etc.)
- **Customers** → Stores customer information (CustomerID, Name, Email, Phone, etc.)
- **Orders** → Records order information (OrderID, CustomerID, OrderDate, TotalAmount, etc.)

### Entity Relationship (ER) Diagram:
📌 *(Add an ER diagram image here if you have one, for example `diagrams/er-diagram.png`)*

---

## 🛠️ SQL Queries / Examples

```sql
-- Get all books by a specific author
SELECT * FROM Books WHERE Author = 'J.K. Rowling';

-- Find top 5 bestselling books
SELECT BookID, SUM(Quantity) AS TotalSold
FROM Order_Details
GROUP BY BookID
ORDER BY TotalSold DESC
LIMIT 5;

-- Get total revenue
SELECT SUM(Amount) AS TotalRevenue FROM Payments;

-- List all orders with customer details
SELECT o.OrderID, c.Name, o.OrderDate, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;
