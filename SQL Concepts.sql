-- *
-- !
-- ?
-- TODO

SELECT * from MyDatabase.dbo.customers

--*-----------
-- * WHERE
--*-----------
-- Where is used to filter the data based on certain condition or conditions
SELECT * from MyDatabase.dbo.orders
WHERE sales >= 20

SELECT * from  MyDatabase.dbo.customers
where score != 0 -- (!=) is not equal to zero

SELECT * FROM MyDatabase.dbo.customers
where country = 'Germany' -- Use single quotes for String columns

--*-----------
-- * ORDER BY
--*-----------
-- We can sort the data in ascending (lowest to highest) or in descending (highest to lowest) order
-- We need to specify the column by which we want to sort the results
-- We need to specify whether we want to order in ascending or descending order.. By default it is ASC that is in ascending order. Better to specify whether it is ASC or not
SELECT * FROM MyDatabase.dbo.customers
ORDER BY score DESC

SELECT * FROM MyDatabase.dbo.customers
ORDER BY score ASC

-- Sorting data using multiple columns (Nested Sorting)
SELECT * from MyDatabase.dbo.customers
ORDER BY country ASC, score DESC
-- First it will sort the country by ASC and then if there are multiple countries then it will again sort by the score in descending order

--*-----------
-- * GROUP BY
--*-----------
-- Combine rows with same values and then we can do aggregation

SELECT * FROM MyDatabase.dbo.customers

SELECT country,
sum(score) as total_score_per_country
FROM MyDatabase.dbo.customers
GROUP BY country
-- In this case we are combining country and then we are doing summition of the scores

-- Find the total scores and total number of customers for each country

SELECT country, SUM(score) as total_score, COUNT(id) as number_of_customers from MyDatabase.dbo.customers
GROUP BY country



--*-----------
-- * HAVING
--*-----------
-- We can use it to filter data but after agggregation
-- We can using having only after using the GROUP BY
SELECT country, SUM(score) as total_score from MyDatabase.dbo.customers
GROUP BY country
HAVING SUM(score) > 800

SELECT country, SUM(score) as total_score from MyDatabase.dbo.customers
WHERE score > 400
GROUP BY country
HAVING SUM(score) > 800


-- SQL TASK
-- Find the average score for each country considering only customers with a score not equal to O and return only those countries with an average score greater than 430
SELECT country, AVG(score) from MyDatabase.dbo.customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430

--*-----------
-- * DISTINCT
--*-----------
-- Gives all the unique elements from the column or columns selected
SELECT DISTINCT country from MyDatabase.dbo.customers
-- Don't use DISTINCT unless it's necessary; it can slow down your query

--*-----------
-- * TOP
--*-----------
-- Gives you the TOP 3 rows of the SQL result
SELECT TOP 3 * from MyDatabase.dbo.customers

-- Retrieve the TOP 3 Customers with highest scores
SELECT TOP 3 * from MyDatabase.dbo.customers
ORDER BY score DESC

-- Retrieve the Lowest 2 Customers based on the score
SELECT TOP 2 * FROM MyDatabase.dbo.customers
ORDER BY score ASC

-- Get the two most recent orders
SELECT TOP 2 * from MyDatabase.dbo.orders
ORDER BY order_date DESC


-- There are two things in SQL, one is coding order and execution order


--*--------------------------
-- * STATIC (FIXED) VALUES
--*--------------------------

SELECT 123 as static_number
SELECT 'Hello' as static_string

SELECT 
id,
first_name,
'New Customer' as customer_type -- The static values are not stored inside the database, it comes from the queries
from MyDatabase.dbo.customers

-- Data Definition Language (DDL)

--*-----------
-- * CREATE
--*-----------
CREATE TABLE MyDatabase.dbo.persons (
    id INT NOT NULL, -- Column Name, DataType, Constraint
    person_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone VARCHAR(50),
    CONSTRAINT pk_persons PRIMARY KEY (id) -- This is a new constraint "pk_persons" is the name of the constraint which is a primary key on column "id"
)

SELECT * from MyDatabase.dbo.persons

--*-----------
-- * ALTER
--*-----------
ALTER TABLE MyDatabase.dbo.persons
ADD email VARCHAR(50) NOT NULL
-- The new columns are appended at the end of table by default, If you want the column to be at a specific place you need to drop the column and create again
SELECT * from MyDatabase.dbo.persons

-- Removing a column
ALTER TABLE MyDatabase.dbo.persons
DROP COLUMN phone
SELECT * from MyDatabase.dbo.persons


--*-----------
-- * DROP
--*-----------
-- The table and all its data are permanently deleted
DROP TABLE MyDatabase.dbo.persons


-- Data Manipulation Language (DML)

--*-----------
-- * INSERT
--*-----------
-- Inserts data into the table
-- Number of columns and values should match
-- Columns and values must be in the same order
-- Manual Entry
INSERT INTO MyDatabase.dbo.customers (id, first_name, country, score)
VALUES (6, 'Ana', 'USA', NULL),
(7, 'Sam', NULL, 100)

SELECT * From MyDatabase.dbo.customers

INSERT INTO MyDatabase.dbo.customers -- No need to specify columns as long as the values that you are inserting have same sequence of columns
VALUES (8, 'Andreas', 'Germany', NULL)


INSERT INTO MyDatabase.dbo.customers (id,first_name)
VALUES (9, 'Joshua') 
-- You cannot skip the column that require value which means they have NOT NULL constraint, If you do so then SQL will try to insert NULL value in it and will throw error
-- Columns not included in INSERT become NULL (unless a default or constraint exists)



-- Insert data using another table
-- Moving data from source table to target table
INSERT INTO MyDatabase.dbo.persons (id, person_name, birth_date, phone)
SELECT id, first_name, NULL, 'Unknown' from MyDatabase.dbo.customers

SELECT * from MyDatabase.dbo.persons

--*-----------
-- * UPDATE
--*-----------
-- Updates specific rows or a set of rows based on certain condition
-- Note: Always use WHERE to avoid UPDATING all rows unintentionally

-- Question: Change the score of customer with ID 6 to 0
SELECT * FROM MyDatabase.dbo.customers

UPDATE MyDatabase.dbo.customers
SET score = 0
WHERE id = 6

-- Change the score of customer with ID 9 to 450 and update the country to 'UK'
UPDATE MyDatabase.dbo.customers
SET score = 450,
    country = 'UK'
WHERE id=9

-- Update all customers with a NULL score by setting their score to 0
UPDATE MyDatabase.dbo.customers
SET score = 0
where score is NULL

--*-----------
-- * DELETE
--*-----------
-- It removes existing rows inside your table
-- Always test before using the delete command

-- Delete all customers with an ID greater than 7
DELETE FROM MyDatabase.dbo.customers
where id > 7

-- Delete all data from table persons
TRUNCATE TABLE MyDatabase.dbo.persons -- Truncate is way faster than delete
SELECT * FROM MyDatabase.dbo.persons


--*------------------------
-- * COMPARISON OPERATORS
--*------------------------
-- Comparing two things

-- "=" operator
SELECT * FROM MyDatabase.dbo.customers
WHERE country = 'Germany'

-- "!=" NOT equal to operator, "<>"
SELECT * FROM MyDatabase.dbo.customers
WHERE country <> 'Germany'

-- Retrieve all customers with a score greater than 500
SELECT * FROM MyDatabase.dbo.customers
WHERE score > 500

-- Retrieve all customers with a score of 500 or more
SELECT * FROM MyDatabase.dbo.customers
WHERE score >= 500

-- Retrieve all customers with a score less than 500
SELECT * FROM MyDatabase.dbo.customers
WHERE score < 500

-- Retrieve all customers with a score of 500 or less
SELECT * FROM MyDatabase.dbo.customers
WHERE score <= 500

--*------------------------
-- * LOGICAL OPERATORS
--*------------------------
-- AND --> All conditions must be TRUE in order to keep the row in the result
-- Retrieve all customers who are from USA and have a score greater than 500
SELECT * FROM MyDatabase.dbo.customers
WHERE score > 500 AND country = 'USA'

-- OR --> At least one condition must be TRUE
-- Retrieve all customers who are either from the USA OR have a score greater than 500
SELECT * FROM MyDatabase.dbo.customers
WHERE score > 500 OR country = 'USA'

-- NOT --> (Reverse) Excludes matching values
-- Retrieve all customers with a score not less than 500
SELECT * FROM MyDatabase.dbo.customers
WHERE NOT score < 500

--*------------------------
-- * RANGE OPERATORS
--*------------------------
-- BETWEEN --> Checks if a value falls within a specific range
-- For range you need lower boundary and and upper boundary, everything between these two boundaries will be true and outside these boundaries will be false
-- * Boundaries are inclusive (Important)

-- Retrieve all customers whose score falls in the range between 100 and 500
SELECT * FROM MyDatabase.dbo.customers
WHERE score BETWEEN 100 AND 500

--*------------------------
-- * MEMBERSHIP OPERATORS
--*------------------------
-- IN --> Checks if a value exists in a list

SELECT * FROM MyDatabase.dbo.customers
WHERE country IN ('USA', 'Germany')

SELECT * FROM MyDatabase.dbo.customers
WHERE country NOT IN ('USA', 'Germany')


--*------------------------
-- * SEARCH OPERATORS
--*------------------------
-- LIKE --> Used to search for a specific pattern in a column
-- % --> Represents zero or more characters
-- _ --> Represents a single character

-- Retrieve all customers whose first name starts with 'M'
SELECT * FROM MyDatabase.dbo.customers
WHERE first_name LIKE 'M%'
-- First character is M and then there can be zero or more characters after M

SELECT * FROM MyDatabase.dbo.customers
WHERE first_name LIKE '%in'
-- Last two characters are "in" and there can be zero or more characters before "in"

SELECT * FROM MyDatabase.dbo.customers
WHERE first_name LIKE '%r%'
-- The character "r" can be anywhere in the first name and there can be zero or more characters before and after "r"

-- Find all customers whose first name has 'r' in the 3rd position
SELECT * FROM MyDatabase.dbo.customers
WHERE first_name LIKE '__r%'
-- The first two characters can be anything but the 3rd character must be "r" and then there can be zero or more characters after "r"


--*---------------
-- * SQL JOINS
--*---------------

-- Joins are used to 
-- 1. Recombine data from multiple tables based on a related column between them
-- 2. Data enrichment: We can enrich the data in one table with the data from another table
-- 3. Retrieve data from multiple tables in a single query

--* Types of Joins
--* NO JOIN --> Returns all rows from both tables without combining them based on any related column
-- Retrieve all data from customers and orders in two different results
SELECT * FROM MyDatabase.dbo.customers
SELECT * FROM MyDatabase.dbo.orders

--* INNER JOIN --> Returns only the matching rows from both tables based on a related column between them
-- We need to specify the type of join, before the JOIN keyword, by default it is INNER JOIN but it's better to always specify the type of join used
SELECT * FROM MyDatabase.dbo.customers c
INNER JOIN MyDatabase.dbo.orders o
ON c.id = o.customer_id
-- We are joining customers and orders based on the related column "id" from customers and "customer_id" from orders, and we are only getting the matching rows from both tables

-- Get all customers along with their orders, but only for customers who have placed an order
SELECT c.id, o.order_id, c.first_name, o.order_date FROM MyDatabase.dbo.customers AS c
INNER JOIN MyDatabase.dbo.orders AS o
ON c.id = o.customer_id 
WHERE order_date IS NOT NULL

--* LEFT JOIN --> Returns all rows from the left table and the matching rows from the right table based on a related column between them. 
-- If there is no match in the right table, NULL values are returned for the right table's columns.
SELECT * FROM MyDatabase.dbo.customers c
LEFT JOIN MyDatabase.dbo.orders o
ON c.id = o.customer_id
-- We are getting all customers and if there is a match in orders then we are getting the order details otherwise we are getting NULL values for the order details

--* RIGHT JOIN --> Returns all rows from the right table and the matching rows from the left table based on a related column between them.
-- If there is no match in the left table, NULL values are returned for the left table's columns.
SELECT * FROM MyDatabase.dbo.customers c
RIGHT JOIN MyDatabase.dbo.orders o
ON c.id = o.customer_id

SELECT * FROM MyDatabase.dbo.orders

--* FULL JOIN --> Returns all rows from both tables. If there is a match between the tables, the rows are combined. If there is no match, NULL values are returned for the columns of the table that does not have a match.
SELECT * FROM MyDatabase.dbo.customers c
FULL JOIN MyDatabase.dbo.orders o
ON c.id = o.customer_id

--* LEFT ANTI JOIN --> Returns only the rows from the left table that do not have a match in the right table based on a related column between them.
-- Get all customers who haven't placed any order
SELECT * FROM MyDatabase.dbo.customers c
LEFT JOIN MyDatabase.dbo.orders o
ON c.id = o.customer_id
WHERE o.order_id IS NULL
/* We are getting all customers and if there is a match in orders then we are getting the order details otherwise we are getting NULL values for the order details, 
and then we are filtering only those rows where order_id is NULL which means those customers who haven't placed any order */

 
--* RIGHT ANTI JOIN --> Returns only the rows from the right table that do not have a match in the left table based on a related column between them.
-- Get all orders without matching customers
SELECT * FROM MyDatabase.dbo.customers c
RIGHT JOIN MyDatabase.dbo.orders o
ON c.id = o.customer_id
WHERE c.id IS NULL
/* We are getting all orders and if there is a match in customers then we are getting the customer details otherwise we are getting NULL values for the customer details, 
and then we are filtering only those rows where customer id is NULL which means those orders which don't have any matching customer */

-- Question: Get all orders without matching customers (USING LEFT JOIN)
SELECT * FROM MyDatabase.dbo.orders o
LEFT JOIN MyDatabase.dbo.customers c
ON c.id = o.customer_id
WHERE c.id IS NULL

--* FULL ANTI JOIN --> Returns only rows that don't match in either tables
-- Get only unmatching data (Opposite effect of INNER JOIN)
-- Find customers without orders and orders without customers
SELECT * FROM MyDatabase.dbo.customers c
FULL JOIN MyDatabase.dbo.orders o
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.order_id IS NULL
/* We are getting all customers and all orders and if there is a match between them then we are getting the combined data otherwise we are getting NULL values for the columns of the table that does not have a match, 
and then we are filtering only those rows where either customer id is NULL or order id is NULL which means we are getting customers without orders and orders without customers */

SELECT * FROM MyDatabase.dbo.customers c
INNER JOIN MyDatabase.dbo.orders o
ON c.id = o.customer_id

-- Get all customers along with their orders, but only for customers who have placed an order Without using INNER JOIN!!
SELECT * FROM MyDatabase.dbo.customers c
FULL JOIN MyDatabase.dbo.orders o
ON c.id = o.customer_id
WHERE NOT (c.id IS NULL OR o.order_id IS NULL)


-- Check if the table "persons" exists in the database
SELECT CASE WHEN EXISTS (
    SELECT 1
    FROM MyDatabase.INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'persons'
) THEN 'YES' ELSE 'NO'  END AS Table_exists;


--* CROSS JOIN --> Returns the Cartesian product of the two tables, which means it combines each row from the first table with every row from the second table.
SELECT * FROM MyDatabase.dbo.customers c
CROSS JOIN MyDatabase.dbo.orders o
-- This can be used to generate test data or to create combinations of data from two tables, but it should be used with caution as it can produce a very large result set if both tables have many rows.


/* Task: using SalesDB, Retrieve a list of all orders, along with the related customer, product, and employee details. For each order, display:
Order ID, Customer's name, Product name, sales, Price, sales person's name */

SELECT * from SalesDB.INFORMATION_SCHEMA.COLUMNS

SELECT o.OrderID, 
c.FirstName AS CustomerFirstName,
c.LastName AS CustomerLastName, 
p.Product, 
o.Sales, 
p.Price, 
e.FirstName as EmployeeFirstName,
e.LastName as EmployeeLastName
FROM SalesDB.Sales.Orders o
LEFT JOIN SalesDB.Sales.Customers c
ON c.CustomerID = o.CustomerID
LEFT JOIN SalesDB.Sales.Products p
ON o.ProductID = p.ProductID
LEFT JOIN SalesDB.Sales.Employees e
ON o.SalesPersonID = e.EmployeeID

SELECT * FROM SalesDB.Sales.Employees
SELECT * FROM SalesDB.Sales.Orders
SELECT * FROM SalesDB.Sales.Products
SELECT * FROM SalesDB.Sales.Customers
SELECT * FROM SalesDB.Sales.OrdersArchive


--*----------------
-- * SET OPERATORS
--*----------------

--* UNION --> Combines the result sets of two or more SELECT statements into a single result set, eliminating duplicate rows.
/* RULES OF SET OPERATORS
#1 RULE | ORDER BY can be used only once at the end of the last SELECT statement
#2 RULE | Same Number of Columns should be present in all SELECT statements
#3 RULE | Matching Data Types should be present in all SELECT statements
#4 RULE | Same Order of Columns should be present in all SELECT statements
#5 RULE | First Query Controls Aliases
#6 RULE | Mapping Correct Columns is Important and my responsibility */

-- Combine the data from employees and customers into one table
SELECT FirstName, LastName FROM SalesDB.Sales.Employees
UNION
SELECT FirstName, LastName FROM SalesDB.Sales.Customers
-- Union will give us the unique first name and last name combinations from both employees and customers

--* UNION ALL --> Combines the result sets of two or more SELECT statements into a single result set, including duplicate rows.

-- Combine the data from employees and customers into one table, including duplicates.
SELECT FirstName, LastName FROM SalesDB.Sales.Employees
UNION ALL
SELECT FirstName, LastName FROM SalesDB.Sales.Customers
-- Union All will give us all the first name and last name combinations from both employees and customers including duplicates
-- UNION ALL is faster than UNION because it doesn't have to check for duplicates, but it can result in a larger result set if there are many duplicates
-- Use UNION ALL when you want to include duplicates and UNION when you want to eliminate duplicates.


--* EXCEPT --> Returns all distinct rows from the first SELECT statement that are not present in the second SELECT statement
-- It is the only one where the order of queries affects the final result

-- Find employees who are not customers at the same time
SELECT FirstName, LastName FROM SalesDB.Sales.Employees
EXCEPT
SELECT FirstName, LastName FROM SalesDB.Sales.Customers
-- This will give us the first name and last name combinations of employees who are not customers at the same time


--* INTERSECT --> Return all rows that are common between the result sets of two SELECT statements
-- Find employees who are also customers at the same time
SELECT FirstName, LastName FROM SalesDB.Sales.Employees
INTERSECT
SELECT FirstName, LastName FROM SalesDB.Sales.Customers
-- This will give us the first name and last name combinations of employees who are also customers at the same time

-- Orders are stored in separate tables (Orders and OrdersArchive). Combine all orders into one report without duplicates.
SELECT 
'Orders' AS SourceTable, -- This is a new column to identify the source of the data
    [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM SalesDB.Sales.Orders
UNION
SELECT 
'OrdersArchive' AS SourceTable, -- This is a new column to identify the source of the data
    [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM SalesDB.Sales.OrdersArchive
ORDER BY OrderID ASC
/* NOTE: Never use an asterisk (*) to combine tables; list needed columns instead, because if there are any changes in the structure of the tables then
it can break your query or can make the result set incorrect, and also it is a good practice to list the needed columns instead of using an asterisk (*) */


--*-------------------
-- * STRING FUNCTIONS
--*-------------------

-- Nested functions --> Using one function inside another function
--* CONCAT --> Used to concatenate two or more strings into one string
SELECT * from SalesDB.Sales.Employees
SELECT CONCAT(FirstName, ' ', LastName) AS FullName from SalesDB.Sales.Employees
-- We are concatenating first name and last name with a space in between and giving an alias "FullName" to the concatenated result
-- We can also use the "+" operator to concatenate strings in SQL Server
SELECT FirstName + ' ' + LastName AS FullName from SalesDB.Sales.Employees
-- Both CONCAT and "+" operator will give us the same result, but CONCAT is more flexible because it can handle NULL values without throwing an error, while the "+" operator will return NULL if any of the operands is NULL

--* UPPER --> Converts a string to uppercase
SELECT UPPER(FirstName) AS UpperFirstName from SalesDB.Sales.Employees

--* LOWER --> Converts a string to lowercase
SELECT LOWER(FirstName) AS LowerFirstName from SalesDB.Sales.Employees

--* LEN --> Returns the length of a string
SELECT LEN(FirstName) AS FirstNameLength from SalesDB.Sales.Employees

--* SUBSTRING --> Extracts a portion of a string based on a specified starting position and length
-- SUBSTRING(string, start_position, length)
SELECT SUBSTRING(FirstName, 2, 3) AS SubstringFirstName from SalesDB.Sales.Employees
-- This will give us the 3 characters of the first name, starting from position 2 and length of 3 characters

--! Question: Retrieve a list of customers' first names after removing the first two characters
SELECT SUBSTRING(TRIM(FirstName), 3, LEN(TRIM(FirstName)) - 2) AS FirstNameWithoutFirstChar from SalesDB.Sales.Employees

--* REPLACE --> Replaces all occurrences of a specified string with another string
SELECT REPLACE(FirstName, 'a', 'x') AS ReplacedFirstName from SalesDB.Sales.Employees
-- This will replace all occurrences of the character 'a' with 'x' in the first name

--* TRIM --> Removes leading and trailing spaces from a string
SELECT TRIM(FirstName) AS TrimmedFirstName from SalesDB.Sales.Employees
-- This will remove any leading and trailing spaces from the first name

--* LTRIM --> Removes leading spaces from a string
SELECT LTRIM(FirstName) AS LeftTrimmedFirstName from SalesDB.Sales.Employees
-- This will remove any leading spaces from the first name

--* RTRIM --> Removes trailing spaces from a string
SELECT RTRIM(FirstName) AS RightTrimmedFirstName from SalesDB.Sales.Employees
-- This will remove any trailing spaces from the first name

--* LEFT --> Returns the leftmost characters from a string based on a specified number of characters
SELECT LEFT(TRIM(FirstName), 3) AS LeftFirstName from SalesDB.Sales.Employees
-- This will give us the leftmost 3 characters of the first name

--* RIGHT --> Returns the rightmost characters from a string based on a specified number of characters
SELECT RIGHT(FirstName, 3) AS RightFirstName from SalesDB.Sales.Employees
-- This will give us the rightmost 3 characters of the first name

--* CHARINDEX --> Returns the starting position of a specified substring within a string
SELECT CHARINDEX('a', FirstName) AS PositionOfA from SalesDB.Sales.Employees
-- This will give us the starting position of the character 'a' in the first name, if 'a' is not present in the first name then it will return 0
-- Note: The availability of string functions may vary depending on the database management system (DBMS) you are using, so it's always a good idea to check the documentation for your specific DBMS to see which string functions are supported and how they work
-- Also, the syntax and behavior of string functions can differ between DBMSs, so it's important to understand how they work in your specific environment to use them effectively in your SQL queries

SELECT CHARINDEX('t', 'Customer') AS MatchPosition
-- This will return the starting position of the substring 't' in the string 'Customer', which is 4 because 't' is the 4th character in 'Customer'
-- In SQL the indexing starts from 1, so the first character is at position 1, the second character is at position 2 and so on

SELECT CHARINDEX('OM', 'Customer') AS MatchPosition;
-- It is not case sensitive and it will return the starting position of the substring 'OM' in the string 'Customer'

SELECT CHARINDEX('mer', 'Customer', 3) AS MatchPosition;
-- Search for "mer" in string "Customer", and return position (start in position 3)

--! Question: Find out if there are any leading or trailing spaces in the first name of employees
SELECT FirstName,
CASE WHEN LEN(FirstName) > LEN(TRIM(FirstName)) THEN 'Yes' ELSE 'No' END AS HasLeadingOrTrailingSpaces
FROM SalesDB.Sales.Employees

SELECT * from SalesDB.Sales.Employees

UPDATE SalesDB.Sales.Employees
SET FirstName = ' ' + FirstName + ' ' -- Adding a space at the end of the first name to demonstrate the use of TRIM function
WHERE EmployeeID IN (2,5)


--*-------------------
-- * NUMBER FUNCTIONS
--*-------------------

--* ROUND --> Rounds a number to a specified number of decimal places
SELECT 
3.1415926536 AS OriginalNumber, 
ROUND(3.1415926536, 2) AS RoundedNumber_2, 
ROUND(3.1415926536, 4) AS RoundedNumber_4
-- This will round the sales to 2 decimal places

--* ABS --> Returns the absolute value of a number
SELECT 
-10.213 AS OriginalNumber, 
ABS(-10.213) AS AbsoluteValue
-- This will return the absolute value of -10.213 which is 10.213

--*-------------------
-- * NULL FUNCTIONS
--*-------------------

-- What is NULL?
-- NULL represents the absence of a value or an unknown value in a database. It is not the same as zero or an empty string or a blank space; it indicates that the value is missing or not applicable.

-- IS NULL --> Checks if a value is NULL
SELECT * FROM MyDatabase.dbo.customers
WHERE country IS NULL

--* ISNULL --> Replaces NULL with a specified replacement value
SELECT first_name, ISNULL(country, 'Unknown') AS Country from MyDatabase.dbo.customers
-- This will replace any NULL values in the country column with 'Unknown'

/* There is difference between IS NULL and ISNULL, IS NULL is used to check if a value is NULL and it returns a boolean value (TRUE or FALSE), 
while ISNULL is used to replace NULL values with a specified replacement value and it returns the replacement value if the original value is NULL, 
otherwise it returns the original value */

--* COALESCE --> Returns the first non-NULL value from a list of expressions
SELECT first_name, COALESCE(country, 'Unknown') AS Country from MyDatabase.dbo.customers
-- This will return the first non-NULL value from the list of expressions, in this case it will return the country if it is not NULL, otherwise it will return 'Unknown'
-- COALESCE is more flexible than ISNULL because it can take multiple arguments and return the first non-NULL value among them, while ISNULL can only take two arguments (the value to check and the replacement value)
-- Use ISNULL when you want to replace NULL values with a specific value and use COALESCE when you want to return the first non-NULL value from a list of expressions

-- ISNULL is specific to SQL Server, while COALESCE is a standard SQL function that is supported by most database management systems (DBMSs). Therefore, if you are writing SQL code that needs to be portable across different DBMSs, it is generally recommended to use COALESCE instead of ISNULL.
/* ISNULL is faster than COALESCE because it is a built-in function in SQL Server and it is optimized for performance, while COALESCE is a more general function that can take multiple arguments and return the first non-NULL value among them, 
which can make it slower in some cases. However, the performance difference between ISNULL and COALESCE is usually negligible for most use cases, so it's more important to choose the function that best fits your needs in terms of functionality 
and portability rather than performance */
-- ISNULL is limited to two arguments, while COALESCE can take multiple arguments and return the first non-NULL value among them. This makes COALESCE more flexible than ISNULL, as it can handle more complex scenarios where you need to check multiple values for NULL and return the first non-NULL value.

--? Handling NULL values in data aggregation
-- Let's say we have values 10,25,NULL, and then we want to do data aggregation on these values
--! NOTE: Now if we do the AVG() of these values, then SQL will do 10+25 and then divide by 2 and it will ignore the NULL value
-- Same thing will happen if we do SUM(), MIN(), MAX() and COUNT() functions, they will ignore the NULL values
--! NOTE: Only one expection of the aggregate functions is COUNT(*) function, it will count all the rows including the NULL values, but if we do COUNT(column_name) then it will count only the non-NULL values in that column

-- If we do not want the NULL values to be ignored in the aggregation, then we can use ISNULL or COALESCE function to replace the NULL values with a specific value before doing the aggregation
SELECT id, score,
COALESCE(score,0) AS ScoreWithNullReplaced,
AVG(score) OVER()AS AverageScore1, -- Ignoring the NULL values in the score column and calculating the average score
AVG(COALESCE(score, 0)) OVER() AS AverageScore2 -- Considering the NULL values as 0 in the score column and calculating the average score
from MyDatabase.dbo.customers

--? Handling NULL values in string concatenation and arithmetic operations
-- If we do 1+5 it will give us 6, but if we do 1+NULL then it will give us NULL because any arithmetic operation with NULL will result in NULL
-- If we do "A"+"B" it will give us "AB", but if we do "A"+NULL then it will give us NULL because any string concatenation with NULL will result in NULL

--! Question: Display the full name of customers in a single field by merging their first and last names, and add 10 bonus points to each customer's score.
SELECT 
COALESCE(FirstName,'') + ' ' + COALESCE(LastName,'') AS FullName,
COALESCE(Score,0) + 10 AS NewTotalScore
from SalesDB.Sales.Customers

SELECT CONCAT(FirstName, ' ', LastName) AS FullName,
ISNULL(Score, 0) + 10 AS NewTotalScore
FROM SalesDB.Sales.Customers


--? Handling NULL values in JOIN conditions
-- When we are joining two tables based on a column that can have NULL values, we need to handle the NULL values properly in the JOIN condition, otherwise we may not get the correct results because NULL values do not match with any value including other NULL values
/*
SELECT
a. year, a.type, a.orders, b.sales
FROM Tablel a
JOIN Table2 b
ON
a.year = b.year
AND ISNULL (a.type, '') = ISNULL (b.type, '')

-- In the above query we are joining two tables based on the year column and type column, 
but since there can be NULL values in the type column, we are using ISNULL function to replace the NULL values with an empty string before comparing them, so that we can get the correct join results even when there are NULL values in the type column
*/

--? Handling NULL values in SORTING Data
-- If we have three values 25,NULL,15 then if we sort these values in ascending order then the result will be NULL,15,25 because NULL values are considered to be the lowest possible values in SQL and they will be sorted before any non-NULL values when sorting in ascending order
-- If we sort the same values in descending order then the result will be 25,15,NULL because NULL values are considered to be the lowest possible values in SQL and they will be sorted after any non-NULL values when sorting in descending order

SELECT
CustomerID, score,
CASE WHEN Score IS NULL THEN 1 ELSE 0 END AS Flag
FROM SalesDB.Sales.Customers
ORDER BY Flag ASC, Score DESC
-- In the above query we are sorting the customers based on their scores, but since there can be NULL values in the score column, we are using a CASE statement to create a flag that indicates whether the score is NULL or not, and then we are sorting first by the flag (so that NULL values come last) and then by the score itself


--* NULLIF --> Compares two expressions and returns NULL if they are equal, otherwise it returns the first expression
SELECT NULLIF(10, 10) AS Result1, -- This will return NULL because the two expressions are equal
NULLIF(10, 5) AS Result2 -- This will return 10 because the two expressions are not equal, so it returns the first expression which is 10
-- NULLIF can be useful in scenarios where you want to avoid division by zero errors or to handle specific cases in your calculations by returning NULL when certain conditions are met

-- Find the sales price for each order by dividing sales by quantity
SELECT
OrderID, sales,
Quantity,
Sales / NULLIF (Quantity, 0) AS Price
FROM SalesDB.Sales.Orders

-- NULL Vs Empty String Vs Blank Space
-- NULL represents the absence of a value or an unknown value in a database, it indicates that the value is missing or not applicable
-- An empty string ('') is a string that has zero characters, it is a valid value that can be stored in a database and it represents a known value that is intentionally left blank
-- A blank space (' ') is a string that contains one or more space characters, it is also a valid value that can be stored in a database and it represents a known value that consists of spaces

WITH CTE1 AS (
SELECT 1 AS Id, 'A' AS Category 
UNION 
SELECT 2, NULL 
UNION 
SELECT 3, ''
UNION
SELECT 4, '  '
)
SELECT Id, Category,
DATALENGTH(Category) AS CategoryLen
FROM CTE1
-- In the above query we are creating a Common Table Expression (CTE) with four rows, where the Category column has different types of values including a non-empty string ('A'), a NULL value, an empty string (''), and a blank space (' ')
-- When we calculate the length of the Category column using the DATALENGTH function, we can see that the non-empty string has a length of 1, the NULL value has a length of NULL, the empty string has a length of 0, and the blank space has a length of 2 because it contains two space characters
-- Performace is best for NULL values, then empty string and then blank space because blank space takes more storage than empty string and empty string takes more storage than NULL value
-- To compare we use IS NULL for NULL values, = '' for empty strings and = ' ' for blank spaces


--* DATA Policies for handling NULL values, empty strings and blank spaces
-- Set of rules that defines how data should be handled
-- #1 DATA POLICY Only use NULLs and empty strings, but avoid blank spaces
-- #2 DATA POLICY Only use NULLS and avoid using empty strings and blank spaces
-- #3 DATA POLICY Use the default value 'unknown' and avoid using nulls, empty strings, and blank spaces

WITH CTE2 AS (
SELECT 1 AS Id, 'A' AS Category 
UNION 
SELECT 2, NULL 
UNION 
SELECT 3, ''
UNION
SELECT 4, '  '
)
SELECT
*,
TRIM(Category) AS Policy1,
NULLIF(TRIM(Category), '') AS Policy2,
COALESCE(NULLIF(TRIM(Category), ''), 'unknown') AS Policy3
FROM CTE2
-- In the above query we are using the TRIM function to remove any leading or trailing spaces from the Category column, and then we are using NULLIF to return NULL if the trimmed category is an empty string, and then we are using COALESCE to return 'unknown' if the result of NULLIF is NULL, which means that the original category was either NULL or an empty string after trimming
-- This way we can handle all three cases (NULL values, empty strings, and blank spaces) in a consistent manner by treating them as unknown categories in our analysis or reporting
-- The choice of how to handle NULL values, empty strings, and blank spaces in your data depends on the specific requirements of your analysis or reporting, as well as the conventions and standards of your organization. It's important to have a clear data policy for handling these cases to ensure consistency and accuracy in your results.
--! Data Policy --> Use case Replacing empty strings and blanks with NULL during data preparation before inserting into a database to optimize storage and performance
--! Data Policy --> Use case Replacing empty f, blanks, NULL with default value during data preparation before using it in reporting to improve readiblity and reduce confusion


--*-----------------------
-- * CASE WHEN STATEMENT
--*-----------------------
-- It is used to perform conditional logic in SQL queries, allowing you to return different values based on specific conditions. It is similar to the IF-ELSE statement in programming languages.
-- Order of conditions is important in CASE WHEN statement because SQL evaluates the conditions in the order they are written and returns the result of the first condition that is true, so if you have multiple conditions that can be true for a given row, only the result of the first true condition will be returned.
-- If none fo the conditions are true, then the ELSE part will be executed and it will return the value specified in the ELSE clause. If there is no ELSE clause and none of the conditions are true, then it will return NULL.

-- Evalutates a list of conditions and returns a value when first condition is met (like an IF-THEN-ELSE statement)
-- The datatype of the results must be matching in all conditions and the ELSE part, otherwise it will throw an error

/* Create report showing total sales for each of the following categories: High (sales over 50), Medium (sales 21-50), and Low (sales 20 or less)
Sort the categories from highest sales to lowest */

SELECT * FROM SalesDB.Sales.Orders

SELECT
Category,
SUM(Sales) AS TotalSales
FROM (
    SELECT
    OrderID, 
    Sales,
    CASE
        WHEN Sales > 50 THEN 'High'
        WHEN Sales > 20 THEN 'Medium'
        ELSE 'Low'
    END Category
    FROM SalesDB.Sales.Orders
) AS t
GROUP BY Category
ORDER BY TotalSales DESC
-- CASE statement can be used anywhere in the query, such as in the SELECT clause, WHERE clause, ORDER BY clause, etc. It is a powerful tool for performing conditional logic and categorization in SQL queries.

-- Retrieve employee details with gender displayed as full text
SELECT 
EmployeeID, 
FirstName, 
LastName, 
CASE
    WHEN Gender = 'M' THEN 'Male'
    WHEN Gender = 'F' THEN 'Female'
    ELSE 'Not Available'
    END AS GenderFullText
FROM SalesDB.Sales.Employees

-- FULL FORM
/*CASE
    WHEN Country = 'Germany' THEN 'DE'
    WHEN Country = 'India' THEN 'IN'
    WHEN Country = 'United States' THEN 'US'
    WHEN Country = 'France' THEN 'FR'
    WHEN Country = 'Italy' THEN 'IT'
    ELSE 'n/a'
END */

-- QUICK FORM
/* CASE Country -- Only one column can be used in the CASE statement when using the quick form
    WHEN 'Germany' THEN 'DE'
    WHEN 'India' THEN'IN'
    WHEN 'United States' THEN 'US'
    WHEN 'France' THEN 'FR'
    WHEN 'Italy' THEN 'IT'
    ELSE 'n/a'
END */

-- Find the average scores of customers and treat Nulls as 0. Additionally provide details such CustomerID and LastName
SELECT
CustomerID, LastName, score,
AVG (Score) OVER () AvgCustomer,
CASE 
    WHEN Score IS NULL THEN 0
    ELSE Score
END ScoreClean,
AVG (CASE
        WHEN Score IS NULL THEN 0
        ELSE Score
    END) OVER () AvgCustomerClean
FROM SalesDB.Sales.Customers

-- Count how many times each customer has made an order with sales greater than 30
SELECT CustomerID, COUNT(*) AS order_count
FROM SalesDB.Sales.Orders
WHERE Sales > 30
GROUP BY CustomerID
ORDER BY order_count DESC

SELECT
CustomerID, 
SUM (CASE
        WHEN Sales > 30 THEN 1
        ELSE 0
    END) TotalOrdersHighSales,
COUNT (*) TotalOrders
FROM SalesDB.Sales.Orders
GROUP BY CustomerID


--*-----------------------
-- * WINDOW FUNCTIONS
--*-----------------------

-- What is data aggregation?
/* Data aggregation is the process of summarizing and combining data from multiple records or rows into a single value or summary. It is commonly used in data analysis and reporting to derive insights and trends from large datasets. 
Aggregation can involve various operations such as counting, summing, averaging, finding minimum or maximum values, and more. The purpose of data aggregation is to provide a concise and meaningful representation of the underlying data, 
making it easier to understand and analyze patterns, trends, and relationships within the dataset */

--*-----------------------
-- * AGGREGATE FUNCTIONS
--*-----------------------
 
SELECT CustomerID,
COUNT(*) AS total_nr_orders,
SUM(sales) AS total_sales,
AVG(Sales) AS average_sales,
MAX(Sales) AS max_sales,
MIN(Sales) AS min_sales
FROM SalesDB.Sales.Orders
GROUP BY CustomerID;


--*-----------------------
-- * WINDOW FUNCTIONS
--*-----------------------
--* WINDOW FUNCTIONS are also known as ANALYTICAL FUNCTIONS or OLAP (ONLINE ANALYTICAL PROCESSING) FUNCTIONS
-- Perform calculations (e.g. aggregation) on a specific subset of data, without losing the level of details of rows

-- GORUP BY does simple aggregation and it reduces the level of details of rows, while WINDOW FUNCTIONS perform calculations on a specific subset of data, without losing the level of details of rows
-- WINDOW FUNCTIONS are used with the OVER() clause, which defines the window or subset of data that the function should operate on. The OVER() clause can include PARTITION BY and ORDER BY clauses to further define the window of data for the function to operate on

-- Find the total sales across all orders
SELECT
OrderID, OrderDate, ProductID, 
SUM(Sales) OVER() AS total_sales
FROM SalesDB.Sales.Orders

-- Find the total sales for each product across all orders
SELECT
OrderID, OrderDate, ProductID, 
SUM(Sales) OVER(PARTITION BY ProductID) AS total_sales
FROM SalesDB.Sales.Orders

SELECT * FROM SalesDB.Sales.Orders

-- Syntax of window functions
/* 
First part is WINDOW FUNCTION, then we have the OVER() clause which defines the window of data for the function to operate on, and then we have the PARTITION BY clause which is used to divide the result set into partitions 
and the function is applied to each partition separately, and then we have the ORDER BY clause which is used to order the rows within each partition before applying the function, followed by frame clause
*/

/*
WINDOW FUNCTIONS are divided into three groups:
#1 AGGREGATE WINDOW FUNCTIONS --> These functions perform aggregation on a specific subset of data defined by the window, such as SUM(), AVG(), COUNT(), MAX(), MIN()
#2 RANKING WINDOW FUNCTIONS --> These functions assign a rank or a number to each row within a partition based on the specified order, such as ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE(), CUME_DIST(), PERCENT_RANK()
#3 VALUE ANALYTICAL FUNCTIONS --> These functions return a value from a specific row within the window, such as FIRST_VALUE(), LAST_VALUE(), LAG(), LEAD(), NTH_VALUE()
*/

/*
The COUNT FUNCTION excepts every datatype
SUM(), AVG(), MAX(), MIN() functions only accept numeric datatypes, if we try to use them on non-numeric datatypes then it will throw an error
ROWNUMBER(), RANK(), DENSE_RANK(), CUME_DIST(), PERCENT_RANK() should be empty, they do not accept any arguments
NTILE() function accepts one argument which is the number of groups to divide the data into, and it should be a positive integer
FIRST_VALUE(), LAST_VALUE(), LAG(), LEAD() functions accept any datatype as an argument, but the argument should be a column name or an expression that returns a value from a specific row within the window, and it should be used with the OVER() clause to define the window of data for the function to operate on
*/

--* PARTITION BY Clause divides the dataset into windows
-- SUM(Sales) OVER() --> If we do this then SQL will calculate the total sales across all orders and it will return the same total sales value for each row in the result set, because we are not using any PARTITION BY clause to divide the data into partitions, so the function is applied to the entire result set as a single partition (Whole dataset is considered as one partition or one window)
-- SUM(Sales) OVER(PARTITION BY ProductID) --> If we do this then SQL will calculate the total sales for each product across all orders and it will return the total sales for each product in the result set, because we are using PARTITION BY clause to divide the data into partitions based on the ProductID column, so the function is applied to each partition separately (Each product is considered as a separate partition or window)

--* WINDOW ORDER BY
-- Rank each order based on their sales from highest to lowest additionally provide details such order id & order date
SELECT OrderID, OrderDate, CustomerID, Sales,
RANK() OVER(ORDER BY Sales DESC) As sales_rank 
FROM SalesDB.Sales.Orders

--* FRAME CLAUSE OR WINDOW FRAME
-- It is used to define a subset of rows within the window for the function to operate on, it is used in conjunction with the ORDER BY clause in the OVER() clause of a window function
-- It allows you to specify a range of rows relative to the current row, such as a certain number of preceding or following rows, or a range of rows based on a specific condition
-- The frame clause can be defined using ROWS or RANGE keywords, followed by the specification of the frame boundaries (e.g., UNBOUNDED PRECEDING, CURRENT ROW, N PRECEDING, N FOLLOWING, etc.)
-- The frame clause is optional, and if it is not specified, the default frame is RANGE UNBOUNDED PRECEDING, which means that the function will operate on all rows from the beginning of the partition up to the current row

--* FRAME TYPES are ROWS and RANGE
-- ROWS --> It defines the frame based on a specific number of rows relative to the current row, it is used when you want to specify a fixed number of rows to include in the frame, regardless of the values in the columns
-- RANGE --> It defines the frame based on a range of values in the ORDER BY column, it is used when you want to specify a range of values to include in the frame, based on the values in the ORDER BY column

--* FRAME BOUNDARY
-- UNBOUNDED PRECEDING --> It includes all rows from the beginning of the partition up to the current row (LOWER FRAME BOUNDARY)
-- UNBOUNDED FOLLOWING --> It includes all rows from the current row to the end of the partition (HIGHER FRAME BOUNDARY)
-- CURRENT ROW --> It includes only the current row in the frame (LOWER AND HIGHER FRAME BOUNDARY)
-- N PRECEDING --> It includes a specific number of rows before the current row in the frame (LOWER FRAME BOUNDARY)
-- N FOLLOWING --> It includes a specific number of rows after the current row in the frame (HIGHER FRAME BOUNDARY)

--! FRAME CLAUSE can only be used together with ORDER BY clause in the OVER() clause of a window function, and it cannot be used without an ORDER BY clause because the frame is defined based on the order of the rows in the result set, so without an ORDER BY clause, there is no defined order for the rows and therefore no way to determine which rows should be included in the frame
/*
Lower value must be below the higher value in the frame clause, for example if we specify 3 PRECEDING as the lower frame boundary and 2 FOLLOWING as the higher frame boundary, then it will include 3 rows before the current row and 2 rows after the current row in the frame, 
but if we specify 2 FOLLOWING as the lower frame boundary and 3 PRECEDING as the higher frame boundary, then it will throw an error because the lower value (2 FOLLOWING) is not below the higher value (3 PRECEDING) in terms of their position relative to the current row
*/
select * from SalesDB.Sales.Orders


SELECT
OrderID, 
OrderDate, 
OrderStatus, 
Sales,
SUM (Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) TotalSales,

RANK() OVER(PARTITION BY OrderStatus ORDER BY OrderDate) AS SalesRank,

SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS TotalSalesWithFrame,

Sum(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS TotalSalesWithFrame2,

Sum(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS TotalSalesWithFrame3

FROM SalesDB.Sales.Orders

--? RULES for using window functions
-- #1 WINDOW FUNCTIONS can only be used in SELECT clause, ORDER BY clause and in the PARTITION BY clause of another window function, but they cannot be used in the WHERE clause, GROUP BY clause, or HAVING clause because these clauses are evaluated before the window functions are applied, so the window functions do not have access to the rows that are being filtered or grouped by these clauses
-- #2 You cannot use a window function inside another window function, but you can use a window function inside an aggregate function or a ranking function, and you can also use a window function inside a subquery or a Common Table Expression (CTE) to achieve more complex calculations and analyses
-- #3 Window function will be executed after the WHERE clause
-- #4 Window Function can be used together with GROUP BY in the same query, ONLY if the same columns are used 

SELECT
CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM SalesDB.Sales.Orders
GROUP BY CustomerID

--* WINDOW AGGREGATE FUNCTIONS
--* COUNT()

-- Find the total number of orders for each product
SELECT ProductID,
COUNT(*) AS TotalOrders, -- Will include NULL values as well because COUNT(*) counts all rows regardless of NULL values
COUNT(1) AS TotalOrders2, -- Will also include NULL values as well because COUNT(1) counts all rows regardless of NULL values and is similar to COUNT(*)
COUNT(Sales) AS TotalOrdersWithSales -- Will only count the rows where Sales is not NULL because COUNT(column_name) counts only non-NULL values in that column
FROM SalesDB.Sales.Orders
GROUP BY ProductID

-- Check whether the table OrdersArchive has duplicate OrderIDs
SELECT * 
FROM (
    SELECT
    OrderID,
    COUNT(*) OVER(PARTITION BY OrderID) AS CheckPK
    FROM SalesDB.Sales.OrdersArchive
)t WHERE CheckPK > 1

--* COUNT USE CASES
-- Overall Analysis
-- Category Analysis
-- Quality checks: Identify duplicates
-- Quality checks: Identify NULLS

--* SUM()
-- Returns sum of all values within each window

-- Find the total sales across all orders and the total sales for each product. Additionally, provide details such as order ID and order date.
SELECT 
OrderID, 
OrderDate,
ProductID,
SUM(Sales) OVER() AS TotalSalesAllOrders, --  While doing SUM(Sales) it does not include NULL values in the Sales column, so it will only sum the non-NULL values in the Sales column across all orders and return the total sales for all orders in the result set
SUM(Sales) OVER(PARTITION BY ProductID) AS TotalSalesPerProduct
FROM SalesDB.Sales.Orders

-- Find the percentage contribution of each product's sales to the total sales
SELECT
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() AS TotalSalesAllOrders,
ROUND(CAST(Sales AS FLOAT) / SUM(Sales) OVER() * 100, 2) AS PercentageContribution -- We did CAST as column Sales was integer and we want to get the percentage contribution in decimal format, so we need to cast it as FLOAT before doing the division, otherwise it will give us 0 for all products because of integer division
FROM SalesDB.Sales.Orders
ORDER BY PercentageContribution DESC
-- This is what we call PART-TO-WHOLE analysis (shows contribution of each data point to the overall total)


--* AVG()
-- Returns the average of all values within each window

-- Find the average sales across all orders and the average sales for each product. Additionally, provide details such as order ID and order date.
SELECT 
OrderID, 
OrderDate, 
ProductID, 
Sales,
AVG(Sales) OVER() AS AverageSalesAllOrders,  -- While doing AVG(Sales) it does not include NULL values in the Sales column, so it will only average the non-NULL values in the Sales column across all orders and return the average sales for all orders in the result set
AVG(Sales) OVER(PARTITION BY ProductID) AS AverageSalesPerProduct,
AVG(COALESCE(Sales, 0)) OVER() AS AverageSalesAllOrdersWithNullsAsZero, -- This will consider NULL values as 0 in the Sales column while calculating the average sales across all orders, so it will average all values in the Sales column including NULL values (which are treated as 0) across all orders and return the average sales for all orders in the result set
AVG(COALESCE(Sales, 0)) OVER(PARTITION BY ProductID) AS AverageSalesPerProductWithNullsAsZero -- This will consider NULL values as 0 in the Sales column while calculating the average sales for each product, so it will average all values in the Sales column including NULL values (which are treated as 0) for each product and return the average sales for each product in the result set
FROM SalesDB.Sales.Orders


SELECT 
FirstName, 
LastName, 
Score,
AVG(Score) OVER() AS AverageScoreAllCustomers, -- Will not include NULL values in the Score column, so it will only average the non-NULL values in the Score column across all customers and return the average score for all customers in the result set
AVG(COALESCE(Score,0)) OVER() AS AverageScoreAllCustomersWithNullsAsZero -- In this the NULL values are handled and treated as 0 in the Score column while calculating the average score across all customers, so it will average all values in the Score column including NULL values (which are treated as 0) across all customers and return the average score for all customers in the result set
FROM SalesDB.Sales.Customers

-- Find all orders where sales are above the average sales across all orders
SELECT OrderID,
Sales,
IsAboveAverage 
FROM (
    SELECT
    OrderID,
    Sales,
    AVG(Sales) OVER() AS AverageSalesAllOrder,
    CASE 
        WHEN Sales > AVG(Sales) OVER() THEN 1 
        ELSE 0 
    END AS IsAboveAverage
    FROM SalesDB.Sales.Orders
    ) t
WHERE IsAboveAverage = 1


--* MIN() and MAX()
-- Returns the minimum and maximum value within each window respectively

-- Find the highest & lowest sales across all orders and the highest & lowest sales for each product. Additionally, provide details such as order ID and order date.
SELECT 
OrderID,
OrderDate,
ProductID,
Sales,
MIN(Sales) OVER() AS LowestSalesAllOrders,
MAX(Sales) OVER() AS HighestSalesAllOrders,
MIN(Sales) OVER(PARTITION BY ProductID) AS LowestSalesPerProduct,
MAX(Sales) OVER(PARTITION BY ProductID) AS HighestSalesPerProduct,
MIN(COALESCE(Sales, 0)) OVER() AS LowestSalesAllOrdersWithNullsAsZero, -- This will consider NULL values as 0 in the Sales column while calculating the lowest sales across all orders, so it will find the minimum value in the Sales column including NULL values (which are treated as 0) across all orders and return the lowest sales for all orders in the result set
MAX(COALESCE(Sales, 0)) OVER() AS HighestSalesAllOrdersWithNullsAsZero -- This will consider NULL values as 0 in the Sales column while calculating the highest sales across all orders, so it will find the maximum value in the Sales column including NULL values (which are treated as 0) across all orders and return the highest sales for all orders in the result set
FROM SalesDB.Sales.Orders

-- Show the employees who have the highest salaries
SELECT
*
FROM (
    SELECT
    *,
    MAX (Salary) OVER() HighestSalary
    FROM SalesDB.Sales.Employees
    )t 
WHERE Salary = HighestSalary

-- Calculate the deviation of each sale from both the minimum and maximum sales amounts.
SELECT
OrderID,
Sales,
MIN(Sales) OVER() AS MinSales,
MAX(Sales) OVER() AS MaxSales,
Sales - MIN(Sales) OVER() AS DeviationFromMin,
MAX(Sales) OVER() - Sales AS DeviationFromMax
FROM SalesDB.Sales.Orders

-- RUNNING AND ROLLING TOTAL
-- RUNNING TOTAL: Aggregate all values from the beginning up to the current point without dropping off older data.
-- ROLLING TOTAL: Aggregate a fixed number of rows around the current row (Aggregate all values within a fixed time window (e.g. 30 days). As new data is added, the oldest data point will be dropped.)

-- Example of running total: Calculate the running total of sales for each order based on the order date
SELECT
OrderID,
OrderDate,
Sales,
SUM(Sales) OVER(ORDER BY OrderDate ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotalSales
FROM SalesDB.Sales.Orders


-- Calculate moving average of sales for each product over time
-- Calculate moving average of sales for each product over time, including only the next order
SELECT
OrderID,
ProductID,
OrderDate,
Sales,
AVG(Sales) OVER (PARTITION BY ProductID) AvgByProduct,
AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM SalesDB.Sales.Orders


--* RANKING WINDOW FUNCTIONS
-- These functions assign a rank or a number to each row within a partition based on the specified order, such as ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE(), CUME_DIST(), PERCENT_RANK()
-- Frame Clause cannot be used with ranking functions because ranking functions do not operate on a specific subset of rows defined by a frame, but rather they assign a rank or a number to each row within the entire partition based on the specified order, so there is no need to define a frame for these functions to operate on

--* ROW_NUMBER()
-- Assigns a unique sequential integer to rows within a partition of a result set, starting at 1 for the first row in each partition. It does not skip any numbers in the sequence, even if there are ties in the ordering.
-- ROW_NUMBER() does not handle ties in the ordering, meaning that if two or more rows have the same values in the ORDER BY clause, they will still be assigned unique sequential integers based on their position in the result set, without skipping any numbers in the sequence.

--* RANK()
-- Assigns a rank to rows within a partition of a result set, with gaps in the ranking values when there are ties in the ordering. If two or more rows have the same values in the ORDER BY clause, they will be assigned the same rank, and the next rank(s) will be skipped accordingly.
-- For example, if two rows are tied for first place, they will both be assigned a rank of 1, and the next rank assigned will be 3 (skipping rank 2). If three rows are tied for second place, they will all be assigned a rank of 2, and the next rank assigned will be 5 (skipping ranks 3 and 4).

--* DENSE_RANK()
-- Assigns a rank to rows within a partition of a result set, without gaps in the ranking values when there are ties in the ordering. If two or more rows have the same values in the ORDER BY clause, they will be assigned the same rank, and the next rank(s) will not be skipped.
-- For example, if two rows are tied for first place, they will both be assigned a rank of 1, and the next rank assigned will be 2 (without skipping any ranks). If three rows are tied for second place, they will all be assigned a rank of 2, and the next rank assigned will be 3 (without skipping any ranks).

-- Rank the orders based on their sales from highest to lowest
SELECT 
OrderID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_Row,
RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Rank,
DENSE_RANK() OVER(ORDER BY Sales DESC) AS SalesRank_DenseRank
FROM SalesDB.Sales.Orders

-- Find the top highest sales for each product
SELECT * 
FROM (
    SELECT
    ProductID,
    OrderID,
    Sales,
    ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS SalesRank
    FROM SalesDB.Sales.Orders
    ) t
WHERE SalesRank = 1
-- TOP N ANALYSIS: It is a common use case of ranking functions where we want to find the top N values for each group or category in our dataset, such as finding the top 3 highest sales for each product, or the top 5 customers with the highest total sales, etc. By using the ROW_NUMBER() function along with PARTITION BY and ORDER BY clauses, we can assign a unique rank to each row within each partition (group) based on the specified order, and then filter the results to return only the top N rows for each group based on their assigned ranks.

-- Find the lowest 2 customers based on their total sales
SELECT *
FROM (
    SELECT 
    CustomerID,
    SUM(Sales) AS TotalSales,
    ROW_NUMBER() OVER(ORDER BY SUM(Sales) ASC) AS SalesRank
    FROM SalesDB.Sales.Orders
    GROUP BY CustomerID
) t 
WHERE SalesRank <= 2
-- BOTTOM N ANALYSIS: Similar to TOP N analysis, but instead of finding the top N values, we want to find the bottom N values for each group or category in our dataset, such as finding the bottom 3 lowest sales for each product, or the bottom 5 customers with the lowest total sales, etc. By using the ROW_NUMBER() function along with ORDER BY clause in ascending order, we can assign a unique rank to each row based on their total sales from lowest to highest, and then filter the results to return only the bottom N rows based on their assigned ranks.


--* ROW_NUMBER USE CASES
--#1 Assign unique ID to the rows of OrdersArchive table
SELECT
ROW_NUMBER() OVER(ORDER BY OrderID) AS UniqueID,
*
FROM SalesDB.Sales.OrdersArchive

--? PAGINATING: It is a common use case of ranking functions where we want to divide our result set into smaller, more manageable chunks or pages, such as displaying 10 records per page on a website or application. By using the ROW_NUMBER() function along with ORDER BY clause, we can assign a unique sequential integer to each row in the result set based on the specified order, and then filter the results to return only the rows that fall within a specific range of row numbers corresponding to the desired page.

--#2 Identify duplicates

-- Identify duplicate rows in the table 'Orders Archive' and return a clean result without any duplicates
SELECT * FROM (
SELECT
ROW_NUMBER() OVER (PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
*
FROM SalesDB.Sales.OrdersArchive
)t WHERE rn=1
-- This will give the latest record for each OrderID based on the CreationTime column, and it will remove any duplicate rows with the same OrderID while keeping the most recent one. By using PARTITION BY clause to group the rows by OrderID and ORDER BY clause to sort the rows within each partition by CreationTime in descending order, we can assign a unique sequential integer to each row within each partition, and then filter the results to return only the rows where rn=1, which corresponds to the latest record for each OrderID.
-- If rn > 1 then it means that there are duplicate rows for that OrderID, that may be outdated data

--* PERCENTAGE BASED RANKING FUNCTION
--* CUME_DIST() --> It is cumulative distribution that calculates distribution of data points within a window
-- CUME_DIST is Position number of the value/Total number of rows in the partition
SELECT *,
CUME_DIST() OVER(ORDER BY Sales DESC) AS cumulative 
FROM SalesDB.Sales.Orders
-- If two points have the same value then they will both have same cumulative distribution value


--* PERCENT_RANK() --> Calculates the relative position of each row within a window
-- Percent rank always has scale 0 to 1
-- PERCENT_RANK() is position number of the value - 1 / Total number of rows - 1 
SELECT *,
PERCENT_RANK() OVER(ORDER BY Sales DESC) AS cumulative 
FROM SalesDB.Sales.Orders

-- Find the products that fall within the highest 40% of the prices
SELECT * 
FROM (
    SELECT *,
    CUME_DIST() OVER(ORDER BY Price DESC) AS cumDist
    FROM SalesDB.Sales.Products
) t
WHERE cumDist <= 0.4

--* NTILE(n) --> Divides the rows into a specified number of approximately equal groups (Buckets)
-- Bucket Size = Number of Rows / Number of Buckets
-- SQL RULE --> Larger groups comes first

SELECT 
OrderID,
Sales,
NTILE(1) OVER(ORDER BY Sales DESC) AS oneBucket,
NTILE(2) OVER(ORDER BY Sales DESC) AS twoBucket,
NTILE(3) OVER(ORDER BY Sales DESC) AS threeBucket,
NTILE(4) OVER(ORDER BY Sales DESC) AS fourBucket
FROM SalesDB.Sales.Orders

-- First we will calculate the bucket size (Number of Rows / Number of Buckets)
-- B = Floor(T / n)
-- Then we will calculate remainder to distribute the remaining rows equally in buckets
-- R = T % n
-- For example we have 10 rows and we want to have buckets, then Bucket Size = Floor(10/4) --> Floor(2.5) --> 2 (So Each bucket will have atleast 2 rows)
-- Now we will calculate the remainder that is R = 10 % 4 --> 2 (So these two rows will be distributed equally among the initail buckets)
-- So there are now 4 buckets
/*
Bucket 1 --> 2 + 1 --> 3
Bucket 2 --> 2 + 1 --> 3
Bucket 3 --> 2
Bucket 4 --> 2
*/

-- NTILE() USE CASE
-- Data segmentation --> Data Analyst (Divides a dataset into distinct subsets based on certain criteria.)

-- Segment all orders into 3 categories: high, medium and low sales.

SELECT *,
CASE WHEN Buckets = 1 THEN 'High'
WHEN Buckets = 2 THEN 'Medium'
WHEN Buckets = 3 THEN 'Low'
END SalesSegmentations
FROM (
    SELECT
    OrderID, Sales,
    NTILE(3) OVER (ORDER BY Sales DESC) Buckets
    FROM SalesDB.Sales.Orders
) t


-- Load Balancing in ETL -- Data Engineer
-- If we want to transfer a large table from one database to other database then we can split the table into buckets and then transfer it one by one
-- And in the second databaase we can use SET operators such as UNION to combine all the small tables into one big table

-- In order to export the data, divide the orders into 4 groups.
SELECT
NTILE(4) OVER (ORDER BY OrderID) Buckets,
*
FROM SalesDB.Sales.Orders


--* WINDOW VALUE FUNCTIONS
--* LEAD() --> Access a value from next row within a window
--* LAG() --> Access a value from previous row within a window

-- SYNTAX
-- LEAD --> LEAD(Sales,2,10) OVER(PARTITION BY ProductID ORDER BY OrderDate)
-- First argument is required that is an expression or a column which can be of any data type
-- Second argument is Offset, this is an optional argument, Number of Rows forward or backward from the current row, default is 1
-- Third argument is Default value, returns default value if next/previous value is not available, Default is NULL
-- PARTITION BY is Optional
-- ORDER BY is required

-- TIME SERIES ANALYSIS
-- Year-over-Year (YoY) --> Analyze the overall growth or decline of the business's performance over time
-- Month-over-Month (MoM) --> Analyze short-term trends and discover patterns in seasonality

-- Analyze the month-over-month performance by finding the percentage change in sales between the current and previous months
SELECT *,
CASE 
    WHEN prevMonth != 0 THEN ROUND((CAST((currentMonth - prevMonth) AS FLOAT) / prevMonth) * 100, 2)
    ELSE 0
END AS percentChange
FROM(
    SELECT
    MONTH(OrderDate) AS Month,
    SUM(Sales) as currentMonth,
    LAG(SUM(Sales),1,0) OVER(ORDER BY MONTH(OrderDate)) As prevMonth
    FROM SalesDB.Sales.Orders
    GROUP BY MONTH(OrderDate)
)t

-- CUSTOMER RETENTION ANALYSIS
-- Measure customer's behavior and loyalty to help businesses build strong relationships with customers

-- In order to analyze customer loyalty, rank customers based on the average days between their orders
SELECT
CustomerID,
AVG(diff) as AvgDaysBetweenOrders,
RANK() OVER(ORDER BY AVG(diff)) AS diffRank
FROM (
    SELECT *,
    DATEDIFF(DAY, OrderDate, nextOrderDate) AS diff
    FROM (
        SELECT
        OrderID,
        CustomerID,
        OrderDate,
        Sales,
        LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS nextOrderDate
        FROM SalesDB.Sales.Orders
    ) t
) t1
GROUP BY CustomerID
HAVING AVG(diff) IS NOT NULL

SELECT
CustomerID,
AVG(diff) AS AvgDaysBetweenOrders,
RANK() OVER(ORDER BY AVG(diff)) AS diffRank 
FROM (
    SELECT
    OrderID,
    CustomerID,
    OrderDate,
    Sales,
    LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS nextOrderDate,
    DATEDIFF(DAY, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) AS diff
    FROM SalesDB.Sales.Orders
) t
GROUP BY CustomerID
HAVING AVG(diff) IS NOT NULL


-- Find the average shipping duration in days for each month
SELECT
MONTH(OrderDate) AS OrderDate,
AVG (DATEDIFF (day, OrderDate, ShipDate)) AvgShip
FROM SalesDB.Sales.Orders
GROUP BY MONTH(OrderDate)


-- Find the number of days between each order and the previous order
SELECT
OrderID,
OrderDate AS currentOrderDate,
LAG(OrderDate) OVER(ORDER BY OrderDate) AS prevOrderDate,
DATEDIFF(DAY, LAG(OrderDate) OVER(ORDER BY OrderDate), OrderDate) AS diff
FROM SalesDB.Sales.Orders


--* FIRST_VALUE()
-- Access a value from the first row within a window

--* LAST_VALUE()
-- Access a value from the last row within a window

-- Find the lowest and highest sales for each product
SELECT
OrderID, ProductID, Sales,
FIRST_VALUE (Sales) OVER (PARTITION BY ProductID ORDER BY Sales) LowestSales,
LAST_VALUE (Sales) OVER (PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
Sales - FIRST_VALUE (Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS SalesDifference
FROM SalesDB.Sales.Orders

--* DATA WAREHOUSE
-- A special database that collects data from different sources and integrates to enable analytics and support decision-making

--* DATABASE ENGINE
-- It is the brain of the database, executing multiple operations such as storing, retrieving, and managing data within the database

/* Two main types of storage in the database are

--1. Disk Storage --> Long-term memory, where data is stored permanently
-- Capacity: can hold a large amount of data
-- Speed: slow to read and to write

Types of disk Storage
-- A USER DATA STORAGE
It's the main content of the database.
This is where the actual data that users care about is stored.

-- B SYSTEM CATALOG
Database's internal storage for its own information.
A blueprint that keeps track of everything about the database itself, not the user data.
MAIN PURPOSE -- It holds the Metadata information about the database.
MetaData --> Data about Data

INFORMATION SCHEMA
A system-defined schema with built-in views that provide info about the database, like tables and columns.

--C TEMPORARY STORAGE
Temporary space used by the database for short-term tasks, like processing queries or sorting data.
Once these tasks are done, the storage is cleared.


--2. Cache --> Fast short-term memory, where data is stored temporarily
-- Speed: extremely fast to read and to write
-- Capacity: can hold smaller amout of data


So now let's have an example.
Now we have a table called orders that is stored inside the user storage.
And the metadata of this table is stored in the catalog
So now let's say that you are at the client side.
And you write a simple Select query in order to select the data of the orders.
So now that query is sent to the server in order to be executed.
And the database engine can take the query in order to process it.
So first the database engine can check whether we have the data in the cache.
Because if the data is stored in the cache, then things are going to be really fast and the database
engine can solve the task quickly.
But in this scenario we don't have the orders information in the cache.
That's why the database engine can say, okay, it's not in the cache, let's check the disk.
So it will find the orders information in the disk and the query can be executed.
Then the result of this query is going to be sent back to the client side
In return you will see in the output the result of the table orders.
So this is how the SQL database execute.
Very simple select query.

*/

SELECT * FROM INFORMATION_SCHEMA.COLUMNS

--* SUBQUERY
-- It is a query inside another query
-- First the subquery is evaluated then it gives intermediate results and it is used by the main query to show the results
-- The intermediate result of the subquery is only locally known from the main query itself. And it is not globally available for any other query. So the subquery can be used only from the main query.
-- A Main query can have many sub queries (They can be called nested queries)

--* SUBQUERY RESULT TYPES
--1. SCALAR SUBQUERY --> Only returns one value
SELECT AVG(Sales) AS avgSales FROM SalesDB.Sales.Orders

--2. ROW SUBQUERY --> Returns multiple rows and a single column
SELECT CustomerID FROM SalesDB.Sales.Orders

--3. TABLE SUBQUERY --> Returns multiple rows and multiple columns
SELECT OrderID, OrderDate FROM SalesDB.Sales.Orders

--* SUBQUERY IN FROM CLAUSE
-- Find the products that have a price higher than the average price of all products

-- Main Query
SELECT
*
FROM
-- Subquery
    (
    SELECT
    ProductID, Price,
    AVG (Price) OVER () Avgprice
    FROM SalesDB.Sales.Products
)t
WHERE price > Avgprice

-- Rank Customers based on their total amount of sales

-- Approach 1
SELECT 
*,
RANK() OVER(ORDER BY totalSales DESC) AS rnk
FROM
(
    SELECT
    CustomerID,
    SUM(Sales) AS totalSales
    FROM SalesDB.Sales.Orders
    GROUP BY CustomerID
) t

-- Approach 2
SELECT
CustomerID,
SUM(Sales) AS totalSales,
RANK() OVER(ORDER BY SUM(Sales) DESC) AS rnk
FROM SalesDB.Sales.Orders
GROUP BY CustomerID

--* HOW DB executes query
/*
When you execute a query that contains a subquery, the database engine first parses and understands the entire query, identifying the subquery and the main query.
The database engine executes the subquery first. It retrieves the required data from disk (tables like orders) and produces an intermediate result. This result is stored temporarily in memory (or cache), making it fast to access.
Next, the main query is executed. Instead of re-reading data from disk, it uses the intermediate result generated by the subquery. This reduces I/O operations and improves performance, especially when the subquery result is reused.
Once the main query finishes processing, the database engine sends the final result back to the client.
Finally, the temporary data created for the subquery is cleaned up from memory/cache to free resources for other queries.
*/

--* SUBQUERY USING SELECT
-- Used to aggregate data side by side with the main query's data, allowing for direct comparison.
--! RULE: Result of the subquery must be scalar

-- Show the product IDs, names, prices and total number of orders
-- Main Query
SELECT
ProductID, Product, Price,
-- Subquery
(SELECT COUNT(*) FROM SalesDB.Sales.Orders) AS TotalOrders -- Should return only one value
FROM SalesDB.Sales.Products

--* SUBQUERY USING JOIN
-- Used to prepare the data (filtering or aggregation) before joining it with other tables.

-- Show all customer details and find the total orders for each customer
SELECT
c.*,
o.TotalOrders
FROM SalesDB.Sales.Customers c
LEFT JOIN (
    SELECT
    CustomerID,
    COUNT (*) TotalOrders
    FROM SalesDB.Sales.Orders
    GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID


--* SUBQUERY USING WHERE
-- Used for complex filtering logic and makes query more flexible and dynamic
--! RULE: SUBQUERY must be SCALAR QUERY

-- Find the products that have a price higher than the average price of all products
SELECT
ProductID, Price,
(SELECT AVG(Price) FROM SalesDB.Sales.Products) AS AvgPrice
FROM SalesDB.Sales.Products
WHERE Price > (SELECT AVG(Price) FROM SalesDB.Sales.Products)


--* SUBQUERY USING IN OPERATOR
--! SUBQUERY IS allowed to have multiple rows

-- Show the details of orders made by customers in Germany

SELECT
*
FROM SalesDB.Sales.Orders
WHERE CustomerID IN
                (SELECT
                CustomerID
                FROM SalesDB.Sales.Customers
                WHERE Country = 'Germany')


--* SUBQUERY USING ALL & ANY OPERATOR
-- ANY OPERATOR
-- Checks if a value matches ANY value within a list.
-- Used to check if a value is true for AT LEAST one of the values in a list.

-- Find female employees whose salaries are greater than the salaries of any male employees
-- Main Query
SELECT
EmployeeID, FirstName,Salary
FROM SalesDB.Sales.Employees
WHERE Gender = 'F' AND Salary > ANY (SELECT Salary FROM SalesDB.Sales.Employees WHERE Gender = 'M')

-- Find female employees whose salaries are greater than the salaries of all male employees
SELECT
EmployeeID, FirstName,Salary
FROM SalesDB.Sales.Employees
WHERE Gender = 'F' AND Salary > ALL (SELECT Salary FROM SalesDB.Sales.Employees WHERE Gender = 'M')


--* CORELATED AND NON-CORELATED SUBQUERY

/*
| Aspect                   | Non-Correlated Subquery                          | Correlated Subquery                              |
|--------------------------|--------------------------------------------------|--------------------------------------------------|
| Definition               | Independent of the main query                    | Dependent on the main query                      |
| Execution                | Executed once                                    | Executed for each row of the main query          |
| Standalone Execution     | Can be executed independently                    | Cannot be executed independently                 |
| Readability              | Easier to read                                   | More complex and harder to read                  |
| Performance              | Better (runs once)                               | Slower (runs multiple times)                     |
| Usage                    | Static comparisons, constant filtering           | Row-by-row comparisons, dynamic filtering        |
*/

-- Show all customer details and find the total orders for each customer
-- Main Query
SELECT
*,
(SELECT COUNT(*) FROM SalesDB.Sales.Orders o WHERE o.CustomerID = c.CustomerID) TotalSales
FROM SalesDB.Sales.Customers c

--* EXISTS

-- Find customer who has placed atleast one order
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Country
FROM SalesDB.Sales.Customers c
WHERE EXISTS (
    SELECT 1
    FROM SalesDB.Sales.Orders o
    WHERE o.CustomerID = c.CustomerID
)
-- EXPLANATION: First Main Query will run that is the customers table --> Each record from the customers table will be passed to the EXISTS subquery, 
-- the subquery will check that if the customerID from the customers table is there in the customerID of the Orders table, if it finds atleast one match then
-- EXISTS will return TRUE and the original record from the customers will be kept in the result set. Now the main query will pass the second record from the customers table, agian it will check
-- the customerID from the customers table to the customerID from the Orders table, if it finds atleast one match then EXISTS will return TRUE and that record will be kept inside the result set
-- And it will continue with the third record and so on, If a particular customerID of the customers table is not found in the customerID of the Orders table then EXISTS will return FALSE and then that record will not be included in the result set


-- EXISTS checks if at least one matching row exists in orders

-- For each customer:
-- Step 1: Take c.CustomerID
-- Step 2: Check in orders table:
--         SELECT 1 FROM orders WHERE o.CustomerID = c.CustomerID
-- Step 3:
--    - If match found --> include customer
--    - If no match --> exclude customer
--? EXISTS stops as soon as it finds the first match (efficient)

-- Find customers who have at least one Delivered order
SELECT 
    c.CustomerID,
    c.FirstName,
    c.Country
FROM SalesDB.Sales.customers c
WHERE EXISTS (
    SELECT 1
    FROM SalesDB.Sales.Orders o
    WHERE o.CustomerID = c.CustomerID AND o.OrderStatus = 'Delivered'
)

-- Customers with NO orders
SELECT 
    c.CustomerID,
    c.FirstName
FROM SalesDB.Sales.Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM SalesDB.Sales.Orders o
    WHERE o.CustomerID = c.CustomerID
)



--* CTE (COMMON TABLE EXPRESSION)
-- Temporary, named result set (virtual table), that can be used multiple times within your query to simplify and organize complex query.
-- CTEs are locally availabe in the main query and not available globally
-- Subqueries are used only once however CTEs can be referenced or utilised number of times. It's like a hidden virtual table that lives inside our main query.

--* There are two types of CTEs
-- Non-Recursive CTE --> Two subtypes Standalone CTE and Nested CTE
-- Recursive CTE 

--* Standalone CTE
-- Defined and Used Indepeently.
-- Runs independently as it's self-contained and doesn't rely on other CTEs or queries.
--! You cannot use ORDER BY directly within the CTE

-- Find total sales per customer

WITH TotalSalesPerCustomer AS -- CTE
(
    SELECT
        CustomerID,
        SUM(Sales) AS totalSales
    FROM SalesDB.Sales.Orders
    GROUP BY CustomerID
)
-- Main Query
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    t.totalSales
FROM SalesDB.Sales.Customers c
LEFT JOIN TotalSalesPerCustomer t
ON c.CustomerID = t.CustomerID


-- Multiple Standalone CTEs

WITH totalSalesPerCustomer AS -- CTE1 (Find total sales per customer)
(
    SELECT
        CustomerID,
        SUM(Sales) AS totalSales
    FROM SalesDB.Sales.Orders
    GROUP BY CustomerID
),
lastOrderDateOfCustomer AS -- CTE2 (Find last order date for each customer)
(
    SELECT * FROM
    (
        SELECT
        CustomerID,
        OrderDate as lastOrderDate,
        RANK() OVER(PARTITION BY CustomerID ORDER BY OrderDate DESC) AS rnk
        FROM SalesDB.Sales.Orders
    ) t
    WHERE rnk = 1
)
-- Main Query
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    t.totalSales,
    t1.lastOrderDate
FROM SalesDB.Sales.Customers c
LEFT JOIN totalSalesPerCustomer t
ON c.CustomerID = t.CustomerID
LEFT JOIN lastOrderDateOfCustomer t1
ON t1.CustomerID = c.CustomerID


--* NESTED CTE
-- CTE inside another CTE
-- A nested CTE uses the result of another CTE, so it can't run independently.

--? CTE BEST PRACTICES
-- Rethink and refactor your CTEs before starting a new one
-- Don't use more than 5 CTEs in one query; otherwise, your code will be hard to understand and maintain

/*
Nested CTEs depend on other CTEs defined earlier in the query, which means they cannot be executed independently. This dependency makes them harder to test and debug compared to standalone CTEs.
Additionally, CTEs are temporary. Once the query finishes execution, their results are removed from memory. As a result, SQL does not retain any information about the CTE after execution.
Because of this, if you want to inspect the result of a specific (nested) CTE, you cannot run it alone. Instead, you typically comment out the main query and execute the full statement including all required CTE definitions.
This highlights the key difference: standalone CTEs can be executed and tested more easily, while nested CTEs are dependent on other CTEs and require the full query context to run.
*/


WITH totalSalesPerCustomer AS -- CTE1 --> Find total sales per customer (STANDALONE CTE)
(
    SELECT
        CustomerID,
        SUM(Sales) AS totalSales
    FROM SalesDB.Sales.Orders
    GROUP BY CustomerID
),
lastOrderDateOfCustomer AS -- CTE2 --> Find last order date for each customer (STANDALONE CTE)
(
    SELECT * FROM
    (
        SELECT
        CustomerID,
        OrderDate as lastOrderDate,
        RANK() OVER(PARTITION BY CustomerID ORDER BY OrderDate DESC) AS rnk
        FROM SalesDB.Sales.Orders
    ) t
    WHERE rnk = 1
),
rankCustomers AS -- CTE3 --> Rank Customers based on Total Sales Per Customer (Nested CTE)
(
    SELECT
    CustomerID,
    totalSales,
    RANK() OVER(ORDER BY totalSales DESC) AS rnkCustomers
    FROM totalSalesPerCustomer
),
customerSegments AS -- CTE4 --> Segment customers based on their total sales (NESTED CTE)
(
    SELECT
    CustomerID,
    totalSales,
    CASE WHEN totalSales > 100 THEN 'High'
         WHEN totalSales > 80 THEN 'Medium'
         ELSE 'Low'
    END AS segemnts
    FROM totalSalesPerCustomer
)
-- Main Query
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    t.totalSales,
    t1.lastOrderDate,
    rc.rnkCustomers,
    cs.segemnts
FROM SalesDB.Sales.Customers c
LEFT JOIN totalSalesPerCustomer t
ON c.CustomerID = t.CustomerID
LEFT JOIN lastOrderDateOfCustomer t1
ON t1.CustomerID = c.CustomerID
LEFT JOIN rankCustomers rc
ON rc.CustomerID = c.CustomerID
LEFT JOIN customerSegments cs
ON cs.CustomerID = c.CustomerID


--* RECURSIVE QUERY
-- Self-referencing query that repeatedly processes data until a specific condition is met

-- Generate sequence from 1 to 20

WITH sequenceGenerator AS
(
    SELECT 1 AS MyNumber -- First is the Anchor Query (It is only executed once)
    UNION ALL
    SELECT MyNumber + 1 -- Second is Recursive Query (We will get the current value of the number that is 1 and then it will add 1 to it to become 2, Now it will check if the current value that is 2 at the moment is less than the breaking condition then it will continue to next iteration, if the current value is greater than the breaking condition then it wil break out of the loop)
    FROM sequenceGenerator
    WHERE MyNumber < 1000 -- Breaking Condition
)
SELECT * FROM sequenceGenerator
OPTION (MAXRECURSION 1000) -- Increase Max Recursion

-- By default, maximum recursion is set to 100, however we can modify number of recursions using the above syntax and can increase max iterations


-- Task: Show the employee hierarchy by displaying each employee's level within the organization

WITH CTE_Emp_Hierarchy AS (
-- Anchor Query
    SELECT
    EmployeeID, FirstName, ManagerID,
    1 AS Level
    FROM SalesDB.Sales.Employees
    WHERE ManagerID IS NULL
    UNION ALL
    --Recursive Query
    SELECT
    e. EmployeeID, e. FirstName, e. ManagerID,
    Level + 1
    FROM SalesDB.Sales.Employees AS e
    INNER JOIN CTE_Emp_Hierarchy ceh
    ON ceh.EmployeeID = e.ManagerID
)
-- Main Query
SELECT *
FROM CTE_Emp_Hierarchy


-- Fibonacci
WITH CTE_Fib AS (
    SELECT 1 AS Position, 0 AS CurrentVal, 1 AS NextVal
    UNION ALL
    SELECT Position + 1, NextVal, CurrentVal + NextVal
    FROM CTE_Fib
    WHERE Position < 10
)
SELECT Position, CurrentVal AS FibonacciValue FROM CTE_Fib;


--* VIEW
-- Virtual table based on the result set of a query, without storing the data in database.
-- Views are persisted SQL queries in the database.

--* 3 Level Architecture
/*
Three-Level Database Architecture
Physical Level (Internal Layer)
    Lowest level, highest complexity
    Deals with how data is stored (files, partitions, indexes, logs)
    Managed by DBAs for performance, security, backup, and recovery
Logical Level (Conceptual Layer)
    Middle level, moderate complexity
    Focuses on how data is structured (tables, relationships, indexes, procedures)
    Used by developers/data engineers
    Abstracts away physical storage details
View Level (External Layer)
    Highest level, simplest
    Shows only relevant data to users/applications via views
    Used by end users, analysts, BI tools (e.g., Power BI)
    Hides all complexity of underlying data

Key Idea
    Physical → Logical → View = Increasing abstraction, decreasing complexity
    Each layer hides complexity from the layer above it
*/


--* Table Vs View
/*
Tables vs Views (Quick Comparison)

1. Data Storage
    Tables: Store actual data physically
    Views: Virtual tables (no data stored, just query results)

2. Maintainability
    Tables: Harder to modify (schema changes need effort, migrations)
    Views: Easy to change (just update the query)

3. Performance
    Tables: Faster (direct data access)
    Views: Slower (executes underlying query each time)

4. Operations
    Tables: Support read + write (INSERT, UPDATE, DELETE)
    Views: Mostly read-only

Key Idea
    Tables = Storage
    Views = Representation (dynamic query layer)
*/

--* CTE Vs View
/*
Views vs CTEs (Common Table Expressions)

1. Purpose & Scope
    CTEs: Used within a single query --> temporary logic
    Views: Used across multiple queries --> reusable logic

2. Persistence
    CTEs: Not stored (exist only during query execution)
    Views: Stored in the database (persisted logic)

3. Reusability
    CTEs: Improve readability within one query
    Views: Improve reusability across the entire project

4. Maintenance
    CTEs: No maintenance (auto-cleaned after query)
    Views: Require management (create, update, drop)

Key Idea
    CTE = Temporary logic (one-time use)
    View = Permanent logic (reusable across queries)
*/

--* Creating a VIEW
CREATE VIEW Sales.V_Monthly_Summary AS
(
    SELECT
    DATETRUNC(month, OrderDate) OrderMonth,
    SUM(Sales) TotalSales,
    COUNT(OrderID) TotalOrders,
    SUM(Quantity) TotalQuantities
    FROM SalesDB.Sales.Orders
    GROUP BY DATETRUNC(month, OrderDate)
)

--* Selecting from the VIEW
SELECT * FROM Sales.V_Monthly_Summary

-- Dropping the VIEW
DROP VIEW Sales.V_Monthly_Summary


--* Updating the VIEW
IF OBJECT_ID('Sales.V_Monthly_Summary', 'V') IS NOT NULL -- IF the OBJECT_ID exists then DROP VIEW if not then nothing will happen
    DROP VIEW Sales.V_Monthly_Summary; -- T-SQL (Transact-SQL is an extension of SQL that adds programming features)
GO

CREATE VIEW Sales.V_Monthly_Summary AS -- Creating the NEW VIEW with modified script
(
    SELECT
    DATETRUNC(month, OrderDate) OrderMonth,
    SUM(Sales) TotalSales,
    COUNT(OrderID) TotalOrders
    FROM SalesDB.Sales.Orders
    GROUP BY DATETRUNC(month, OrderDate)
)


--* VIEWS USE CASE (High Complexity)
CREATE VIEW Sales.V_OrderDetails AS
(
    SELECT
    o.OrderID,
    o.OrderDate,
    p.Product,
    p.Category,
    COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') CustomerName,
    c.Country CustomerCountry,
    COALESCE(e.FirstName, '') + '' + COALESCE(e.LastName, '') SalesName,
    e.Department,
    o.Sales, o.Quantity 
    FROM Sales.Orders o LEFT JOIN Sales.Products p
    ON p.ProductID = o.ProductID
    LEFT JOIN Sales.Customers c
    ON c.CustomerID = o.CustomerID
    LEFT JOIN Sales.Employees e
    ON e.EmployeeID = o.SalesPersonID
)

SELECT * FROM Sales.V_OrderDetails


--* VIEWS USE CASE (Data Security)
-- Use views to enforce security and protect sensitive data, by hiding columns and/or rows from tables.

/*
Views for Data Security
    Views help protect sensitive data by controlling what users can see
    Instead of giving direct access to tables, users get access to custom views

Role-Based Access Using Views
    Managers: Full access (all rows & columns via a view)
    Data Analysts: Limited columns → Column-level security
    Students: Limited columns + limited rows → Column + Row-level security

Key Idea
    Tables = Full data (restricted access)
    Views = Filtered access based on user roles
*/

-- Provide a view for EU Sales Team that combines details from All tables And excludes Data related to the USA
CREATE VIEW Sales.V_OrderDetails_EU AS
(
    SELECT
    o.OrderID,
    o.OrderDate,
    p.Product,
    p.Category,
    COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') CustomerName,
    c.Country CustomerCountry,
    COALESCE(e.FirstName, '') + '' + COALESCE(e.LastName, '') SalesName,
    e.Department,
    o.Sales, o.Quantity 
    FROM Sales.Orders o LEFT JOIN Sales.Products p
    ON p.ProductID = o.ProductID
    LEFT JOIN Sales.Customers c
    ON c.CustomerID = o.CustomerID
    LEFT JOIN Sales.Employees e
    ON e.EmployeeID = o.SalesPersonID
    WHERE c.Country != 'USA'
)

SELECT * FROM Sales.V_OrderDetails_EU


--* VIEWS USE CASE (Flexibility)
/*
Views for Flexibility & Change Management

When users directly query tables, any change in the data model—like:
    Renaming tables or columns
    Splitting one table into multiple tables
    Adding or removing columns
can break existing queries, leading to errors, escalations, and dependency issues across teams.

Solution: Use Views as an Abstraction Layer
    Instead of giving access to tables, users query views
    Views act as a stable interface between users and the underlying data
    You can freely modify the physical tables without impacting users

For example:
    If a table is split --> update the view using JOIN/UNION
    If a column is renamed --> map it back in the view
    If schema changes --> adjust the view logic accordingly

Key Idea
    Tables can change, but views remain consistent for users
    Views hide backend complexity and protect user queries

Benefits
    High flexibility to evolve your data model
    No breaking changes for downstream users
    Reduced coordination overhead with multiple teams
    Better maintainability and scalability of data systems
*/


--* VIEWS USE CASE (Multi-Language)
/*
Views for Multi-Language Support
    In real-world projects, databases are often accessed by global teams (e.g., US, Germany, India). If your data model (tables and columns) is only in one language (typically English), it may not be intuitive for all users.
    Views provide a simple way to present the same data in multiple languages without changing or duplicating the underlying tables.

How It Works
    The base tables remain unchanged (e.g., orders in English)
    You create separate views for each language:
        Rename the view name (e.g., orders --> German equivalent)
        Translate column names inside the view
    Each user group accesses the view in their preferred language

For example:
    English users --> orders
    German users --> translated view (same data, German column names)
    Indian users --> another translated view

Key Idea
    Views = Language-specific representation of the same data
    One source of truth (tables), multiple user-friendly interfaces (views)

Benefits
    Improves accessibility and usability for international teams
    No need to duplicate or sync multiple tables
    Easy to maintain (update logic in one place)
    Keeps data consistent while offering localized experiences
*/


--* VIEWS USE CASE (Data Warehouse)
/*

Views as Virtual Data Marts in a Data Warehouse

In a traditional data warehouse architecture (Inmon approach):
    Data is collected from multiple source systems
    It is cleaned, transformed, integrated, and stored in a central Data Warehouse (as tables)
    This warehouse becomes the single source of truth

However, directly connecting BI tools (like Power BI) to the full warehouse can be:
    Complex
    Hard to navigate
    Not optimized for specific business use cases

What Are Data Marts?
    Data marts are subject-specific subsets of the data warehouse
    Each mart is designed for a specific domain or team, such as:
        Sales
        Finance
        Marketing
    They simplify access and make reporting more efficient.

Key Design Choice
Q) How should we build data marts?
    Using physical tables (copying data) ❌
    Using views (virtual layer) ✅

Best Practice: Virtual Data Marts Using Views
Instead of duplicating data into new tables:
    Create views on top of the data warehouse tables
    These views apply business logic, filtering, joins, and aggregations
    Each view represents a data mart tailored to a specific use case

Key Idea
    Data Warehouse (tables): stores integrated, historical data
    Data Marts (views): provide business-friendly, use-case-specific access

Why Views Are Better Than Tables for Data Marts
1. No Data Duplication
    Avoids copying data --> reduces storage and inconsistency risks
2. Always Up-to-Date
    Views reflect real-time data from the warehouse
3. Flexibility & Speed
    Business logic can be changed instantly by modifying the view
4. Low Maintenance
    No need for additional ETL pipelines to move data into marts
5. Consistency
    Ensures a single source of truth
    Prevents mismatches between warehouse and marts
6. Simpler Architecture
    Reduces complexity and avoids data chaos

Example flow:
ERP / CRM / APIs / Files / External Systems
                ↓
        Data Warehouse
   (centralized physical tables,
    cleaned, integrated, historized)
                ↓
       Virtual Data Marts
   (Sales View, Finance View,
    Operations View, Marketing View)
                ↓
         Reporting Layer
   (Power BI, dashboards, reports,
    analytics, end users)

In short, the best practice is:
- Use tables in the Data Warehouse to physically persist the integrated data
- Use views in the Data Mart layer to create reusable, flexible, and domain-specific reporting structures
- Let reporting tools consume the data marts instead of directly querying the raw warehouse
*/

--* TWO TYPES OF TABLES
-- A) Permanent Tables
-- 1. Traditional Table (CREATE and INSERT)
-- 2. CTAS (Create Table As Select)

-- B) Temporary Table

--* CTAS VS VIEWS
-- ============================================================
-- Views vs CTAS (Create Table As Select) — Summary
-- ============================================================

-- 1. Data Storage
-- View:
--   - Stores only the query (definition/DDL)
--   - Does NOT store data
--   - Query is NOT executed at creation

-- CTAS Table:
--   - Stores the result of the query as actual data
--   - Query is executed at creation time
--   - Data is physically stored in the table

-- 2. Query Execution
-- View:
--   - Query runs EVERY time you SELECT from the view
--   - Always fetches data from base/original tables

-- CTAS Table:
--   - Query runs ONLY once during table creation
--   - Future SELECTs read directly from stored data

-- 3. Performance
-- View:
--   - Slower (query executes every time)
--   - Extra computation overhead

-- CTAS Table:
--   - Faster (data already precomputed)
--   - No need to re-run original query

-- 4. Data Freshness (Most Important Difference)
-- View:
--   - Always shows latest/updated data
--   - Reflects changes in underlying tables

-- CTAS Table:
--   - Shows snapshot of data at creation time
--   - Does NOT automatically reflect updates
--   - Needs manual refresh (re-run CTAS)

-- 5. Maintenance
-- View:
--   - Easy to maintain
--   - No refresh required

-- CTAS Table:
--   - Requires manual refresh/rebuild
--   - More maintenance effort

-- 6. One-line Interview Answer
-- Views are virtual and always return fresh data but are slower,
-- whereas CTAS tables store precomputed results, making them faster
-- but potentially outdated.


--* SYNTAX

IF OBJECT_ID('Sales.MonthlyOrders', 'U') IS NOT NULL
    DROP TABLE Sales.MonthlyOrders;
GO

SELECT
DATENAME(month, OrderDate) OrderMonth,
COUNT(OrderID) Totalorders
INTO Sales.Monthlyorders
FROM Sales.Orders
GROUP BY DATENAME (month, OrderDate)

SELECT * FROM Sales.Monthlyorders

--* USE CASE --> SNAPSHOTS
--* USE CASE --> Physical Data Marts in Datawarehouse
-- Persisting the Data Marts of a Data warehouse improves the speed of data retrieval compared to using views


--* Temporary Tables
SELECT * 
INTO #Orders
FROM Sales.Orders
WHERE OrderStatus = 'Delivered'
-- If we Put # before the table name, it means that it is a temporary table
-- This is a temporary table and will only live until the session is active. Once we restart the session the temporary tables will be deleted

DROP TABLE IF EXISTS #Orders

SELECT * FROM #Orders

--* USE CASE Temp Tables
-- We use it in order to store intermediate results temporary until we are done with the session
-- And then once we are done, the database can go and drop that temporary table

--* STORED PROCEDURE
-- First we have to define stored procedure and then we can execute it

GO
CREATE OR ALTER PROCEDURE GetCustomerSummary --* Declaration of Stored Procedure

--* Parameter Declaration
@Country NVARCHAR(50) = 'USA' -- Symbol @ is used to create a parameter, and the default value is set to 'USA'
AS
BEGIN
    -- Usually we declare all the variables inside the stored procedure after the 'BEGIN' keyword and at the start of the query
    --* Declaration of variables
    DECLARE @firstVar INT, @secondVar FLOAT -- Declaration of variables

    --* IF ELSE
    -- Prepare & Cleanup Data
    IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
    BEGIN
        PRINT ('Updating NULL Scores to 0 for '+ @Country);
        UPDATE SalesDB.Sales.Customers
        SET Score = 0
        WHERE Score IS NULL AND Country = @Country;
    END

    ELSE
    BEGIN
        PRINT ('No NULL Scores found')
    END;


    SELECT
        @firstVar = COUNT(*), -- If you are assigning value to a variable then you cannot have alias for it
        @secondVar = AVG(Score)
    FROM SalesDB.Sales.Customers
    WHERE country = @Country;

    PRINT 'Total Customers from ' + @Country + ' is: ' + CAST(@firstVar AS NVARCHAR); -- In print statement everything should be in string format, there cannot be dates, numbers, floats and so on
    PRINT 'Average Score from ' + @Country + ' is: ' + CAST(@secondVar AS NVARCHAR);


    -- We can add multiple queries in a single stored procedure
    SELECT
        COUNT(OrderID) AS totalOrders,
        SUM(Sales) AS totalSales
    FROM SalesDB.Sales.Orders o
    INNER JOIN SalesDB.Sales.Customers c
    ON c.CustomerID = o.CustomerID
    WHERE c.Country = @Country;

    -- If you are writing multiple queries in a single stored procedure then use semicolon afer each query ends

    --* Error Handling
    --* Try and CATCH 
    BEGIN TRY -- The function of BEGIN TRY is that try this block of code which might throw an error
        SELECT 1/0 AS myInt -- This will throw an error for sure as 1 cannot be divided by zero
    END TRY

    BEGIN CATCH -- SQL statements to handle the error
        -- Error Handling
        PRINT('An Error Occured');
        PRINT('Error Message: ' + ERROR_MESSAGE());
        PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
        PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
        PRINT('Error in Procedure: ' + CAST(ERROR_PROCEDURE() AS NVARCHAR));
    END CATCH
END
GO

-- Execute the procedure in a separate batch
EXEC GetCustomerSummary;
EXEC GetCustomerSummary @Country = 'Germany';


--* TRIGGERS
-- Triggers are special stored procedures (set of statements) that automatically runs in response to a specific event on a table or view
-- Triggers have multiple types
-- 1. DML Triggers (INSERT, UPDATE, DELETE statements)
--    We have two types of Triggers first is AFTER trigger (executed after the event) and second is INSTEAD OF trigger (Runs during the event)
-- 2. DDL (CREATE, ALTER, DROP)
-- 3. LOGGON

-- Use cases is about maintaining audit logs
-- SYNTAX
-- CREATE TRIGGER TriggerName ON tableName
-- We create the trigger and then we have to specify on which table we want the trigger, and then we need to define when this trigger id going to happen
-- We need to define AFTER or INSTEAD OF and define INSERT, UPDATE, DELETE

-- Creating the table where we want to keep all the logs information
CREATE TABLE SalesDB.Sales.Employee_Logs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    LogMessage VARCHAR(255),
    LogDate DATE
)

GO
CREATE OR ALTER TRIGGER trg_AfterInsertEmployee ON SalesDB.Sales.Employees
AFTER INSERT
AS
BEGIN
    INSERT INTO SalesDB.Sales.Employee_Logs (EmployeeID, LogMessage, LogDate)
    SELECT EmployeeID, 'New Employee Added: ' + CAST(EmployeeID AS VARCHAR), 
    GETDATE() FROM INSERTED
    -- INSERTED is a virtual table that holds a copy of the rows that are being inserted into the target table, 
    -- so whatever we are inserting into the Employees table it will be available into the INSERTED table as well and this is only available 
    -- during the execution of the trigger 
END
GO

SELECT * FROM SalesDB.Sales.Employee_Logs

INSERT INTO SalesDB.Sales.Employees
VALUES (6,'Harry','Kane','Finance','1988-01-12','M',120000,3)

SELECT * FROM SalesDB.Sales.Employees



--* INDEXES
-- Index is a data structure that provides quick access to the rows of the data , to improve the speed of the queries. 

-- INDEX Types
-- We have different indexes in databases for different purposes

--? Type 1
-- STRUCTURE (The first one is by the structure, how the database is organizing and referencing the data)
-- 1. Clustered Index
-- 2. Non-Clustered Index 

--? Type 2
-- STORAGE (In this category we are talking about how the data is stored physically in the database)
-- RowStore Index
-- ColumnStore Index

--? Type 3
-- FUNCTIONS
-- Unique Index
-- Filtered Index

--! Behind the scenes the database are stored in a different way
-- It stores the data in data files on the disk and inside the data files the data is stored in blocks called pages
-- A page is a unit of data storage in a database and it has a fixed size of 8 Kilobytes
-- A page can store anything inside it, it can store rows of tables and columns, metadata, indexes
-- A page has two types
-- Data page
-- Index page


-- Data page
-- The data page is divided into three sections
-- First section is the page header where it will store key information about the metadata, like Page ID, Page Type, etc
-- Second Section is Payload Area, this is where the actual data lies, SQL Server limits the total maximum row payload size on a single data page to 8,060 bytes. Rows are placed sequentially from the top down, starting directly below the header
-- Third Section is Row Offset Array (Slot Array) -- This is like a quick index for the rows stored inside this page. It keeps track of where each rows begins, so that the SQL can easily locate a specific row without having SQL, like scanning the entire page in order to find a row
-- It uses exactly 2 bytes per row. It acts as a map or pointer index. Each 2-byte slot indicates the exact byte offset distance from the start of the page to where that specific data row begins

-- HEAP STRUCTURE 
-- In SQL Server, a heap table is a table without a clustered index. It stores the data as it is, unordered and unsorted. 
-- INSERT operations are very fast, Finding something from this table is going to be very slow. This is a tradeoff

-- For example if we want to find a particular record, specific to a ID, It will search the ID in the table row by row which means that it will scan all the data pages row by row, which means it is doing a full table scan.
-- If it a small table then it is fine, but if the table has millions of rows then searching through the heap structure will take a lot of time, and that is the reason why we need indexes in databases


SELECT * FROM sys.indexes

SELECT OBJECT_NAME(object_id) AS TableName ,type 
FROM sys.indexes 
WHERE type = 0; -- 0 indicates a HEAP

--* CLUSTERED INDEX
-- Let's say you create a clustered index on the ID column of table customers, first thing that will happen is SQL is physically sort all the data based on column ID.
-- So the rows are rearranges in each data page in ascending order. So in first datapage there will be rows with ID 1,2,3,4.... and so on and in last data page the ending column IDs will be there
-- The next step is SQL will building a B-Tree. A B-Tree is short form of balanced tree, it is hierarchical structure that stores data upside down, It starts with the root node, and it keeps branching out
-- to form the leaf nodes. Between the leaf nodes and the root node their are intermediate nodes, so there can be one level of multiple level of intermediate nodes. Once B-tree is constructed then SQL can navigate
-- through the B-Tree to find specific information. It is very important to understand that the leaf nodes of the B-Tree contains the actual data, data pages. All the data is stored at leaf nodes, then SQL starts building the intermediate nodes
-- So in imtermediate nodes the database uses different pages which is called as Index page, we cannot find the actual data in this, but it stores key value that contains a pointer to another index page or to a data page. We do not have a pointer for each row,
-- we do have a pointer for each cluster, that is why it is called it is as Clustered index.
-- Once SQL is done building the intermediate node, then SQL will now make the root node.


SELECT
   DB_NAME(database_id), 
   SUM(free_space_in_bytes) / 1024 AS 'Free_KB'
FROM sys.dm_os_buffer_descriptors
WHERE database_id <> 32767
GROUP BY database_id
ORDER BY SUM(free_space_in_bytes) DESC

--* NON CLUSTERED INDEX
-- At the begining we are at the HEAP structure where the table does not have any index and the data is stored randomly inside the data pages.
-- If we go and create a non clustered index, the big difference is SQL will not touch the physical actual data on the data pages. The data pages going to stay as it is and nothing is going to change.
-- The SQL will start building the B-Tree Structure, so first it will build an index page, this index page is a little bit different from the Clustered index, in this we can store pointers.
-- This time it is going to store the key customer ID, and one customerID will be associated with a value of the pointer. The pointer will be the exact address where the specific row is located corresponding to the cusomterID.
-- The address will be the FileID, Page number and the row offset to locate the row exactly. This whole thing is called the RID which is the Row Identifier. The first part of the RID is matching to the data page and second part is the row offset
-- SQL will go on and continue and assign each customerID with a RID (A pointer to the exact location)
-- We can see that in the index page, we don't have like a pointer for each group of customers, like we had in the clusters index, we have now a pointer for each ID.
-- This type of index page we call is row locator page
-- Those index pages that has the row identifier is going to be stored at the leaf level of the B-tree. So at the leaf level we don't have the actual data, the data pages. We have index pages where we have pointers to the actual data.
-- SQL will now start building the intermediate nodes. It's exactly like the clustered index where it's going to point to another index page.
-- Finally it will make the root node.
-- This is again called the B-Tree structure. But the data pages are not a part of B-Tree structure


--! You can create only one CLUSTERED Index on the table.
-- This makes sense because we can only sort the data physically only once.
--! You can create any number of non clustered index

-- ==========================================================
-- CLUSTERED INDEX vs NON-CLUSTERED INDEX
-- ==========================================================

--                  CLUSTERED INDEX              NON-CLUSTERED INDEX
-- --------------------------------------------------------------------
-- Definition        Physically sorts and          Separate index structure
--                   stores table rows             with pointers to data
--
-- Number             Only 1 per table              Multiple allowed
--
-- Read Speed         Faster                        Slower
--                   (direct data access)           (extra intermediate node)
--
-- Write Speed        Slower                        Faster
--                   (rows may reorder)             (data order unchanged)
--
-- Storage            More storage efficient        Requires extra storage due to index pages
--
-- Best Used For      Primary Key, Unique           WHERE conditions,
--                   columns, range queries         JOINs, exact searches
--
-- Example            Employee_ID                  Department, Email



--* SYNTAX 
/*CREATE [CLUSTERED | NONCLUSTERED] INDEX index_name ON
table_name (column 1, column 2, ...)
*/ -- By default it is NONCLUSTERED Index
-- Index with multiple columns is called as COMPOSITE Index

SELECT * 
INTO SalesDB.Sales.DBCustomers
FROM SalesDB.Sales.Customers

CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID ON SalesDB.Sales.DBCustomers (CustomerID)

SELECT * FROM SalesDB.Sales.DBCustomers
WHERE CustomerID = 2
-- As per the query plan SQL database engine is using the Clustered Index Seek
-- If clustered index was not there then to search for the specific record SQL database engine would do full table scan

-- DROP 
DROP INDEX idx_DBCustomers_CustomerID ON SalesDB.Sales.DBCustomers

SELECT * FROM SalesDB.Sales.DBCustomers
WHERE LastName = 'Brown'
-- If you find yourself using this query a lot of times then you can go ahead and make a non clustered index

CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName ON SalesDB.Sales.DBCustomers (LastName)

DROP INDEX idx_DBCustomers_LastName ON SalesDB.Sales.DBCustomers


-- COMPOSITE INDEX
SELECT * FROM SalesDB.Sales.DBCustomers
WHERE Country = 'USA' AND Score > 500
-- The columns of index must match the order in your query

CREATE INDEX idx_DBCustomers_CountryScore ON SalesDB.Sales.DBCustomers (Country, Score)

-- Leftmost Prefix Rule
-- Index works only if your query filters start from the first column in the index and follow its order.

-- A,B,C,D (Order of Index)
-- Index will be used
-- A
-- A,B
-- A,B,C

-- Index won't be used
-- B
-- A,C (You canont skip one column in between, index will not work)
-- A,B,D


--* INDEX BY STORAGE

--* ROWSTORE INDEX
-- If we use rowstore index, our table will be split into multiple rows, and each group of rows will be stored inside a data page.
-- We are organising the data row by row, which means all the columns will be stored in each row

--* COLUMNSTORE INDEX
-- In column store, SQL will split your table into multiple separate columns

-- Column Store Index in SQL Server

-- Example table:
-- Customer(ID, Name, Status)
-- Rows: ~2 million customers

-- Default storage:
-- Table is stored as HEAP (row-by-row) inside data pages.


-- Step 1: Create Row Groups
-- SQL Server divides rows into row groups (~1 million rows each)
-- Example:
-- Row Group 1 -> First 1 million rows
-- Row Group 2 -> Second 1 million rows
--
-- Purpose:
-- - Enables parallel processing
-- - Improves query performance


-- Step 2: Column Segmentation
-- Each row group is divided by columns
--
-- Example:
-- Row Group 1:
--   ID segment
--   Name segment
--   Status segment
--
-- This creates the "column store" format.


-- Step 3: Data Compression
-- Main reason column store is fast.
--
-- Example:
-- Status column:
-- Active
-- Inactive
-- Active
-- Active
--
-- SQL creates a dictionary:
--
-- Dictionary:
-- Active   -> 1
-- Inactive -> 2
--
-- Stored data:
-- 1 2 1 1
--
-- Benefits:
-- - Less storage
-- - Faster scans
-- - Better analytics performance


-- Step 4: Storage using LOB (Large Object) Pages
-- Column store does NOT use normal data pages.
-- It uses LOB pages.


-- LOB Page Structure:
--
-- Page Header
--    |
-- Segment Header
--    |
--    |-- Segment ID
--    |-- Row Group ID
--    |-- Column ID
--    |-- Dictionary Page Reference
--
-- Data Stream
--    |
--    |-- Compressed column values


-- Dictionary Page:
-- Stores mapping between original values and compressed values.
--
-- Example:
-- Active -> 1
-- Inactive -> 2


-------------------------------------------------

-- Clustered Column Store Index

-- Completely replaces the original table storage.
-- No B-Tree structure is created.
--
-- Table becomes:
--
-- Column Store Format
--    |
--    |-- Row Groups
--    |-- Column Segments
--    |-- Compressed Data
--
-- All columns are stored in columnar format.


-------------------------------------------------

-- Non-Clustered Column Store Index

-- Works as an additional structure on top of the existing table.
--
-- Original table remains:
--
-- Row Store Table
--        +
-- Column Store Index
--
-- Does NOT replace the original table.


-- Example:
-- Original table:
-- Customer(ID, Name, Status)
--
-- Create column store only on:
-- Status column
--
-- Non-clustered column store index:
-- Status -> Column Store Format


-------------------------------------------------

-- Clustered vs Non-Clustered Column Store Index

-- Clustered:
-- - Replaces table
-- - Stores entire table as column store
-- - No separate row storage remains

-- Non-Clustered:
-- - Additional index
-- - Original table remains unchanged
-- - Can include selected columns only


-- Column Store is mainly optimized for:
-- - Large datasets
-- - Analytics queries
-- - Aggregations
-- - Data warehouse workloads

--x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-

-- ============================================
-- ROWSTORE vs COLUMNSTORE INDEX (Summary)
-- ============================================

-- WHY COLUMNSTORE?
-- Designed for analytics workloads (OLAP)
-- Optimizes large aggregations and scans on huge tables
-- Used by SQL Server, Power BI, Tableau, Data Warehouses

-- ============================================
-- ROWSTORE INDEX
-- ============================================

-- Data stored row-by-row
-- Each row contains all column values together

-- Example:
-- [ID | Name | Status]
-- [1  | John | Active]
-- [2  | Mike | Inactive]

-- Query:
-- SELECT COUNT(*)
-- FROM Customers
-- WHERE Status = 'Active';

-- Execution:
-- 1. Read every row (ID, Name, Status)
-- 2. Filter Status = Active
-- 3. Perform COUNT()

-- Drawback:
-- Reads unnecessary columns (ID, Name)
-- Higher I/O and slower for analytics queries

-- Best for:
-- OLTP systems
-- Banking, e-commerce, transactional applications
-- Frequent INSERT, UPDATE, DELETE operations

-- Characteristics:
-- ✔ Balanced read/write performance
-- ✔ Fast transactions
-- ✖ More storage usage
-- ✖ Slower large-scale analytics

-- ============================================
-- COLUMNSTORE INDEX
-- ============================================

-- Data stored column-by-column

-- Example:
-- ID Column     -> [1,2,3,4,5]
-- Name Column   -> Dictionary compressed
-- Status Column -> Dictionary compressed
-- Active   = 1
-- Inactive = 2

-- Query:
-- SELECT COUNT(*)
-- FROM Customers
-- WHERE Status = 'Active';

-- Execution:
-- 1. Read only Status column
-- 2. Use dictionary values
-- 3. Filter Active rows
-- 4. Perform COUNT()

-- Advantage:
-- Reads only required columns
-- Much lower I/O
-- Faster aggregations and scans

-- Compression:
-- Uses dictionary encoding
-- Reduces storage significantly

-- Best for:
-- OLAP systems
-- Data Warehouses
-- Data Lakes
-- Business Intelligence
-- Reporting & Analytics

-- Characteristics:
-- ✔ Excellent read performance
-- ✔ High compression ratio
-- ✔ Low disk I/O
-- ✔ Fast aggregations
-- ✖ Slower INSERT/UPDATE operations

-- ============================================
-- COMPARISON
-- ============================================

-- Storage Structure
-- Rowstore    -> Row-by-row
-- Columnstore -> Column-by-column

-- Storage Efficiency
-- Rowstore    -> Higher storage usage
-- Columnstore -> Compressed, lower storage

-- Read Performance
-- Rowstore    -> Good
-- Columnstore -> Excellent for analytics

-- Write Performance
-- Rowstore    -> Fast
-- Columnstore -> Slower

-- Disk I/O
-- Rowstore    -> Reads many unnecessary columns
-- Columnstore -> Reads only required columns

-- Best Workload
-- Rowstore    -> OLTP (Transactions)
-- Columnstore -> OLAP (Analytics)

-- Use Cases
-- Rowstore    -> Banking, E-commerce, CRUD apps
-- Columnstore -> Reporting, BI, Data Warehouses

-- RULE OF THUMB:
-- If your workload is transaction-heavy → Use ROWSTORE
-- If your workload is analytics/reporting-heavy → Use COLUMNSTORE

--* CREATING COLUMNSTORE INDEX
--* SYNTAX 
-- CREATE [CLUSTERED | NONCLUSTERED] [COLUMNSTORE] INDEX index_name -- ROWSTORE is default
-- ON table_name (columni, column2, ...)

--! Rules: You can't specific columns in Clustered Index Columnstore
--! You can create only one columnstore index for each table

--* STORAGE EFFICIENCY
-- 1 - Columnstore Index
-- 2 - Heap Table
-- 3 - Rowstore Clustered Index

--* UNIQUE INDEX
-- It ensures no duplicate values exist in specific column

-- UNIQUE INDEX:
-- Special index type that prevents duplicate values in a column.

-- Why use UNIQUE INDEX?
-- 1. Data Integrity:
--    Ensures columns like Email, ProductID, etc. contain only unique values.
--    Prevents accidental duplicate records.

-- 2. Query Performance:
--    Faster searches because SQL knows only one matching row can exist.
--    Once the value is found, SQL stops searching.

-- Trade-off:
--    WRITE operations (INSERT/UPDATE) become slightly slower
--    because SQL must check uniqueness before storing data.
--
--    READ operations become faster because data is guaranteed to be unique.


-- Syntax:
-- CREATE UNIQUE NONCLUSTERED INDEX index_name ON table_name(column_name);

-- Normal Index:
-- Duplicates are allowed
-- CREATE INDEX idx_product_name ON Sales.Products(ProductName);

-- Unique Index:
-- Duplicates are NOT allowed
-- CREATE UNIQUE NONCLUSTERED INDEX idx_product_name ON Sales.Products(ProductName);

-- Example:
-- Creating unique index on ProductName
-- CREATE UNIQUE NONCLUSTERED INDEX idx_products_name ON Sales.Products(ProductName);

-- Works because ProductName values are unique.
-- If we insert duplicate data:
-- INSERT INTO Sales.Products(ProductID, ProductName) VALUES (106, 'Caps');
-- Error:
-- Cannot insert duplicate value because ProductName
-- has a UNIQUE INDEX.

-- Key Point:
-- Use UNIQUE INDEX when a column must always contain unique values.
-- Example: Email, CustomerID, ProductID, Username


--* FILTER INDEX
-- FILTERED INDEX:
-- A filtered index is a non-clustered index that stores only rows
-- matching a specific condition (WHERE clause).

-- Example:
-- Instead of indexing all customers: USA, Germany, India
-- We create an index only for:
-- Country = 'USA'

-- Benefits:
-- 1. Faster Queries:
--    Smaller B-tree structure = faster search
--    Only relevant rows are scanned.

-- 2. Less Storage:
--    Index contains fewer rows, so it requires less space.

-- 3. Targeted Optimization:
--    Useful when queries frequently filter on the same condition.
--    Example: Active customers, USA customers, Recent orders.


-- Syntax:

-- CREATE NONCLUSTERED INDEX index_name ON table_name(column_name)
-- WHERE condition;


-- Example:
-- Most queries use:
-- WHERE Country = 'USA'

-- CREATE NONCLUSTERED INDEX idx_customer_country ON Sales.Customers(Country)
-- WHERE Country = 'USA';


-- Result:
-- Index contains only USA customers.
-- Other countries are not stored in this index.

-- Query using the filtered index:
-- SELECT * FROM Sales.Customers
-- WHERE Country = 'USA';

-- SQL can use the filtered index
-- because the required rows exist inside it.

-- Query not using the filtered index:

-- SELECT * FROM Sales.Customers
-- WHERE Country = 'Germany';


-- Germany rows are not part of the index,
-- so SQL cannot use this filtered index.


-- Restrictions:
-- ❌ Cannot create filtered index on Clustered Index
--    (Clustered index stores the entire table order)

-- ❌ Cannot create filtered index on Columnstore Index

-- ✅ Works with Non-Clustered Index only

-- ✅ Can combine with UNIQUE:

-- CREATE UNIQUE NONCLUSTERED INDEX idx_unique_email ON Customers(Email)
-- WHERE Status = 'Active';

-- Key Point:
-- Filtered Index = Smaller index + Faster queries + Less storage
-- Use when you repeatedly query a specific subset of data.


--* HOW TO CHOOSE THE RIGHT INDEX

-- 1. HEAP (No Index)
-- Default table structure without indexes.
-- Use when:
-- - Need very fast INSERT operations
-- - Data is temporary or staging data
-- - Table is not frequently queried
-- Example:
-- ETL staging tables

--------------------------------------------------

-- 2. CLUSTERED INDEX (Row Store)
-- Physically sorts and stores table data.

-- Use when:
-- - Column is a Primary Key (default choice)
-- - Data sorting is important
-- - Frequent row lookups are needed

-- Example:
-- CustomerID, OrderDate

-- Commonly used in: OLTP systems

--------------------------------------------------

-- 3. COLUMNSTORE INDEX
-- Stores data by columns instead of rows.

-- Use when:
-- - Large tables
-- - Complex analytical queries
-- - Aggregations (SUM, AVG, COUNT)
-- - Data warehouse/reporting workloads

-- Benefits:
-- - Faster analytics
-- - Better compression
-- - Reduces storage size

-- Commonly used in:
-- OLAP systems
-- (Business Intelligence, Data Warehousing)

--------------------------------------------------

-- 4. NON-CLUSTERED INDEX
-- Separate index structure pointing to table data.

-- Use when:
-- - Searching non-primary key columns
-- - Foreign keys
-- - JOIN columns
-- - WHERE clause filters

-- Example:
-- Email, CustomerName, Country

--------------------------------------------------

-- 5. FILTERED INDEX
-- Non-clustered index containing only rows
-- that satisfy a condition.

-- Use when:
-- - Queries always focus on a subset of data
-- - Full table index is too large

-- Benefits:
-- - Smaller index
-- - Less storage
-- - Faster targeted queries

--------------------------------------------------

-- 6. UNIQUE INDEX
-- Ensures no duplicate values exist.

-- Use when:
-- - Data must be unique
-- - Need data integrity

-- Examples:
-- Email
-- ProductID
-- Username

-- Benefits:
-- - Prevents duplicate records
-- - Slightly improves search performance

--------------------------------------------------

-- QUICK SUMMARY:
-- Need fast INSERTS? -> HEAP
-- Primary Key / Sorting? -> CLUSTERED INDEX
-- Large analytics / Reporting? -> COLUMNSTORE INDEX
-- Search / JOIN / WHERE columns? -> NON-CLUSTERED INDEX
-- Querying only a subset? -> FILTERED INDEX
-- Prevent duplicates? -> UNIQUE INDEX

--* INDEX MANAGEMENT

--* List of all the indexes on a specific table
sp_helpindex 'Sales.DBCustomers' -- This is a stored procedure which takes one argument as the table name. It gives information of the indexes in a table

--* Monitoring Index Usage
--? In SQL Server we have a special schema called sys where you can find a lot of metadata information about SQL Server (Contians metadata about database tables, views, indexes, etc...)

SELECT * FROM sys.indexes

SELECT
object_id,
name AS IndexName, type_desc AS IndexType, is_primary_key AS IsPrimarykey, is_unique AS IsUnique, is_disabled AS IsDisabled
FROM sys.indexes idx

SELECT
tbl.name AS TableName,
idx.name AS IndexName,
idx.type_desc AS IndexType,
idx.is_primary_key AS IsPrimarykey,
idx.is_unique AS IsUnique, 
idx.is_disabled AS IsDisabled,
s.user_seeks,
s.user_scans,
s.user_lookups,
s.user_updates,
COALESCE(s.last_user_seek, s.last_user_scan) AS LastUpdate
FROM sys.indexes idx
JOIN sys.tables tbl
ON idx.object_id = tbl.object_id
LEFT JOIN sys.dm_db_index_usage_stats s
ON s.object_id = idx.object_id AND s.index_id = idx.index_id
ORDER BY tbl.name, idx.name

-- DMV (Dynamic Management View) Provides real-time insights into Database performance and system health
SELECT * FROM sys.dm_db_index_usage_stats

SELECT * FROM sys.dm_db_missing_index_details -- To get suggestions of where to make index according to queries.

--* UPDATING STATISTICS
-- Statistics are used by the SQL Server query optimizer to determine the most efficient way to execute a query. They provide information about the distribution of data in a table or index, which helps the optimizer make informed decisions about query execution plans.

SELECT
SCHEMA_NAME(t.schema_id) AS SchemaName,
t.name AS TableName,
s.name AS StatisticName, sp.last_updated As LastUpdate,
DATEDIFF(day, sp.last_updated, GETDATE()) As LastUpdateDay,
sp.rows AS 'Rows',
sp.modification_counter AS ModificationsSinceLastUpdate
FROM sys.stats AS s
JOIN sys.tables t
ON s.object_id = t.object_id
CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) AS sp
ORDER BY sp.modification_counter DESC;

UPDATE STATISTICS SalesDB.Sales.DBCustomers WITH FULLSCAN -- This will update the statistics of the table DBCustomers with full scan of the data

UPDATE STATISTICS Sales.DBCustomers _WA_Sys_00000005_35BCFE0A -- Updates a specific index statistics by providing the name of the index. This is useful when you want to update statistics for a specific index rather than the entire table.

EXEC sp_updatestats -- This will update the statistics of all the tables in the database. It is a system stored procedure that updates the statistics for all user-defined and internal tables in the current database.


--* MONITORING FRAGMENTATION
-- Fragmentation occurs when the logical order of data pages does not match the physical order on disk

SELECT
tbl.name AS TableName,
idx.name AS IndexName,
s.avg_fragmentation_in_percent,
s.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') AS s
INNER JOIN sys.tables tbl
ON s.object_id = tbl.object_id
INNER JOIN sys.indexes AS idx
ON idx.object_id = s.object_id
AND idx.index_id = s.index_id
ORDER BY s.avg_fragmentation_in_percent DESC

-- INDEX FRAGMENTATION:
-- Over time INSERT, UPDATE, DELETE operations can make indexes fragmented.
--
-- Fragmentation means:
-- - Data pages are not stored in logical order
-- - Empty/unused spaces exist
-- - Index performance decreases
-- - Queries become slower


--------------------------------------------------


-- CHECK INDEX HEALTH:
-- Use Dynamic Management Function to check fragmentation
SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,NULL);

-- Important column:
-- avg_fragmentation_in_percent
--
-- 0%    = Healthy index
-- 100%  = Highly fragmented index


--------------------------------------------------


-- FIXING FRAGMENTATION:
-- SQL Server provides two methods:


-- 1. REORGANIZE
-- Lightweight operation
--
-- - Defragments leaf level pages
-- - Sorts index order again
-- - Does not block users
-- - Faster operation
--
-- Use when fragmentation:
-- 10% - 30%
ALTER INDEX idx_DBCustomers_CustomerID ON SalesDB.Sales.DBCustomers REORGANIZE -- This will reorganize the index, which is a lighter operation that defragments the leaf level of the index pages. It is less resource-intensive and can be done online without locking the table.


--------------------------------------------------


-- 2. REBUILD
-- Heavyweight operation
--
-- - Drops the old index
-- - Creates index again from scratch
-- - Removes fragmentation completely
-- - Fixes page space issues
-- - Takes more time
--
-- Use when fragmentation:
-- > 30%
ALTER INDEX idx_DBCustomers_CustomerID ON SalesDB.Sales.DBCustomers REBUILD -- This will rebuild the index, which is a more intensive operation that drops and recreates the index. It can be done offline or online, depending on the SQL Server edition and settings. Rebuilding an index can improve performance by eliminating fragmentation and updating statistics.

--------------------------------------------------

-- RECOMMENDED APPROACH:
--
-- Fragmentation 0% - 10% -> Do nothing
-- Fragmentation 10% - 30% -> REORGANIZE index
-- Fragmentation > 30% -> REBUILD index

--------------------------------------------------

-- INDEX MAINTENANCE CHECKLIST:
--
-- 1. Monitor index fragmentation
-- 2. Check missing indexes
-- 3. Keep database statistics updated
-- 4. Reorganize/Rebuild unhealthy indexes
-- 5. Monitor index usage

-- Goal:
-- Healthy indexes = Faster queries + Better performance


--* EXECUTION PLAN

SELECT * FROM Sales.Customers -- CLUSTERED INDEX SCAN

SELECT * 
INTO Sales.Customers_HP
FROM Sales.Customers 

SELECT * FROM Sales.Customers_HP -- HEAP SCAN (TABLE SCAN)

SELECT * FROM Sales.Customers
WHERE CustomerID = 2 -- CLUSTERED INDEX SEEK

-- EXECUTION PLAN:
-- A tool used to understand how SQL Server executes a query step-by-step.
-- Helps identify performance issues and decide where to create indexes.


--------------------------------------------------


-- Query Execution Flow:
--
-- 1. SQL creates an execution plan
--    - Based on query + database statistics
--
-- 2. SQL executes the plan
--    - Reads data
--    - Joins tables
--    - Filters/sorts/aggregates data
--
-- 3. Execution plan can be stored in cache
--    - Similar queries can reuse the plan faster


--------------------------------------------------


-- WHY USE EXECUTION PLAN?
--
-- Find:
-- - Slow operations
-- - Missing indexes
-- - Wrong index usage
-- - Expensive joins/sorts/scans


--------------------------------------------------


-- TYPES OF EXECUTION PLANS:


-- 1. Estimated Execution Plan
--
-- Shows SQL's prediction BEFORE running query.
-- Does not execute the query.


-- 2. Actual Execution Plan
--
-- Shows the real plan AFTER query execution.
-- Most commonly used for optimization.


-- 3. Live Query Statistics
--
-- Shows execution progress in real time.


--------------------------------------------------


-- HOW TO READ EXECUTION PLAN:
--
-- Read from RIGHT to LEFT
--
-- Data Source  --->  Processing  --->  Result


--------------------------------------------------


-- COMMON OPERATORS:


-- TABLE SCAN:
-- Reads entire heap table.
-- Slow for large tables.

-- Example:
-- Heap without indexes


-- CLUSTERED INDEX SCAN:
-- Reads data from clustered index.
-- Can scan full table or part of index.


-- INDEX SEEK:
-- BEST operation.
--
-- SQL directly finds required rows using index.
-- Reads only needed data.


-- INDEX SCAN:
-- Reads many rows from index.
-- Better than table scan but slower than seek.


--------------------------------------------------


-- COST INFORMATION:
--
-- Execution plan shows:
-- - CPU Cost
-- - I/O Cost
-- - Operator Cost %
--
-- Higher percentage = bigger performance problem


--------------------------------------------------


-- INDEX VALIDATION:
--
-- After creating an index:
--
-- 1. Run query
-- 2. Open execution plan
-- 3. Check if SQL uses your index
--
-- If not:
-- -> Index may not be useful


--------------------------------------------------


-- KEY LOOKUP:
--
-- Happens when:
-- - Index finds matching rows
-- - But required columns are missing
--
-- SQL goes back to table to fetch remaining columns.


-- Index finds CarrierTrackingNumber
-- Lookup gets remaining columns


--------------------------------------------------


-- JOINS IN EXECUTION PLAN:
--
-- Nested Loop:
-- Good for small datasets
--
-- Merge Join:
-- Good when both inputs are sorted
--
-- Hash Join:
-- Good for large datasets


--------------------------------------------------


-- COLUMNSTORE INDEX:
--
-- Best for:
-- - Large tables
-- - Aggregations
-- - Data warehouse queries
--
-- Benefits:
-- - Compression
-- - Less I/O
-- - Faster analytics


--------------------------------------------------


-- EXECUTION PLAN OPTIMIZATION PROCESS:
--
-- 1. Check slow query
--
-- 2. Open actual execution plan
--
-- 3. Find expensive operator
--
-- 4. Create/modify index
--
-- 5. Run query again
--
-- 6. Compare execution plans


--------------------------------------------------


-- KEY TAKEAWAY:
--
-- Execution Plan = SQL Server's roadmap
--
-- Use it to understand:
-- - How SQL reads data
-- - Which indexes are used
-- - Where performance bottlenecks exist
--
-- Right index + Execution Plan
-- = Faster queries

--* SQL HINTS
-- Used to manually control SQL Server's execution plan.
-- Normally SQL Server decides:
-- - Which index to use
-- - Which join method to use
-- - How to read data
--
-- Decision is based on:
-- - Statistics
-- - Indexes
-- - Query structure

--------------------------------------------------

-- WHY USE SQL HINTS?

-- Sometimes SQL chooses a bad execution plan because:
-- - Statistics are outdated
-- - Too many indexes exist
-- - Query optimizer makes wrong assumptions

-- Hints allow us to override SQL's decision.

--------------------------------------------------

-- 1. FORCE JOIN TYPE

-- Example:
-- SQL uses Nested Loop but tables are very large.
-- We can force Hash Join.


SELECT *
FROM Sales.Orders o
JOIN Sales.Customers c
ON o.CustomerID = c.CustomerID
OPTION (HASH JOIN); -- SQL now uses Hash Join instead of choosing itself.

--------------------------------------------------

-- 2. FORCE INDEX SEEK
-- Tells SQL to use index seek instead of scan.

SELECT *
FROM Sales.Customers WITH (FORCESEEK)
WHERE CustomerID = 10;

-- Forces SQL to directly find rows
-- instead of scanning many rows.

--------------------------------------------------

-- 3. FORCE SPECIFIC INDEX
-- Tell SQL exactly which index to use.

SELECT *
FROM Sales.Customers WITH (INDEX(PK_customers))
WHERE CustomerID = 10;
-- SQL uses the specified index.

--------------------------------------------------

-- WITHOUT HINTS:
-- SQL chooses execution plan automatically.

SELECT *
FROM Sales.Orders;

-- SQL decides:
-- - Scan or seek
-- - Join type
-- - Index usage

--------------------------------------------------

-- SQL HINTS BENEFITS:
-- More control over execution plan
-- Can improve slow queries temporarily
-- Useful for troubleshooting

--------------------------------------------------

-- IMPORTANT WARNINGS:
-- Do NOT use hints as a permanent solution.
-- A hint that works in development may fail in production because:
-- - Data size is different
-- - Statistics are different
-- - Indexes are different
-- Always test hints in each environment.

--------------------------------------------------

-- BEST PRACTICE:
-- Use hints as a temporary workaround.
-- Find the real issue:
-- - Update statistics
-- - Fix indexes
-- - Optimize query
-- Then remove the hint.

--------------------------------------------------

-- KEY TAKEAWAY:
-- SQL Hints = Override SQL optimizer decisions
-- Powerful tool 
-- Use carefully 
-- Only when SQL chooses a bad execution plan.

--* PARTITIONS 
-- Partitioning is a database design technique that divides a large table into smaller, more manageable pieces called partitions. Each partition can be stored separately, often on different filegroups or storage devices. This can improve query performance, manageability, and maintenance of large datasets.

--! STEP 1: Creating PARTITION FUNCTION

CREATE PARTITION FUNCTION PartitionByYear (DATE)
AS RANGE LEFT FOR VALUES ('2023-12-31','2024-12-31','2025-12-31')

-- Query to check the partition function and its details
SELECT
name,
function_id,
type,
type_desc,
boundary_value_on_right
FROM sys.partition_functions

--! STEP 2: Creating FILEGROUPS
ALTER DATABASE SalesDB ADD FILEGROUP FG_2023;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2024;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2025;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2026;

-- To remove a filegroup, you can use the following command:
-- ALTER DATABASE SalesDB REMOVE FILEGROUP FG_2023;

-- Query list of all existing filegroups in the database
SELECT * FROM sys.filegroups
WHERE type = 'FG' -- This will give you the list of all the filegroups in the database. The type 'FG' indicates that it is a filegroup.
-- PRIMARY filegroup is the default filegroup where all the data is stored if you don't specify any filegroup while creating a table or index. You can have multiple filegroups in a database, and you can use them to organize your data and improve performance.

-- STEP 3: Add .ndf files to each filegroups

ALTER DATABASE SalesDB ADD FILE (NAME = 'P_2023', FILENAME = '/var/opt/mssql/data/P_2023.ndf') TO FILEGROUP FG_2023;
ALTER DATABASE SalesDB ADD FILE (NAME = 'P_2024', FILENAME = '/var/opt/mssql/data/P_2024.ndf') TO FILEGROUP FG_2024;
ALTER DATABASE SalesDB ADD FILE (NAME = 'P_2025', FILENAME = '/var/opt/mssql/data/P_2025.ndf') TO FILEGROUP FG_2025;
ALTER DATABASE SalesDB ADD FILE (NAME = 'P_2026', FILENAME = '/var/opt/mssql/data/P_2026.ndf') TO FILEGROUP FG_2026;


SELECT
fg.name AS FilegroupName,
mf.name AS LogicalFileName,
mf.physical_name AS PhysicalFilePath,
mf.size / 128 AS SizeInMB
FROM sys.filegroups fg
JOIN sys.master_files mf ON fg.data_space_id = mf.data_space_id
WHERE mf.database_id = DB_ID('SalesDB')

-- STEP 4: Creating PARTITION SCHEME
CREATE PARTITION SCHEME PartitionSchemeByYear
AS PARTITION PartitionByYear TO (FG_2023, FG_2024, FG_2025, FG_2026)
-- Sort the Filegroups according to the result of the Function's Partitions.
-- 3 boundaries in the function means 4 partitions, so we need to specify 4 filegroups in the scheme.

-- Query to check the partition scheme and its details
SELECT
ps.name AS PartitionSchemeName,
pf.name AS PartitionFunctionName, 
ds.destination_id AS PartitionNumber, 
fg.name AS FilegroupName
FROM sys.partition_schemes ps
JOIN sys.partition_functions pf ON ps.function_id = pf.function_id
JOIN sys.destination_data_spaces ds ON ps.data_space_id = ds.partition_scheme_id
JOIN sys.filegroups fg ON ds.data_space_id = fg.data_space_id

-- STEP 5: Creating a Partitioned Table
CREATE TABLE SalesDB.Sales.PartitionedOrders
(
    OrderID INT,
    OrderDate DATE,
    Sales INT
) ON PartitionSchemeByYear(OrderDate)

-- STEP 6: Inserting Data into the Partitioned Table
INSERT INTO SalesDB.Sales.PartitionedOrders (OrderID, OrderDate, Sales)
VALUES
(1, '2023-01-15', 100),
(2, '2023-05-20', 200),
(3, '2024-03-10', 150),
(4, '2024-07-25', 300),
(5, '2025-02-05', 250),
(6, '2025-09-15', 400),
(7, '2026-04-30', 350)

SELECT * FROM SalesDB.Sales.PartitionedOrders

-- Query to check the partition details of the table
SELECT
p.partition_number AS PartitionNumber,
f.name AS PartitionFilegroup,
p.rows AS NumberOfRows
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(p.object_id) = 'PartitionedOrders';

SELECT * FROM SalesDB.Sales.PartitionedOrders
Where OrderDate = '2024-03-10'

SELECT * FROM SalesDB.Sales.NoPartition
Where OrderDate = '2024-03-10'

-- Explanation: The first query will use partition elimination and only scan the partition that contains the data for '2024-03-10', while the second query will scan the entire table since it is not partitioned. This demonstrates the performance benefits of partitioning for large datasets.



-- SQL Performance Optimization Best Practices

------------------------------------------------------------
-- Golden Rule: Always Test Using Execution Plans
------------------------------------------------------------

-- SQL Optimizer behaves differently based on table size.

-- Small/Medium Tables:
-- - Performance differences may not be noticeable.

-- Large Tables (Millions/Billions of rows):
-- - Query optimization has a major impact.

-- Rule:
-- Always compare queries using Execution Plans.

-- If optimized query improves performance:
-- -> Use optimized query.

-- If no performance gain:
-- -> Choose the query that is easier to read and maintain.


-- ============================================================
-- QUERY WRITING BEST PRACTICES
-- ============================================================

-- Tip 1: Select Only Required Columns
------------------------------------------------------------

-- Bad:
SELECT *
FROM Sales.Customers;

-- Problem:
-- - Reads unnecessary columns
-- - Transfers extra data
-- - Slows query performance

-- Good:
SELECT CustomerID, FirstName
FROM Sales.Customers;

-- Fetch only required data.

------------------------------------------------------------
-- Tip 2: Avoid Unnecessary DISTINCT and ORDER BY
------------------------------------------------------------

-- DISTINCT:
-- - Removes duplicates
-- - Requires extra processing

-- ORDER BY:
-- - Sorts data
-- - Expensive operation

-- Bad:
SELECT DISTINCT *
FROM Sales.Orders
ORDER BY OrderDate;

-- Good:
-- Use only when required.

------------------------------------------------------------
-- Tip 3: Limit Rows During Data Exploration
------------------------------------------------------------

-- Bad:
SELECT *
FROM Sales.Orders;

-- Problem:
-- Reads millions of rows unnecessarily.

-- Good:
SELECT TOP 10 *
FROM Sales.Orders;

-- Fetch only sample data while exploring.

============================================================
-- FILTERING OPTIMIZATION
============================================================

-- Tip 4: Index Frequently Filtered Columns
------------------------------------------------------------
-- If a column is frequently used in WHERE clause:

SELECT *
FROM Sales.Orders
WHERE OrderStatus = 'Delivered';

-- Create:
-- Non-clustered index on Status

-- Benefit:
-- Faster filtering using index seek.

------------------------------------------------------------
-- Tip 5: Avoid Functions on Columns in WHERE Clause
------------------------------------------------------------
-- Bad:
SELECT *
FROM Sales.Orders
WHERE LOWER(OrderStatus) = 'delivered';
-- Problem:
-- SQL cannot use existing index.

-- Good:
SELECT *
FROM Sales.Orders
WHERE OrderStatus = 'Delivered';
-- Avoid transforming indexed columns.


------------------------------------------------------------

-- Example:
-- Bad:
SELECT * FROM Sales.Customers
WHERE SUBSTRING(FirstName,1,1) = 'A'
-- Does not use index on FirstName.

-- Good:
WHERE FirstName LIKE 'A%'
-- Allows index usage.

------------------------------------------------------------
-- Date Example:
-- Bad:
SELECT * FROM Sales.Orders
WHERE YEAR(OrderDate) = 2025
-- Does not use index on OrderDate.
-- Avoid functions on indexed columns.

-- Good:
SELECT * FROM Sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'

------------------------------------------------------------
-- Tip 6: Avoid Leading Wildcards
------------------------------------------------------------

-- Bad:
SELECT *
FROM Sales.Customers
WHERE LastName LIKE '%Gold'
-- Problem:
-- SQL cannot use index.
-- Index can be used.

-- Good:
SELECT *
FROM Sales.Customers
WHERE LastName LIKE 'Gold%'

------------------------------------------------------------
-- Tip 7: Use IN Instead of Multiple OR Conditions
------------------------------------------------------------

-- Bad:
SELECT * FROM Sales.Customers
WHERE CustomerID = 1
OR CustomerID = 2
OR CustomerID = 3

-- Good:
SELECT * FROM Sales.Customers
WHERE CustomerID IN (1,2,3)
-- Benefits:
-- - Cleaner query
-- - Better optimization

============================================================
-- AGGREGATION OPTIMIZATION
============================================================
-- Tip 8: Use Columnstore Index for Large Aggregations
------------------------------------------------------------

-- Best for:
-- - Fact tables
-- - Data warehouse
-- - Millions of rows

-- Benefits:
-- - Data compression
-- - Faster scans
-- - Faster aggregations

------------------------------------------------------------
-- Tip 9: Pre-Aggregate Data for Reporting
------------------------------------------------------------

-- Problem:
-- Large aggregation query takes minutes.
-- Solution:
-- Store aggregated results:

SELECT 
CustomerID,
COUNT(*) AS OrderCount
INTO Sales.SalesSummary
FROM Sales.Orders
GROUP BY CustomerID;

-- Reporting queries become faster.
-- Remember:
-- Refresh summary tables when new data arrives.

============================================================
-- JOIN OPTIMIZATION
============================================================
-- Tip 10: Prefer ANSI JOIN Syntax
------------------------------------------------------------

-- Bad:
SELECT * 
FROM Sales.Customers C, Sales.Orders O
WHERE C.CustomerID = O.CustomerID

-- Good:
SELECT *
FROM Sales.Customers C
INNER JOIN Sales.Orders O
ON C.CustomerID = O.CustomerID
-- Benefits:
-- - Easier to read
-- - Easier optimization

------------------------------------------------------------
-- Tip 11: Index Columns Used in JOIN Conditions
------------------------------------------------------------

-- Example:

--Customers.CustomerID
-- Orders.CustomerID
-- Both columns should have indexes.
-- Without index:
-- Full table scan happens.

------------------------------------------------------------
-- Tip 12: Filter Data Before Joining Large Tables
------------------------------------------------------------

-- Small Tables:
-- Normal JOIN + WHERE is acceptable.

-- Large Tables:
-- Prepare data first using CTE/Subquery.

Example:

WITH FilteredOrders AS
(
    SELECT *
    FROM Sales.Orders
    WHERE OrderStatus='Delivered'
)
SELECT *
FROM Sales.Customers C
JOIN FilteredOrders O
ON C.CustomerID = O.CustomerID;
-- Reduce rows before joining.

------------------------------------------------------------
-- Tip 13: Aggregate Before Joining Large Tables
------------------------------------------------------------

-- Bad:
--JOIN tables first then GROUP BY

-- Better:
-- 1. Aggregate data first
-- 2. Join aggregated result


Example:

WITH OrderSummary AS
(
    SELECT 
    CustomerID,
    COUNT(*) OrderCount
    FROM Sales.Orders
    GROUP BY CustomerID
)
SELECT *
FROM Sales.Customers c
JOIN OrderSummary o
ON c.CustomerID = o.CustomerID;
-- Reduces data movement.

------------------------------------------------------------
-- Tip 14: Avoid Correlated Subqueries
------------------------------------------------------------

-- Bad:
-- Runs aggregation for every row.
-- Causes repeated scans.

-- Better:
-- Use:
-- - CTE
-- - Window Functions
-- - Pre-aggregation

------------------------------------------------------------
-- Tip 15: Avoid OR Conditions in JOINs
------------------------------------------------------------

-- Bad:
-- ON A.ID = B.ID
-- OR A.ID = B.SalesPersonID
-- Problem:
-- - Poor index usage
-- - Slower joins

-- Better:
-- Query 1 JOIN
-- UNION
-- Query 2 JOIN
-- Improves performance on large tables.

------------------------------------------------------------
-- Tip 16: Check Join Type in Execution Plan
------------------------------------------------------------

-- Nested Loop:
-- Good for small tables.

-- Hash Join:
-- Better for large tables.

-- If SQL chooses wrong join:
-- OPTION(HASH JOIN)
-- Force better join strategy.

============================================================
-- UNION OPTIMIZATION
============================================================
-- Tip 17: Use UNION ALL Instead of UNION When Possible
------------------------------------------------------------

-- UNION:
-- - Removes duplicates
-- - Extra processing

-- UNION ALL:
-- - Directly combines results
-- - Faster

-- Use UNION ALL when:
-- - Duplicates are acceptable
-- - Duplicates do not exist

------------------------------------------------------------
-- Tip 18: For Very Large Tables Use UNION ALL + DISTINCT
------------------------------------------------------------

-- Instead of: UNION


-- Use:
SELECT DISTINCT *
FROM
(
SELECT 1 AS num
UNION ALL
SELECT 2
) AS CombinedResults 
-- Test execution plan before choosing.

============================================================
-- TABLE DESIGN (DDL) BEST PRACTICES
============================================================
-- Tip 19: Avoid VARCHAR/TEXT When Possible
------------------------------------------------------------

-- Problems:
-- - More storage
-- - Expensive sorting
-- - Expensive indexing

-- Use correct data types.
/*
Example:
Bad:
Birthday VARCHAR(50)
Good:
Birthday DATE

Bad:
Score VARCHAR(20)
Good:
Score INT
*/

------------------------------------------------------------
-- Tip 20: Avoid VARCHAR(MAX) or Oversized Lengths
------------------------------------------------------------

-- Bad:
-- Name VARCHAR(MAX)

-- Good:
-- Name VARCHAR(50)
-- Benefits:
-- - Smaller indexes
-- - Better performance

------------------------------------------------------------
-- Tip 21: Use NOT NULL Constraints
------------------------------------------------------------

-- Benefits:
-- - Better data integrity
-- - Better indexes
-- - Less filtering logic

------------------------------------------------------------
-- Tip 22: Every Table Should Have Clustered Primary Key
------------------------------------------------------------

-- Benefits:
-- - Faster lookups
-- - Better relationships
-- - Default clustered index

------------------------------------------------------------
-- Tip 23: Index Frequently Used Foreign Keys
------------------------------------------------------------

-- Foreign keys used in:
-- - JOIN
-- - Filtering
-- Create non-clustered indexes when needed.

============================================================
-- INDEX MAINTENANCE
============================================================
-- Tip 24: Avoid Over-Indexing
------------------------------------------------------------

-- Too many indexes:
-- - Slow INSERT/UPDATE/DELETE
-- - Consume storage
-- - Confuse optimizer

------------------------------------------------------------
-- Tip 25: Remove Unused Indexes
------------------------------------------------------------

-- Monitor index usage.
-- Drop indexes that are never used.

------------------------------------------------------------
-- Tip 26: Update Statistics Regularly
------------------------------------------------------------

-- Outdated statistics:
-- -> Bad execution plans
-- -> Slow queries

------------------------------------------------------------
-- Tip 27: Rebuild/Reorganize Indexes
------------------------------------------------------------

-- Prevent:
-- - Fragmentation
-- - Wasted space
-- - Poor performance

============================================================
-- LARGE TABLE OPTIMIZATION
============================================================
-- Tip 28: Use Partitioning for Huge Tables
------------------------------------------------------------

-- Helps:
-- - Faster reads
-- - Faster writes

-- Combine:
-- Partitioning + Columnstore Index

-- Best for:
-- Large warehouse tables.

============================================================
-- FINAL RULE
============================================================

-- SQL Optimization is not only about indexes.

-- Focus on:
-- 1. Writing readable queries
-- 2. Correct table design
-- 3. Proper indexing
-- 4. Testing with execution plans

-- Measure → Test → Optimize


-- DATA ARCHITECTURE DESIGN

-- Data Architecture = Blueprint of a Data System
--
-- Similar to building a house:
-- Architect designs structure before construction.
--
-- Data Architect defines:
-- - How data flows
-- - How data is stored
-- - How data is accessed
-- - Scalability
-- - Maintainability



============================================================
-- DATA ARCHITECTURE APPROACHES
============================================================

============================================================
-- STEP 1: CHOOSE DATA ARCHITECTURE APPROACH
============================================================

-- Approach 1: Data Warehouse
------------------------------------------------------------
-- Best for:
-- - Structured data only
-- - Reporting
-- - Business Intelligence

-- Characteristics:
-- - Highly organized
-- - Optimized for analytics

------------------------------------------------------------
-- Approach 2: Data Lake
------------------------------------------------------------

-- Stores:
-- - Structured data
-- - Semi-structured data
-- - Unstructured data

-- Examples:
-- - Tables
-- - Logs
-- - Images
-- - Videos

-- Best for:
-- - Machine Learning
-- - Advanced Analytics

-- Problem:
-- Without governance:
-- Data Lake -> Data Swamp

------------------------------------------------------------
-- Approach 3: Data Lakehouse
------------------------------------------------------------

-- Combination of:

-- Data Lake:
-- - Flexibility
-- - Multiple data types

-- Data Warehouse:
-- - Organization
-- - Structure

-- Modern architecture:
-- Supports:
-- - BI
-- - Analytics
-- - ML
-- - AI

------------------------------------------------------------
-- Approach 4: Data Mesh
------------------------------------------------------------

-- Traditional:
-- Centralized data platform

-- Data Mesh:
-- Decentralized architecture

-- Each business domain:
-- - Owns data
-- - Builds data products
-- - Shares data with others

-- Goal:
-- Avoid centralized bottleneck

============================================================
-- DATA WAREHOUSE DESIGN APPROACHES
============================================================
-- Approach 1: Inmon Architecture
------------------------------------------------------------
-- Layers:

-- 1. Staging Layer
-- - Raw data landing area
-- - Data from source systems

-- 2. Enterprise Data Warehouse (EDW)
-- - Centralized warehouse
-- - Uses normalized model (3NF)
-- - Integrates multiple sources

-- 3. Data Marts
-- - Subject-specific data
-- - Customer, Sales, Products
-- - Used for reporting

-- 4. BI Tools
-- Example:
-- Power BI / Tableau

-- Flow:

Sources
   |
Staging
   |
Enterprise Data Warehouse
   |
Data Marts
   |
Reporting

------------------------------------------------------------
-- Approach 2: Simple Data Warehouse Approach
------------------------------------------------------------

-- Removes Enterprise Data Warehouse layer.
-- Flow:
Sources
   |
Staging
   |
Data Marts
   |
Reporting

-- Advantage:
-- - Faster development

-- Disadvantage:
-- - Data duplication
-- - Repeated transformations
-- - Difficult maintenance

-- Trade-off:
-- Speed vs Data consistency

------------------------------------------------------------
-- Approach 3: Data Vault Architecture
------------------------------------------------------------
-- Similar to Inmon but adds stronger standards.

-- Layers:
-- 1. Staging
-- Raw source data

-- 2. Data Vault
-- Raw Vault:
-- - Stores original data
-- - Historical tracking
-- Business Vault:
-- - Business rules
-- - Transformations

-- 3. Data Marts
-- Reporting layer

-- Benefit:
-- - Scalable
-- - Auditable
-- - Strong governance

------------------------------------------------------------
-- Approach 4: Medallion Architecture
------------------------------------------------------------
-- Modern and commonly used approach.

-- Three Layers:
------------------------------------------------------------
-- Bronze Layer
------------------------------------------------------------

-- Similar to staging layer.
-- Stores:
-- - Raw data
-- - Original format

-- Benefits:
-- - Traceability
-- - Debugging
-- - Data recovery

------------------------------------------------------------
-- Silver Layer
------------------------------------------------------------
-- Data processing layer.

-- Performs:
-- - Cleaning
-- - Standardization
-- - Transformations

-- Does NOT apply:
-- Business-specific rules

------------------------------------------------------------
-- Gold Layer
------------------------------------------------------------
-- Business-ready data layer.

-- Contains:
-- - Reporting datasets
-- - ML datasets
-- - AI datasets
-- - Data products

-- Used by:
-- - Analysts
-- - Business teams
-- - Applications

============================================================
-- KEY DECISION PROCESS
============================================================

-- Building Data Architecture:

Step 1:
-- Choose architecture type:
-- Data Warehouse
-- Data Lake
-- Lakehouse
-- Data Mesh

Step 2:
-- If Data Warehouse:
-- Choose implementation approach:

-- Inmon
-- Simple
-- Data Vault
-- Medallion

Step 3:
-- Design layers and data flow.

============================================================
-- PROJECT APPROACH
============================================================

-- Selected:
-- Architecture:
-- Data Warehouse

-- Design Pattern:
-- Medallion Architecture

-- Layers:

Sources
   |
Bronze
   |
Silver
   |
Gold
   |
BI / Analytics / ML

-- Goal:
-- Build scalable, maintainable, business-ready data platform.



