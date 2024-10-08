-- QUERIES WITH PARAM


-- 1. Query with a list parameter to find the products of a specific category

SELECT p.product_name, p.price, c.category_name

FROM Products p

JOIN Categories c ON p.category_id = c.category_id

WHERE c.category_name = &<name = "cat" type = "string"  list = "select category_name from Categories" default = "Computer Accessories" >


-- 2. Query with a date parameter to find orders within a date range

SELECT o.order_id, o.order_date, b.buyer_name, p.product_name

FROM Orders o

JOIN Buyers b ON o.buyer_id = b.buyer_id

JOIN include_products ip on ip.order_id = o.order_id

JOIN Products p ON ip.product_id = p.product_id

WHERE o.order_date BETWEEN &<name = "start_date" type = "date" hint = "the store exists form 1/1/23"> AND &<name = "end_date" type = "date" hint = "the store info updated until 1/1/25">;

-- 3. Query with a string parameter using LIKE for partial matching

SELECT s.seller_name,
       s.phone,
       s.address

FROM Sellers s

WHERE LOWER(s.seller_name) -- lower case for the name

LIKE LOWER(&<name = "name_pattern" hint = "write between %__%" default = "%sam%" type = "string">) ;
-- search for a specified pattern within a column



-- 4. Query with multiple parameters including a number of params.
--  return the reviews from certain date,rating and category


SELECT r.review_id,
       r.rating,
       r.comment_text,
       p.product_name
FROM Reviews r
JOIN Products p ON r.product_id = p.product_id

WHERE r.rating >= &<name = "min_rating" type = "INTEGER" hint = "number between 1-10" default = "8"> 
  AND r.review_date > &<name = "review_after_date" type = "date" hint = "1/1/2023 - 1/1/2025" default = "5/5/2024">
  AND p.category_id = &<name = "category_id" type = "INTEGER" hint = "number between 1-30" default = "1">
