ALTER TABLE include_products
ADD quantity INT ;

UPDATE include_products
SET quantity = FLOOR(DBMS_RANDOM.VALUE(1, 21));


--current stock
ALTER TABLE products
ADD stock INT ;

UPDATE products
SET stock = FLOOR(DBMS_RANDOM.VALUE(1, 30));
