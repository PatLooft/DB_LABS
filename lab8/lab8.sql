/*
PAT LOOFT
CIS 4331-001
LAB 8
*/
/*
1. Write a SELECT statement that returns the same result set as this SELECT statement, but
don’t use a join. Instead, use a subquery in a WHERE clause that uses the IN keyword.
SELECT DISTINCT category_name
FROM categories c JOIN products p
 ON c.category_id = p.category_id
ORDER BY category_name;
*/

SELECT DISTINCT category_name
FROM categories
WHERE category_id in (SELECT category_id FROM products)
ORDER BY category_name;

/*
2. Print the product name and actual price of products whose actual price is above the
average actual price of all products. The actual price is the price after the discount.
Sort the result such that the product with the highest actual price appears first.*/
SELECT product_name, (list_price * ((100 - discount_percent) / 100)) AS actual_price
FROM products
WHERE (SELECT AVG(list_price * ((100 - discount_percent) / 100))FROM products) < (list_price * ((100 - discount_percent) / 100))
ORDER BY actual_price DESC;

/*
3. Print the ids and names of all categories that currently don’t have any product.
You must use NOT IN and a subquery.*/
SELECT category_id, category_name
FROM categories
WHERE category_id NOT IN (SELECT category_id FROM products);

/*
4. Print the ids, codes, product names, and actual prices of the top 3 products that are most
expensive based on the actual price, which is the price after the discount.
You MUST use a subquery in the FROM clause in your answer.
*/
SELECT *
FROM (SELECT product_code, product_id, product_name, (list_price * ((100 - discount_percent) / 100)) AS actual_price FROM products ORDER BY actual_price DESC)
WHERE (ROWNUM <= 3);

/*
5. Print the ids, codes, product names, category names, and actual prices of the top 3
products that are most expensive based on the actual price, which is the price after the
discount.
You MUST use a subquery in the FROM clause in your answer.*/
SELECT *
FROM 
    (   SELECT p.product_code, p.product_id, p.product_name, 
            (p.list_price * ((100 - p.discount_percent) / 100)) AS actual_price, c.category_name 
        FROM products p JOIN categories c ON (c.category_id = p.category_id) 
        ORDER BY actual_price DESC)
WHERE (ROWNUM <= 3);

/*
6. Print the category ids, product counts of the top 3 categories with the most products.
You MUST use a subquery in the FROM clause in your answer.
*/
SELECT *
FROM (SELECT p.category_id, COUNT(DISTINCT p.product_id) AS "PRODUCT_COUNT" FROM products p GROUP BY p.category_id )
WHERE ROWNUM <= 3;

/*
7. Print the name and discount percent of each product that has a unique discount percent. In
other words, don’t include products that have the same discount percent as another
product.
Sort the results by the product_name column in increasing sequence.
HINT: In the subquery, count the number of products in each discount percent and return
those with product count being 1.*/
SELECT product_name, discount_percent
FROM products JOIN (
    SELECT discount_percent
    FROM products
    GROUP BY discount_percent
    HAVING COUNT(discount_percent) <= 1) 
    USING (discount_percent)
ORDER BY product_name;



/*
8. Write a query that prints email_address, order_id, and the order total for each customer.
To do this, you can group the result set by the email_address and order_id columns.*/
/*disregard this query
SELECT customers.email_address, SUM((order_items.item_price-order_items.discount_amount) * order_items.quantity) as "ORDER_TOTAL"
FROM orders JOIN customers ON (orders.customer_id = customers.customer_id)
            JOIN order_items ON (order_items.order_id = orders.order_id)
GROUP BY customers.email_address;*/


SELECT  customers.email_address, order_items.order_id, SUM((order_items.item_price-order_items.discount_amount) * order_items.quantity) as "ORDER_TOTAL"
FROM orders JOIN order_items on (orders.order_id = order_items.order_id) 
            JOIN customers on (orders.customer_id = customers.customer_id)
GROUP BY customers.email_address, order_items.order_id;
/*
In addition, you must calculate the order total from the columns in the Order_Items table.

Write a second query that uses the first query in its FROM clause. The main query should
return the customer’s email address and the largest order for that customer. To do this, you
can group the result set by the email_address
*/


SELECT DISTINCT sq.email, MAX(ORDER_TOTAL)
FROM customers JOIN (SELECT  customers.email_address as email, order_items.order_id, SUM((order_items.item_price-order_items.discount_amount) * order_items.quantity) as "ORDER_TOTAL"
    FROM orders JOIN order_items on (orders.order_id = order_items.order_id) 
            JOIN customers on (orders.customer_id = customers.customer_id)
    GROUP BY customers.email_address, order_items.order_id) sq ON (customers.email_address = sq.email)
GROUP BY sq.email, sq.order_total;