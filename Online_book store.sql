CREATE TABLE Books(
Book_ID SERIAL PRIMARY KEY,
Title Varchar(100),
Author Varchar(100),
Genre Varchar(100),
Published_Year INT,
Price NUMERIC(10,2),
Stock INT
);

CREATE TABLE Customers (
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR (100),
Email VARCHAR (100),
Phone VARCHAR (100),
City  VARCHAR (100),
Country VARCHAR (100)
);

CREATE TABLE Orders (
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(customer_id),
Book_ID INT REFERENCES Books(Book_id),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(10,2)
);

SELECT*FROM Books;
SELECT*FROM Customers;
SELECT*FROM Orders;

--Retrive alll books in the 'fiction'genre
SELECT * FROM Books
WHERE Genre = 'Fiction';
--Find Books published after the year 1950
SELECT * FROM Books
WHERE Published_year >1950;
--List all customers from the canada
SELECT * FROM Customers
WHERE Country ='Canada';
--Show orders placed in november 2023
SELECT *FROM Orders
WHERE Order_date BETWEEN '2023-11-01' AND '2023-11-30';
--Retrive the total stock of books available
SELECT SUM(Stock) as book_stock FROM Books;
--Find the details of the most expensive book
SELECT * FROM Books Order by Price  desc;
--Show all customers who order more that 1 quantity of book
Select *from orders
WHERE Quantity>1;
--Retrive all orders where the total amaount exceeds $20
SELECT*FROM Orders
WHERE Total_amount > 20;
--List all genres available in the books table
SELECT Distinct genre FROM Books;
--Find all the book with the lowest stock
Select * From Books
order by stock
LIMIT 10;
--Calculate the total revenue generated from all orders
SELECT SUM (Total_amount) AS Revenue FROM Orders;
--Retrive the total number of books sold for each genre
SELECT*FROM Orders
SELECT b.genre, SUM(o.quantity) 
FROM Orders o 
JOIN Books b on o.book_id = b.book_id
Group by b.genre;
--Find avarage price of books in the "fantasy"genre
SELECT AVG( Price) as Avarage_price
FROM Books
WHERE Genre = 'Fantasy';
--List customers who have placed atlst 2 orders
SELECT O.customer_id, c. name ,count(O.order_id) AS order_count
FROM Orders o
JOIN customers c on o.customer_id= c.customer_id
GROUP BY O.Customer_id ,c. name
having count(order_id) >=2;
--Find the most frequently ordered book
SELECT book_id, COUNT(Order_id)AS order_count
From orders
GROUP BY Book_id
ORDER BY ORDER_COUNT DESC
LIMIT 1;
--Show the top 3 most expensive books of 'fantasy' genre
SELECT * from books
where genre = 'fantasy'
order by Price desc
limit 3;
--Retrive the total quantity of books sold by each author

SELECT B.author, SUM (o.Quantity) as total_sold
from orders o
JOIN books b ON o.book_id= b .book_id
Group by b.author;

--List the cities where customers who spentover $30 are located
SELECT DISTINCT C.city , TOTAL_amount
FROM ORDERS O
JOIN CUSTOMERS c ON O.CUSTOMER_ID= C.CUSTOMER_ID
WHERE O.TOTAL_AMOUNT>30
LIMIT 1;
--Find customer who spent the most on order
SELECT c. customer_id , c.name ,SUM(O.total_amount) AS total_amount
FROM orders o 
JOIN Customers c on o.customer_id=c.customer_id
GROUP BY C.CUSTOMER_ID, C.NAME
ORDER BY total_amount DESC
LIMIT 1;
--calculate the stock remaining after fulfiling all orders
select b.book_id , b.title ,b.stock ,coalesce (sum (quantity),0) AS Order_quantity,
b.stock - coalesce (sum (quantity),0) AS remaining_quantity
from books b
left join orders o on b.book_id = o.book_id
GROUP BY B.book_id ORDER BY b.book_id;


