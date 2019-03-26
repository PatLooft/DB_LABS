/*Exercises about Views on MGS Database
1. Create a view named customer_addresses that shows the shipping and billing addresses for each
customer.
This view should return these columns from the Customers table: customer_id, email_address,
last_name and first_name.
This view should return these columns from the Addresses table: bill_line1, bill_line2, bill_city,
bill_state, bill_zip, ship_line1, ship_line2, ship_city, ship_state, and ship_zip.
The rows in this view should be sorted by the last_name and then first_name columns.*/

CREATE OR REPLACE VIEW customer_address AS 
SELECT c.customer_id, c.email_address, c.last_name, c.first_name,
    a.line1, a.line2, a.city, a.state, a.zip_code
FROM customers c JOIN addresses a on (c.customer_id = a.customer_id)
ORDER BY c.last_name, c.first_name;

/*2. Write a SELECT statement that returns these columns from the customer_addresses view that you
created in exercise 1: customer_id, last_name, first_name, bill_line1.*/

SELECT customer_id, last_name, first_name, line1 FROM customer_address;

/*3. Create a view named order_item_products that returns columns from the Orders, Order_Items, and
Products tables.
This view should return these columns from the Orders table: order_id, order_date, tax_amount, and
ship_date.
This view should return these columns from the Order_Items table: item_price, discount_amount,
final_price (the discount amount subtracted from the item price), quantity, and item_total (the
calculated total for the item).
This view should return the product_name column from the Products table.
Exercises about PL/SQL on MGS Database*/

CREATE OR REPLACE VIEW order_item_products AS
SELECT o.order_id, o.order_date, o.tax_amount, o.ship_date,
    oi.item_price, oi.discount_amount, (oi.item_price - oi.discount_amount) as final_price,
    oi.quantity, ((oi.item_price - oi.discount_amount) +  + o.tax_amount) as item_total
FROM order_items oi JOIN orders o ON (o.order_id = oi.order_id)
                    JOIN products p ON (oi.product_id = p.product_id);
                    
DROP VIEW order_item_products;
                    
SELECT * FROM order_item_products;

/*1. Write a script that uses an anonymous block of PL/SQL code to declare a variable and set it to the
count of all products in the Products table. If the count is greater than or equal to 7, the block should
display a message that says, “The number of products is greater than or equal to 7”. Otherwise, it
should say, “The number of products is less than 7”.*/

CONNECT mgs/mgs;
SET SERVEROUTPUT ON;
DECLARE 
    counting Int;
BEGIN 
    SELECT COUNT(product_id) 
    INTO counting 
    FROM products;
    IF counting >= 7 THEN
        DBMS_OUTPUT.PUT_LINE('COUNT IS GREATER THAN OR EQUAL TO 7');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('COUNT IS LESS THAN 7');
    END IF;
END; 
/
/*2. Write a script that uses an anonymous block of PL/SQL code to declare two variables to store 
(1) the count of all of the products in the Products table and 
(2) the average list price for those products.
If the product count is greater than or equal to 7, the stored procedure should display a result set that
displays the values of both variables. Otherwise, the procedure should display a result set that
displays a message that says, “The number of products is less than 7”.*/

CONNECT mgs/mgs;
SET SERVEROUTPUT ON;
DECLARE 
    counting Int;
    aver INT;
BEGIN 
    SELECT COUNT(product_id) INTO counting FROM products;
    SELECT AVG(list_price)INTO aver FROM products;
    IF counting >= 7 THEN
        DBMS_OUTPUT.PUT('Count: ' || counting);
        DBMS_OUTPUT.PUT('Average: ' || aver);
    ELSE 
        DBMS_OUTPUT.PUT_LINE('COUNT IS LESS THAN 7');
    END IF;
END; 
/


/*3. Write a script that uses an anonymous block of PL/SQL code that calculates the
common factors between 10 and 20. To find a common factor, you can use the modulo
function (MOD) to check whether a number can be evenly divided into both numbers.
Then, this procedure should display a string that displays the common factors like this:
Common factors of 10 and 20: 1 2 5
*/


SET SERVEROUTPUT ON;
BEGIN
DBMS_OUTPUT.PUT_LINE('Common factors of 10 and 20:');
FOR i IN 1..9 LOOP
    IF (MOD(10, i) = 0) AND (MOD(20, i) = 0) THEN
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(i)); 
    END IF;
END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
END;