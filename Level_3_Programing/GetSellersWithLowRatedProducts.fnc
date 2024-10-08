﻿--function that receives a rating as a parameter and returns a list of sellers
-- who have products with ratings below the given rating between the range of the param dates
-- refcursor ,exception


CREATE OR REPLACE FUNCTION GetSellersWithLowRatedProducts(
  p_rating IN NUMBER,
  p_start_date IN DATE,
  p_end_date IN DATE
) RETURN SYS_REFCURSOR IS
  v_sellers SYS_REFCURSOR;--ref
BEGIN
  
  IF p_rating < 1 OR p_rating > 5 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Invalid rating. Rating must be between 1 and 5.');
  ELSIF p_start_date > p_end_date THEN
    RAISE_APPLICATION_ERROR(-20003, 'Invalid date range. Start date must be before end date.');
  END IF;
  

  OPEN v_sellers FOR
    SELECT DISTINCT s.seller_id, se.seller_name, AVG(r.rating) OVER (PARTITION BY p.product_id) AS avg_rating -- הפוקנציה פרטישן למעשה מחלקת את התוצאה לקבוצות עבור כל
    -- חלק במקרה שלנו כל מוצר והפונקציה של הממוצע תחשב עבור כל מוצר את הדירוג שלו
    FROM Reviews r
    JOIN Products p ON r.product_id = p.product_id
    JOIN sell s ON p.product_id = s.product_id
    JOIN sellers se ON s.seller_id = se.seller_id
    WHERE r.rating < p_rating
      AND r.review_date BETWEEN p_start_date AND p_end_date;

  RETURN v_sellers; --refcurser return to the main function
EXCEPTION
 
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    RETURN NULL;
END GetSellersWithLowRatedProducts;
/
