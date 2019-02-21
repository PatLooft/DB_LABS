/*Pat Looft 
* CIS 4331-001 
* Lab 3
* 01/29/2019
*/

/*Print the product code, product name, listing price, and discount percentage of all products
in the increasing order of discount percentage first, then decreasing order of listing prices.
NOTE: remember to build and test a statement one clause at a time. First build and test
SELECT and FROM clauses, then add ORDER BY clause
*/
SELECT product_code, product_name, list_price, discount_percent
FROM products
ORDER BY discount_percent;

SELECT product_code, product_name, list_price, discount_percent
FROM products
ORDER BY discount_percent DESC;

/*
Print the full names of all customers whose last names begins with letters from L to Y in the
increasing order of last names.
Display the query result in the following format:
Heading of the query result: Customer Names
Data format: last name, then a comma and a space, then first name, like below:
 Trump, Donald
null*/

SELECT last_name ||', '||first_name
FROM customers
WHERE last_name > 'L' AND last_name < 'Y'
ORDER BY last_name;

/*Print the product names, listing prices, and dates when the products were added for
products whose listing prices are higher than $200 and lower than $800. Print the products
added last (i.e. latest product) first, the products added earliest (i.e. oldest product) last.
HINT: need to sort the query result by date values
*/

SELECT product_name, list_price, date_added
FROM products
WHERE list_price > 200 AND list_price < 800
ORDER BY date_added DESC;

/*Print at most 5 products’ names, listing prices, the actual prices after discounts in the
decreasing order of the actual prices in the following format. These 5 products are NOT
necessarily the 5 most expensive products.
HINT: need to sort the query result by an expression, and use a pseudo-column to limit
the number of rows in the query result.

Product Info
--------------------------------------------
Gibson SGwas $2517, now is $1208.16
Gibson Les Paulwas $1199, now is $839.3
……
*/

SELECT product_name ||' was $' || TO_CHAR(list_price) || ', now is $' || TO_CHAR((list_price - (list_price * (discount_percent/100))))
FROM products
WHERE ROWNUM <= 5;

/*Print the item ids, item prices before discount, item discount amount, total item prices
before discount, and the total discount amounts of the item for only items having the total
discount amount more than $600.
Display the total item price as TOTAL_BEFORE_DISCOUNT, the total discount amounts as
TOTAL_DISCOUNT_AMOUNT.
Sort the query result in the decreasing order of the total discount amount
*/

SELECT list_price as TOTAL_BEFORE_DISCOUNT, (list_price - (list_price * (discount_percent/100))) as TOTAL_AFTER_DISCOUNT
FROM products
WHERE ((list_price * (discount_percent/100))) > 600
ORDER BY (list_price * (discount_percent/100)) DESC;

/*Print the order ids, customer ids, dates when orders were placed, and the shipping amounts
for all orders whose shipping dates are unknown.
*/

SELECT order_id, customer_id, order_date, ship_amount
FROM orders
WHERE ship_date IS NOT NULL;

/*Print a greeting message like below. You must print the heading as is and the date when the
query is executed.
GREETING
------------------------
Hello! Today is 29-JAN-19
*/

SELECT 'GREETING' || chr(13) ||'------------------------ Hello! Today is ' || TO_CHAR(CURRENT_DATE)
FROM dual;


/*Given an ipad at $650, the tax rate 8%, print the price before tax, tax rate, tax amount, the
price after tax like below.
PRICE_BEFORE_TAX TAX_RATE TAX_AMOUNT PRICE_AFTER_TAX
-----------------------------------------------------------
650 0.08 52 702
*/

SELECT 650 AS PRICE_BEFORE_TAX, 0.08 AS TAX_RATE, (650 * .08) AS TAX_AMOUNT, 650 + (650 * .08) AS PRICE_AFTER_TAX
FROM DUAL;