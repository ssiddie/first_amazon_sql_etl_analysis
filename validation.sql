-- validating number of rows in both tables:
SELECT (SELECT COUNT(*) FROM "amazon_org") AS "amazon_org_rows",
   (SELECT COUNT(*) FROM "amazon_temp") AS "amazon_temp_rows";

-- validating date format using sample:
SELECT  "amazon_org"."rowid","amazon_org"."purchase_date" AS "org_dates", "amazon_temp"."rowid","amazon_temp"."purchase_date" AS "ISO_dates" FROM "amazon_org"
 JOIN "amazon_temp" ON "amazon_org"."rowid"="amazon_temp"."rowid"
 LIMIT 5;

 SELECT "purchase_date" FROM "amazon_temp"
 WHERE "purchase_date" NOT LIKE '____-__-__';

-- validating no accidental NULLS are introduced while fixin the date column:
 SELECT SUM(CASE WHEN "purchase_date" IS NULL THEN 1 ELSE 0 END) AS "purchase_date_nulls" FROM "amazon_temp";

 -- validating same products exist in both:
SELECT
    (SELECT COUNT(DISTINCT product_id) FROM amazon_org) AS original_products,
    (SELECT COUNT(DISTINCT product_id) FROM amazon_temp) AS temp_products;

-- validating column name changed only, values remain same:
SELECT  COUNT (*) AS "mismatched_discount" FROM "amazon_org"
 JOIN "amazon_temp" ON "amazon_org"."rowid"="amazon_temp"."rowid"
 WHERE "amazon_org"."discount" != "amazon_temp"."discount_percent";

-- validating review count column:
 SELECT "amazon_org"."rowid","amazon_org"."rating" AS "org_rating", "amazon_temp"."rowid","amazon_temp"."review_count" FROM "amazon_org"
 JOIN "amazon_temp" ON "amazon_org"."rowid"="amazon_temp"."rowid"
 LIMIT 5;

--validating ratings column:
 SELECT "amazon_org"."rowid","amazon_org"."review_count" AS "org_review_count", "amazon_temp"."rowid","amazon_temp"."ratings" FROM "amazon_org"
 JOIN "amazon_temp" ON "amazon_org"."rowid"="amazon_temp"."rowid"
 LIMIT 5;

--validating columns have no white spaces:
SELECT COUNT(*) AS "rows_untrimmed" FROM "amazon_temp"
WHERE "user_id" != TRIM("user_id") OR
 "product_id" != TRIM("product_id") OR
 "category" != TRIM("category") OR
 "subcategory" != TRIM("subcategory") OR
 "seller_id" != TRIM("seller_id") OR
 "purchase_date" != TRIM("purchase_date")OR
 "location" != TRIM("location")OR
 "order_device" != TRIM("order_device") OR
 "payment_method" != TRIM("payment_method") OR
 "is_returned" != TRIM("is_returned")OR
 "delivery_status" != TRIM("delivery_status");
