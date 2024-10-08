CREATE OR REPLACE FUNCTION UpdatePricesByCategory (
  startDate IN DATE,
  categoryId IN INT
) RETURN VARCHAR2 IS
  CURSOR productCursor IS
    SELECT product_id, price
    FROM Products
    WHERE category_id = categoryId AND available_date >= startDate;

  productRecord productCursor%ROWTYPE;
  updatedCount INT := 0;

BEGIN
  -- Check if any products were updated
  IF categoryId < 0 THEN
    RAISE_APPLICATION_ERROR(-20004, 'invalid category');
  END IF;
  
  -- Open the cursor
  OPEN productCursor;

  -- Loop through each product
  LOOP
    FETCH productCursor INTO productRecord;
    EXIT WHEN productCursor%NOTFOUND;

    -- Update the product price by 5%
    UPDATE Products
    SET price = price * 1.05
    WHERE product_id = productRecord.product_id;

    -- Increment the count of updated products
    updatedCount := updatedCount + 1;
  END LOOP;

  -- Close the cursor
  CLOSE productCursor;

  -- Check if any products were updated
  IF updatedCount = 0 THEN
    RAISE_APPLICATION_ERROR(-20004, 'No products found for the given category and date range.');
  END IF;

  -- Return a success message with the number of updated products
  RETURN 'Updated ' || updatedCount || ' products successfully.';

EXCEPTION
  WHEN OTHERS THEN
    -- Handle other unexpected errors
    RAISE_APPLICATION_ERROR(-20003, 'An unexpected error occurred: ' || SQLERRM);
END UpdatePricesByCategory;
/
