/* 
1. Print the total number of orders and their total tax amount.
Use headings ORDER_COUNT, TOTAL_TAX in the query result.
*/
SELECT COUNT(DISTINCT orders.order_id) as ORDER_COUNT, SUM(DISTINCT orders.tax_amount) as TOTAL_TAX
FROM orders JOIN order_items ON (orders.order_id = order_items.order_id);


/*2. How many orders are paid by Visa cards, and what are the total tax amount of these
orders? Use a single query to get both answers.
Use headings VISA_ORDER_COUNT, VISA_TOTAL_TAX in the query result.
*/
SELECT COUNT(DISTINCT orders.ORDER_ID) as "VISA_ORDER_COUNT", SUM(DISTINCT orders.tax_amount) as "VISA_TOTAL_TAX"
FROM orders JOIN order_items ON (orders.order_id = order_items.order_id)
WHERE orders.card_type = 'Visa';

/*
3. For each type of credit cards, print the total number of orders paid by this card type, and
the total tax amount of these orders.
Use headings CARD_ORDER_COUNT, CARD_TOTAL_TAX in the query result.
*/

SELECT DISTINCT orders.card_type, COUNT(DISTINCT order_items.order_id) as CARD_ORDER_COUNT, SUM(DISTINCT orders.tax_amount) as CARD_TOTAL_TAX
FROM orders JOIN order_items ON (orders.order_id = order_items.order_id)
GROUP BY orders.card_type;

/*
4. Rewrite the query in Question 3 such that only credit cards with at least 2 orders are
printed.
Use headings HOT_CARD_ORDER_COUNT, HOT_CARD_TOTAL_TAX in the query result.
HINT: need to use HAVING clause.
*/
SELECT DISTINCT orders.card_type, COUNT(DISTINCT order_items.order_id) as CARD_ORDER_COUNT, SUM(DISTINCT orders.tax_amount) as CARD_TOTAL_TAX
FROM orders JOIN order_items ON (orders.order_id = order_items.order_id)
GROUP BY orders.card_type
HAVING (COUNT(DISTINCT order_items.order_id) > 2);

/*
5. Rewrite the query in Question 4 such that only orders dated in March 2012 are included in
the query result. In another word, for each type of credit cards with at least 2 orders dated
in March 2012 and paid by this card type, print March 2012 as the selection date, the count
and total tax amount of such orders for this credit card type.
Use headings SELECTION_DATE, HOT_CARD_ORDER_COUNT, HOT_CARD_TOTAL_TAX in
the query result.
HINT: need to add a constant value in SELECT clause, use a pattern for desired orders, and
use both WHERE clause and HAVING clause in the query.
*/
SELECT DISTINCT orders.card_type, 'March 2012' as SELECTION_DATE, COUNT(DISTINCT order_items.order_id) as HOT_CARD_ORDER_COUNT, SUM(DISTINCT orders.tax_amount) as HOT_CARD_TOTAL_TAX
FROM orders JOIN order_items ON (orders.order_id = order_items.order_id)
WHERE orders.order_date BETWEEN '28-FEB-2012' AND '01-APR-2012'             --used the dates before the specified range because mar 31st was not included in query
GROUP BY orders.card_type                                                   --I looked up the behavior of 'BETWEEN' and apparently it is supposed to be inclusive?
HAVING (COUNT(DISTINCT order_items.order_id) > 2);

/*
6. For each product category, print how many products are in this category, the highest listing
price of products in this category, and the lowest listing price of products in this category.
Use headings CATEGORY_NAME, PRODUCT_COUNT, HIGHEST_LISTING, LOWEST_LISTING in
the query result.
HINT: need to use a JOIN and GROUP BY clause in your summary query.
*/

SELECT categories.category_name as CATEGORY_NAME, COUNT(products.product_id) as PRODUCT_COUNT, 
    MAX(products.list_price) as HIGHEST_LISTING, MIN(products.list_price) as LOWEST_LISTING
FROM products JOIN categories ON (products.category_id = categories.category_id)
GROUP BY categories.category_name;

/*
7. Rewrite the query in Question 6 such that only products with listing prices more than $300
are included in the query result. In another word, for each product category, print how
many products with listing prices more than $300 are in this category, the highest listing of
such products, and the lowest listing of such products in this category.
Use headings CATEGORY_NAME, PRODUCT_COUNT_OVER$300,
HIGHEST_LISTING_OVER$300, LOWEST_LISTING_OVER$300 in the query result.
HINT: think about which clause to add: a WHERE clause or HAVING clause?
*/
SELECT categories.category_name as CATEGORY_NAME, COUNT(products.product_id) as "PRODUCT_COUNT_OVER$300",
    MAX(products.list_price) as "HIGHEST_LISTING_OVER$300", MIN(products.list_price) as "LOWEST_LISTING_OVER$300"
FROM products JOIN categories ON (products.category_id = categories.category_id)
WHERE (products.list_price > 300)
GROUP BY categories.category_name;



/*
8. Rewrite the query in Question 6 such that only categories with at least 3 products are
included in the query result. In another word, for each category with at least 3 products, 
print how many products are in this category, the highest listing of products in this
category, and the lowest listing of products in this category.
Use headings CATEGORY_NAME, HOT_CAT_PRODUCT_COUNT,
HOT_CAT_HIGHEST_LISTING, HOT_CAT_LOWEST_LISTING in the query result.
HINT: think about which clause to add: a WHERE clause or HAVING clause?
*/

SELECT categories.category_name as CATEGORY_NAME, COUNT(products.product_id) as HOT_CAT_PRODUCT_COUNT, 
    MAX(products.list_price) as HOT_CAT_HIGHEST_LISTING, MIN(products.list_price) as HOT_CAT_LOWEST_LISTING
FROM products JOIN categories ON (products.category_id = categories.category_id)
GROUP BY categories.category_name
HAVING (COUNT(DISTINCT products.product_id) > 3);