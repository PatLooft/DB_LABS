/*. Print the IDs, street addresses (including apartment number and suite number), cities,
states, and phone numbers of customers whose street addresses contain a word ending in
“wood”. Sort the query result in the increasing order of state, then city.
HINT: need to use a pattern.
*/
SELECT customers.customer_id, addresses.line1, addresses.line2, addresses.city, addresses.state, addresses.phone 
FROM customers JOIN addresses ON customers.customer_id  = addresses.customer_id
WHERE addresses.line1 LIKE '%wood %'
ORDER BY addresses.state, addresses.city ASC;


/*
Print the first names, last names, and email addresses of customers who have r as the third
letter in their first names. Sort the result in the increasing order of first name.
HINT: need to use a pattern
*/
SELECT first_name, last_name, email_address
FROM customers
WHERE first_name LIKE '__r%'
ORDER BY first_name ASC;
/*
Print the ids, prices before the discount, and discount amounts of products that were
ordered. If a product was ordered more than once, print its information only once. Sort the
result in the decreasing order of product prices.
HINT: need to sort the query result by date values
*/--this needs fixing

SELECT DISTINCT product_id, item_price, discount_amount
FROM order_items
WHERE quantity <= 1
ORDER BY item_price DESC;

/*
Print the names, listing prices, and category names of all products in the increasing order of
category name and product name.
*/
SELECT products.product_name, products.list_price, categories.category_name
FROM products JOIN categories ON (products.category_id = categories.category_id)
ORDER BY categories.category_name, products.product_name ASC;

/*
Print the first name, last name, and all the addresses of the customer whose email address
is heatheresway@mac.com. Print all components of an address: street address (including
apartment number and suite number), city, state, and zipcode.
NOTE: Each address can be for shipping only, billing only, or for both shipping and billing.
*/
SELECT customers.first_name, customers.last_name, addresses.line1, addresses.line2, addresses.city, addresses.state, addresses.zip_code
FROM customers JOIN addresses ON (customers.customer_id  = addresses.customer_id)
WHERE customers.email_address = 'heatheresway@mac.com'; 
/*
Print the first names, last names, billing addresses of all customers in the increasing order of
state first, then city. Print all components of an address: street address (including
apartment number and suite number), city, state, and zipcode.
*/
SELECT customers.first_name, customers.last_name, addresses.line1, addresses.line2, addresses.city, addresses.state, addresses.zip_code
FROM customers JOIN addresses ON (customers.customer_id  = addresses.customer_id)
WHERE customers.billing_address_id = addresses.address_id
ORDER BY addresses.state, addresses.city;
/*
Print all customers’ first names, last names, the dates when they placed their orders, and
the dates when their orders were shipped. Print the heading for the dates as SHIP_DATE,
ORDER_DATE. Print all dates in the following format:
03/31/2012
*/
SELECT customers.first_name, customers.last_name, TO_CHAR((orders.order_date), 'MM/DD/YYYY') as ORDER_DATE, TO_CHAR((orders.ship_date), 'MM/DD/YYYY') as SHIP_DATE
FROM customers JOIN orders on (customers.customer_id = orders.customer_id);
/*
Print customers’ email addresses, the dates when their orders were shipped, the product id
and the actual price (after the discount) of each product they ordered. Print the heading for
the actual price as ACTURAL_PRICE.
*/

SELECT customers.email_address, orders.ship_date, order_items.product_id, (order_items.item_price - order_items.discount_amount) as ACTUAL_PRICE
FROM orders JOIN customers ON (customers.customer_id = orders.customer_id) 
     JOIN order_items ON (orders.order_id = order_items.order_id);