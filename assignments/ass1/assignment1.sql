/*
PAT LOOFT
CIS 4331-001
ASSIGNMENT 1
DUE 03/29/2019
/*
Objective: This assignment is used to help you to understand and use DDL statements that work with table definitions.

Questions:

1) Create the following tables using the user EX. Use meaningful data types for columns.
Table USERS: 
Columns: user_id, email_address, first_name, last_name
Primary Key: user_id

Table PRODUCTS:
Columns: product_id, product_name
Primary Key: product_id

Table DOWNLOADS:
Columns: download_id, user_id, download_date, filename, product_id
Primary Key: download_id
User_id references user_id in table USERS.
Product_id references product_id in table PRODUCTS.*/
CREATE TABLE USERS
(
    user_id INT PRIMARY KEY, email_address VARCHAR2(48), first_name VARCHAR2(24) NOT NULL, last_name VARCHAR2(24) NOT NULL
);

CREATE TABLE products
(
    product_id INT PRIMARY KEY, product_name VARCHAR2(24)
);

CREATE TABLE downloads
(
    download_id INT PRIMARY KEY, user_id INT REFERENCES users (user_id), product_id INT REFERENCES products (product_id)
);

DROP TABLE downloads;
DROP TABLE products;
DROP TABLE users;
/*2) Write an ALTER TABLE statement that adds two new columns to the Products 
table created in Question 1. Add one column named product_price for product 
price that provides for three digits to the left of the decimal point and two to
the right. This column should have a default value of 9.99.

Add one column named date_added for the date and time that the product was added to the database.*/

ALTER TABLE products
ADD product_price DECIMAL(5, 2) DEFAULT 9.99
ADD date_added DATE DEFAULT SYSDATE;

/*3) Write an ALTER TABLE statement that modifies the USERS table created in Question 1 so the first_name column can store NULL values and can store a maximum of 20 characters.
Submission:*/

ALTER TABLE users
MODIFY first_name VARCHAR(20) NULL;