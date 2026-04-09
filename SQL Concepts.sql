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
SELECT country, sum(score) as total_score_per_country from MyDatabase.dbo.customers
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

SELECT country, SUM(score) from MyDatabase.dbo.customers
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

-- Question: Change the score of customer with ID 6 to O
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
-- Same thing will happend if we do SUM(), MIN(), MAX() and COUNT() functions, they will ignore the NULL values
--! NOTE: Only one expection of the aggregate functions is COUNT(*) function, it will count all the rows including the NULL values, but if we do COUNT(column_name) then it will count only the non-NULL values in that column

-- If we do not want the NULL values to be ignored in the aggregation, then we can use ISNULL or COALESCE function to replace the NULL values with a specific value before doing the aggregation
SELECT id, score,
COALESCE(score,0) AS ScoreWithNullReplaced,
AVG(score) OVER()AS AverageScore1, -- Ignoring the NULL values in the score column and calculating the average score
AVG(COALESCE(score, 0)) OVER() AS AverageScore2 -- Considering the NULL values as 0 in the score column and calculating the average score
from MyDatabase.dbo.customers

--? Handlind NULL values in string concatenation and arithmetic operations
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
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score
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
The COUNT FUNCTION exceptes every datatype
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
AVG (Sales) OVER (PARTITION BY ProductID) AvgByProduct,
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
SELECT TOP 2 CustomerID,
SUM(Sales) AS TotalSales
FROM SalesDB.Sales.Orders
GROUP BY CustomerID
ORDER BY TotalSales ASC

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
-- Percent rank always has scale o to 1
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
-- And in the second databaase we can Use SET operators such as UNION to combine all the small tables into one big table

-- -- In order to export the data, divide the orders into 2 groups.
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
    WHEN prevMonth != 0 THEN ROUND((CAST((currentMonth - prevMonth) AS FLOAT) / prevMonth) *100, 2)
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






