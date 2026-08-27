-- amazon.db schema and "amazon_org" table info:
.schema

--Total number of records:
SELECT COUNT(*) As "total_rows"
  FROM "amazon_org";

--Total number of columns:
SELECT COUNT(*) AS "total_columns"
   FROM Pragma_table_info("amazon_org");

-- Sample records:
SELECT * FROM "amazon_org"
    LIMIT 20;

-- Find blanks:
SELECT
 SUM(CASE WHEN TRIM("user_id")='' THEN 1 ELSE 0 END) AS "user_id_blanks",
 SUM(CASE WHEN TRIM("product_id")='' THEN 1 ELSE 0 END) AS "product_id_blanks",
 SUM(CASE WHEN TRIM("category")='' THEN 1 ELSE 0 END) AS "category_blanks",
 SUM(CASE WHEN TRIM("subcategory") ='' THEN 1 ELSE 0 END) AS "subcategory_blanks",
 SUM(CASE WHEN TRIM("brand")='' THEN 1 ELSE 0 END) AS "brand_blanks",
 SUM(CASE WHEN TRIM("price")='' THEN 1 ELSE 0 END) AS "price_blanks",
 SUM(CASE WHEN TRIM("discount")='' THEN 1 ELSE 0 END) AS "discount_blanks",
 SUM(CASE WHEN TRIM("final_price")='' THEN 1 ELSE 0 END) AS  "final_price_blanks",
 SUM(CASE WHEN TRIM("review_count")='' THEN 1 ELSE 0 END) AS "review_count_blanks",
 SUM(CASE WHEN TRIM("rating")='' THEN 1 ELSE 0 END) AS "rating_blanks",
 SUM(CASE WHEN TRIM("stock")='' THEN 1 ELSE 0 END) AS "stock_blanks",
 SUM(CASE WHEN TRIM("seller_id")='' THEN 1 ELSE 0 END) AS "seller_id_blanks",
 SUM(CASE WHEN TRIM("seller_rating")='' THEN 1 ELSE 0 END) AS  "seller_rating_blanks",
 SUM(CASE WHEN TRIM("purchase_date")='' THEN 1 ELSE 0 END) AS "purchase_date_blanks",
 SUM(CASE WHEN TRIM("shipping_time_days")='' THEN 1 ELSE 0 END) AS "shipping_time_days_blanks",
 SUM(CASE WHEN TRIM("location")='' THEN 1 ELSE 0 END) AS "location_blanks",
 SUM(CASE WHEN TRIM("order_device")='' THEN 1 ELSE 0 END) AS "order_device_blanks",
 SUM(CASE WHEN TRIM("payment_method")='' THEN 1 ELSE 0 END) AS "payment_method_blanks",
 SUM(CASE WHEN TRIM("is_returned")='' THEN 1 ELSE 0 END) AS "is_returned_blanks",
 SUM(CASE WHEN TRIM("delivery_status")='' THEN 1 ELSE 0 END) AS "delivery_status_blanks"
 FROM "amazon_org";

 -- FIND NULLS:
 SELECT
 SUM(CASE WHEN "user_id" IS NULL THEN 1 ELSE 0 END) AS "user_id_nulls",
 SUM(CASE WHEN "product_id" IS NULL THEN 1 ELSE 0 END) AS "product_id_nulls",
 SUM(CASE WHEN "category" IS NULL THEN 1 ELSE 0 END) AS "category_nulls",
 SUM(CASE WHEN "subcategory" IS NULL THEN 1 ELSE 0 END) AS "subcategory_nulls",
 SUM(CASE WHEN "brand" IS NULL THEN 1 ELSE 0 END) AS "brand_nulls",
 SUM(CASE WHEN "price" IS NULL THEN 1 ELSE 0 END) AS "price_nulls",
 SUM(CASE WHEN "discount" IS NULL THEN 1 ELSE 0 END) AS "discount_nulls",
 SUM(CASE WHEN  "final_price" IS NULL THEN 1 ELSE 0 END) AS  "final_price_nulls",
 SUM(CASE WHEN "review_count" IS NULL THEN 1 ELSE 0 END) AS "review_count_nulls",
 SUM(CASE WHEN "rating" IS NULL THEN 1 ELSE 0 END) AS "rating_nulls",
 SUM(CASE WHEN "stock" IS NULL THEN 1 ELSE 0 END) AS "stock_nulls",
 SUM(CASE WHEN "seller_id" IS NULL THEN 1 ELSE 0 END) AS "seller_id_nulls",
 SUM(CASE WHEN  "seller_rating" IS NULL THEN 1 ELSE 0 END) AS  "seller_rating_nulls",
 SUM(CASE WHEN "purchase_date" IS NULL THEN 1 ELSE 0 END) AS "purchase_date_nulls",
 SUM(CASE WHEN "shipping_time_days" IS NULL THEN 1 ELSE 0 END) AS "shipping_time_days_nulls",
 SUM(CASE WHEN "location" IS NULL THEN 1 ELSE 0 END) AS "location_nulls",
 SUM(CASE WHEN "order_device" IS NULL THEN 1 ELSE 0 END) AS "order_device_nulls",
 SUM(CASE WHEN "payment_method" IS NULL THEN 1 ELSE 0 END) AS "payment_method_nulls",
 SUM(CASE WHEN "is_returned" IS NULL THEN 1 ELSE 0 END) AS "is_returned_nulls",
 SUM(CASE WHEN "delivery_status" IS NULL THEN 1 ELSE 0 END) AS "delivery_status_nulls"
 FROM "amazon_org";

--Find duplicates
SELECT * , COUNT (*) AS "duplicates"
FROM "amazon_org"
GROUP BY "user_id",
 "product_id",
 "category",
 "subcategory",
 "brand",
  "price",
 "discount",
 "final_price",
  "review_count",
 "rating",
 "stock",
 "seller_id",
  "seller_rating",
 "purchase_date",
 "shipping_time_days",
 "location",
 "order_device",
 "payment_method",
 "is_returned",
 "delivery_status"
 HAVING COUNT(*)>1;

--Distinct product_id count:
SELECT COUNT(DISTINCT("product_id"))
FROM "amazon_org";

-- Distinct categories:
SELECT DISTINCT("category")
FROM "amazon_org";

-- Finding subcategory for Electronics:
SELECT DISTINCT("subcategory") As "subcat_for_electronics"
   FROM "amazon_org"
   WHERE "category"='Electronics';

-- Finding subcategory for Sports:
SELECT DISTINCT("subcategory") As "subcat_for_sports"
   FROM "amazon_org"
   WHERE "category"='Sports';

-- Finding subcategory for Beauty:
SELECT DISTINCT("subcategory") As "subcat_for_beauty"
   FROM "amazon_org"
   WHERE "category"='Beauty';

-- Finding subcategory for Home:
SELECT DISTINCT("subcategory") As "subcat_for_home"
   FROM "amazon_org"
   WHERE "category"='Home';

-- Finding subcategory for Clothing:
 SELECT DISTINCT("subcategory") AS "subcat_for_Clothing"
   FROM "amazon_org"
   WHERE "category"='Clothing';

-- Finding distinct brands:
SELECT DISTINCT(brand)
  FROM "amazon_org";

-- -- Finding brands for Electronics:
SELECT DISTINCT("brand") As "brands_of_electronics"
   FROM "amazon_org"
   WHERE "category"='Electronics';

-- Finding brands for Sports:
SELECT DISTINCT("brand") As "brands_of_sports"
   FROM "amazon_org"
   WHERE "category"='Sports';

-- Finding brands for Beauty:
SELECT DISTINCT("brand") As "brands_of_beauty"
   FROM "amazon_org"
   WHERE "category"='Beauty';

-- Finding brands for Home:
SELECT DISTINCT("brand") As "brands_of_home"
   FROM "amazon_org"
   WHERE "category"='Home';

-- Finding brands for Clothing:
 SELECT DISTINCT("brand") AS "brand_of_Clothing"
   FROM "amazon_org"
   WHERE "category"='Clothing';

--price
SELECT MIN("price") As "min_price", MAX("price") AS "max_price"
FROM "amazon_org";

--discount
SELECT MIN("discount") As "min_discount", MAX("discount") AS "max_discount"
FROM "amazon_org";

--review count:
SELECT MIN("review_count") As "min_review_count", MAX("review_count") AS "max_review_count"
FROM "amazon_org";

-- rating:
SELECT MIN("rating") As "min_rating", MAX("rating") AS "max_rating"
FROM "amazon_org";

--stock:
SELECT MIN("stock") As "min_stock", MAX("stock") AS "max_stock"
FROM "amazon_org";

--seller rating:
SELECT MIN("seller_rating") As "min_seller_rating", MAX("seller_rating") AS "max_seller_rating"
FROM "amazon_org";

-- FIND IF purchase_date is in anyother Format than this:
SELECT "purchase_date" FROM "amazon_org"
WHERE "purchase_date" NOT LIKE '_/_/____'
 AND "purchase_date" NOT LIKE '_/__/____'
 AND "purchase_date" NOT LIKE '__/_/____'
 AND "purchase_date" NOT LIKE '__/__/____';

 --shipping_time_days:
 SELECT MIN("shipping_time_days") As "min_shipping_time_days", MAX("shipping_time_days") AS "max_shipping_time_days",
   AVG(shipping_time_days) AS "AVG_shipping_time_days"
   FROM "amazon_org";


-- Location validity
SELECT DISTINCT("location")
FROM "amazon_org";

-- order_device options:
SELECT DISTINCT(order_device)
FROM "amazon_org";

-- distinct payment methods:
SELECT DISTINCT(payment_method)
FROM "amazon_org";

-- "is_returned" options:
SELECT DISTINCT("is_returned")
FROM "amazon_org";

-- "delivery_status options:
SELECT DISTINCT("delivery_status")
FROM "amazon_org";
