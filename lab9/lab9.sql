/*
-Pat Looft
-CIS 4331-001 
-Lab 09
-Due: 03/26/2019

Exercises on Data Modification Language on MGS Database
NOTE:
To test whether a table has been modified correctly as you do these exercises, you can write
and run an appropriate SELECT statement, as I showed you in the related lectures.*/

/*1. Write an INSERT statement that adds this row to the Categories table:
category_id: 4
category_name: Brass
Code the INSERT statement as part of a script so Oracle commits the change.*/

/*Could not add the above values, as keyboards are already signed to 
category id = 4, and since this value is the primary key it must be unique*/
INSERT INTO categories
VALUES (5, 'Brass');

/*validating*/
SELECT * 
FROM categories;


/*2. Write an UPDATE statement that modifies the row you just added to the Categories table.
This statement should change the product_name column to “Woodwinds”, and it should
use the category_id column to identify the row.*/
UPDATE categories
SET category_name = 'Woodwinds'
WHERE category_id = 5;

/*validating*/
SELECT * 
FROM categories;

/*3. Write a DELETE statement that deletes the row you added to the Categories table in
exercise 1. This statement should use the category_id column to identify the row.*/

DELETE FROM categories
WHERE category_id = 5;

/*validating*/
SELECT * 
FROM categories;

/*4. Write an INSERT statement that adds this row to the Products table:
product_id: 11
category_id: 4
product_code: dgx_640
product_name: Yamaha DGX 640 88-Key Digital Piano
description: Long description to come.
list_price: 799.99
discount_percent: 0
date_added: Today’s date/time.
You must use a column list for this statement.*/
INSERT INTO products
VALUES (11, 5, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano', 'what description?', 799.99, 0, CURRENT_DATE);

SELECT * FROM products;

/*5. Write an UPDATE statement that modifies the product you added in exercise 4. This
statement should change the discount_percent column from 0% to 35%.*/
UPDATE products
SET discount_percent = 35
WHERE product_id = 11;

SELECT product_id, discount_percent FROM products;

/*6. Write a DELETE statement that deletes the row that you added to the Categories table in
exercise 1. When you execute this statement, it will produce an error since the category has
related rows in the Products table.
To fix that, precede the DELETE statement with another DELETE statement that deletes all
products in this category.
NOTE: to code two or more statements in a script, you must end each statement with a
semicolon.
You MUST submit 2 DELETE statements for this question.*/

DELETE FROM products
WHERE (category_id = 5);

DELETE FROM categories
WHERE category_id = 5;

SELECT * FROM products;

/*7. Write an INSERT statement that adds this row to the Customers table:
customer_id: 9
email_address: rick@raven.com
password: sesame
first_name: Rick
last_name: Raven
You must use a column list for this statement.*/

INSERT INTO customers (customer_id, email_address, password, first_name, last_name)
VALUES (9, 'rick@raven.com', 'sesame', 'Rick', 'Raven');

SELECT * FROM customers;

/*8. Write an UPDATE statement that modifies the Customers table. Change the password
column to “secret” for the customer with an email address of rick@raven.com.*/
UPDATE customers
SET password = 'secret'
WHERE email_address = 'rick@raven.com';

SELECT * FROM customers;

/*9. Write an UPDATE statement that modifies the Customers table. Change the password
column to “reset” for every customer in the table.*/
UPDATE customers
SET password = 'reset';

SELECT * FROM customers;

/*10. Open the script named create_mgs_tables.sql and run this script. That should restore the
data that’s in the database.*/
--! I ran it I promise