
-- validating all product ids are present:
SELECT (SELECT COUNT("product_id") FROM "products") AS "prod_count_products",
    (SELECT COUNT(DISTINCT("product_id")) FROM "amazon_temp") AS "prod_count_amazon_temp";

-- validating all seller ids are present:
SELECT (SELECT COUNT("seller_id") FROM "sellers") AS "seller_count_from_sellers",
    (SELECT COUNT(DISTINCT("seller_id")) FROM "amazon_temp") AS "seller_count_amazon_temp";

-- validating all user ids are present:
SELECT (SELECT COUNT("user_id") FROM "users") AS "user_count_from_users",
    (SELECT COUNT(DISTINCT("user_id")) FROM "amazon_temp") AS "user_count_amazon_temp";

-- validating row count in "orders" table and "amazon_temp" table:
SELECT
 (SELECT COUNT(*) FROM amazon_temp) AS amazon_temp_rows,
 (SELECT COUNT(*) FROM orders) AS orders_rows;

-- validating all rows for orders are exactly same as amazon_temp
SELECT COUNT(*) AS "mismatched_rows" FROM "amazon_temp"
JOIN "orders" ON "amazon_temp"."rowid"="orders"."rowid"
WHERE "amazon_temp"."user_id" IS NOT "orders"."user_id" OR
"amazon_temp"."product_id" IS NOT"orders"."product_id" OR
"amazon_temp"."seller_id"IS NOT"orders"."seller_id" OR
"amazon_temp"."discount_percent"IS NOT"orders"."discount_percent" OR
"amazon_temp"."final_price"IS NOT"orders"."final_price" OR
"amazon_temp"."purchase_date" IS NOT "orders"."purchase_date" OR
"amazon_temp"."shipping_time_days"IS NOT "orders"."shipping_time_days" OR
"amazon_temp"."location"IS NOT "orders"."location" OR
"amazon_temp"."order_device" IS NOT "orders"."order_device" OR
"amazon_temp"."payment_method"IS NOT "orders"."payment_method" OR
"amazon_temp"."is_returned"IS NOT "orders"."is_returned" OR
"amazon_temp"."delivery_status"IS NOT "orders"."delivery_status";

--Foreign-key validation
PRAGMA foreign_keys;
PRAGMA foreign_key_check;
