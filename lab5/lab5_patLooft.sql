/*
Print the product code, name, and discount percentage of each product that has the same
discount percentage as another product. Do not print a product more than once. Sort the
query result in the increasing order of product code.
HINT: need to use a self join.
*/
SELECT DISTINCT p1.product_code, p1.product_name, p1.discount_percent
FROM products p1 JOIN products p2 ON 
    (p1.discount_percent = p2.discount_percent) AND  
    (p1.product_name != p2.product_name)
ORDER BY p1.product_code; 


/*
For each category that has at least one product, print its id, name, and the id and name of
each product in that category.
Sort the result in the increasing order of category id.
HINT: need to use an inner join.
*/

SELECT products.product_id, products.product_name, categories.category_name, products.category_id
FROM products INNER JOIN categories ON (categories.category_id = products.category_id)
ORDER BY categories.category_id ASC;


/*
For each product category, print its id, name, and the id and name of each product in that
category. Include categories without any product in the query result.
Sort the result in the increasing order of category id.
HINT: need to use an outer join
*/
SELECT categories.category_id, categories.category_name, products.product_id, products.product_name
FROM categories LEFT JOIN products ON (categories.category_id = products.category_id)
ORDER BY categories.category_id ASC;


/*
Print the id and name of each category to which no product currently belongs. Sort the
result in the increasing order of category id.
HINT: need to use an outer join.
*/
SELECT categories.category_id, categories.category_name
FROM categories
    LEFT JOIN products  ON (categories.category_id = products.category_id)
WHERE (products.category_id IS NULL)
ORDER BY categories.category_id ASC;

/*
Print the id, first name, and last name of each customer who has a gmail account and uses
one address for shipping and billing. Sort the result in increasing order of customer id.
HINT: need to use a SQL set operator.
*/
--I didn't use a set operator because it is faster to do a single query then use the union operator on two seperate queries

SELECT customer_id, first_name , last_name 
FROM customers
WHERE (customers.email_address LIKE '%gmail%') AND (customers.shipping_address_id = customers.billing_address_id)
ORDER BY customer_id ASC;


/*. Print the id, first name, and last name of each customer who uses one address for shipping
and billing, but does not have a gmail account. Sort the result in increasing order of
customer id.
HINT: need to use a SQL set operator
*/
--I didn't use a set operator because it is faster to do a single query then use the union operator on two seperate queries


SELECT customer_id, first_name, last_name 
FROM customers
WHERE (customers.email_address NOT LIKE '%gmail%') AND (customers.shipping_address_id = customers.billing_address_id)
ORDER BY customer_id ASC;

--INTERSECT
/*
Print the id, first name, and last name of each customer who has a gmail account or uses
one address for shipping and billing. Sort the result in increasing order of customer id.
HINT: need to use a SQL set operator.
*/
--I didn't use a set operator because it is faster to do a single query then use the union operator on two seperate queries

SELECT customer_id, first_name, last_name  
FROM customers
WHERE (customers.email_address LIKE '%gmail%') OR (customers.shipping_address_id = customers.billing_address_id)
ORDER BY customer_id ASC;

/*
Print the order id, customer id, shipping status, and order date of each order. If an order has
a specific ship date, the shipping status is Shipped. Otherwise, the shipping status is Not
Shipped. Sort the result in increasing order of order date.
HINT: need to use a SQL set operator.
*/

SELECT orders.order_id, orders.customer_id, 'Shipped' as SHIP_STATUS, orders.order_date
FROM orders
WHERE (orders.ship_date IS NOT NULL)
    UNION
SELECT orders.order_id, orders.customer_id, 'Not Shipped' as SHIP_STATUS, orders.order_date
FROM orders
WHERE (orders.ship_date IS NULL)
ORDER BY order_date ASC;