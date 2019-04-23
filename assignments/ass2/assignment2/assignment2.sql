/*Exercises about Views on MGS Database
1. Create a view named product summary that includes for each product, the product code, product
name, the number of orders containing this product, and the total price after discount of this product
in these orders.*/

CREATE OR REPLACE VIEW product_summary AS
SELECT p.product_code, p.product_name, COUNT(p.product_id) as num_orders_in,
   (oi.item_price - oi.discount_amount) as actual_price
FROM order_items oi JOIN products p ON (p.product_id = oi.product_id)
GROUP BY p.product_code, p.product_name,(oi.item_price - oi.discount_amount) ;
/

SELECT * FROM product_summary;

/*2. Create a view named hot_product based on the view in Q1. This view includes the product code and
product name of products that were sold in at least 2 orders.*/

CREATE OR REPLACE VIEW hot_product AS
SELECT product_code, product_name 
FROM product_summary
WHERE (num_orders_in >= 2);

SELECT * FROM hot_product;

/*3. Write a query that prints the product code, product name of products that were sold in at least 2
orders. Write this query in 2 versions. One based on the view hot_product. The other version does not
use the view hot_product or product_summary.*/
SELECT product_code, product_name 
FROM hot_product;

SELECT p.product_code, p.product_name, COUNT(p.product_id) as num_orders_in,
   (oi.item_price - oi.discount_amount) as actual_price
FROM order_items oi JOIN products p ON (p.product_id = oi.product_id)
GROUP BY p.product_code, p.product_name,(oi.item_price - oi.discount_amount) 
HAVING (COUNT(p.product_id) >= 2);
/

/*4. In Lab 10, you created a view named customer_addresses. Write 2 SQL statements to update the
information about customer with id 1. Change the email address to new@gmail.com. Change the
street address to Suite 3, 1925 N. 12th Street. Which change is successful? Which is a failure? What
is the error?*/
--!customer address view from lab 10

CREATE OR REPLACE VIEW customer_address AS 
SELECT c.customer_id, c.email_address, c.last_name, c.first_name, a.line1, a.line2, a.city, a.state, a.zip_code
FROM customers c JOIN addresses a on (c.customer_id = a.customer_id)
                JOIN orders o on (o.ship_address_id = c.shipping_address_id AND a.address_id = c.billing_address_id)
ORDER BY c.last_name, c.first_name;

SELECT * FROM customer_address;

UPDATE customer.customer_address
SET email_address = 'new@gmail.com'
WHERE (customer_id = 1);

UPDATE customer_address
SET line1 = 'Suite 3, 1925 N. 12th Street'
WHERE (customer_id = 1);


/*Both changes were a failure due to the following error:SQL Error: ORA-01779: cannot modify a column which maps to a non key-preserved table
01779. 00000 -  "cannot modify a column which maps to a non key-preserved table"
*Cause:    An attempt was made to insert or update columns of a join view which
           map to a non-key-preserved table.
*Action:   Modify the underlying base tables directly.*/

/*Exercises about PL/SQL on MGS Database*/

/*5. Write a script that uses an anonymous block of PL/SQL code that creates a cursor for a result set that
consists of the product_name and list_price columns for each product with a list price that’s greater
than $700. The rows in this result set should be sorted in descending sequence by list price. Then, the
procedure should display a string variable that includes the product_name and list price for each
product so it looks something like this:
"Gibson SG","2517.00"|"Gibson Les Paul","1199.00"|
Here, each value is enclosed in double quotes ("), each column is separated by a comma (,) and each
row is separated by a pipe character (|).*/


CONNECT mgs/mgs;
SET SERVEROUTPUT ON;
DECLARE
    allProducts VARCHAR2(1024) := '';
    temp VARCHAR2(64) := '';
    CURSOR prods_cursor IS
        SELECT product_name, list_price
        FROM products
        WHERE list_price > 700
        ORDER BY list_price DESC;  
    product_row products%ROWTYPE;
BEGIN
    FOR product_row IN prods_cursor LOOP
        temp := '"' || product_row.product_name || '"' || ' , "' || TO_CHAR(product_row.list_price, '$9999.99') || '" | ';
        DBMS_OUTPUT.PUT(temp);
        allproducts := allproducts || temp;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(allProducts);
END;
/

/*6. Write a script that uses an anonymous block of PL/SQL code that attempts to insert a
new category named “Guitars” into the Categories table. If the insert is successful, the
procedure should display this message:
1 row was inserted.
If the update is unsuccessful, the procedure should display this message:
Row was not inserted - duplicate entry
*/

CONNECT mgs/mgs;
SET SERVEROUTPUT ON;
DECLARE
    pre Int;
    post Int;
BEGIN
    pre := sql%Rowcount;
    INSERT INTO categories  VALUES (12, 'Guitars');
    post := sql%Rowcount;
    DBMS_OUTPUT.PUT_LINE( 'pre = ' || pre);
    DBMS_OUTPUT.PUT_LINE( 'post = ' || post);
    IF pre != post THEN
        DBMS_OUTPUT.PUT_LINE('Values successfully inserted');
    END IF;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Attempted to insert data that already exists');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: unexpected error occured');
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    DBMS_OUTPUT.PUT_LINE('Values successfully inserted');
END;
/