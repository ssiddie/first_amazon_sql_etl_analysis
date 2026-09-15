CREATE TABLE "amazon_temp" AS
SELECT * FROM "amazon_org";

-- Dropping Brands:
ALTER TABLE "amazon_temp"
DROP COLUMN "brand";


--Apply TRIM to TEXT and Date Columns:
UPDATE "amazon_temp"
SET "user_id" = TRIM("user_id"),
 "product_id"= TRIM("product_id"),
 "category" = TRIM("category"),
 "subcategory" = TRIM("subcategory"),
 "seller_id" = TRIM("seller_id"),
 "purchase_date" = TRIM("purchase_date"),
 "location" = TRIM("location"),
 "order_device" = TRIM("order_device"),
 "payment_method" = TRIM("payment_method"),
 "is_returned" = TRIM("is_returned"),
 "delivery_status" = TRIM("delivery_status");

 --Swapping Table Column names :
ALTER TABLE "amazon_temp"
   RENAME "review_count" to "ratings";
ALTER TABLE "amazon_temp"
   RENAME "rating" to "review_count";

-- fixing column Review_count to Integer affinity:
ALTER TABLE amazon_temp
  ADD COLUMN review_count_new INTEGER;
UPDATE amazon_temp
  SET review_count_new = review_count;
ALTER TABLE "amazon_temp"
 DROP COLUMN "review_count";
ALTER TABLE "amazon_temp"
 RENAME "review_count_new" to "review_count";

-- Rename discount column to discount_percent for clarity:
ALTER TABLE "amazon_temp"
 RENAME "discount" to "discount_percent";

-- Update date "__/__/____"to ISO format YYYY-MM-DD:
UPDATE "amazon_temp"
SET "purchase_date"=
 substr("purchase_date",7,4) || '-' ||
 substr("purchase_date",1,2) || '-' ||
 substr("purchase_date",4,2)
 WHERE "purchase_date" LIKE '__/__/____';


--Update Date '_/_/____' to ISO format YYYY-MM-DD:
UPDATE "amazon_temp"
SET "purchase_date"=
  substr("purchase_date",5,4) ||'-'||'0'||
  substr("purchase_date",1,1) ||'-'||'0'||
  substr("purchase_date",3,1)
  WHERE "purchase_date" LIKE '_/_/____';

--Update date '__/_/____'to ISO format YYYY-MM-DD:
UPDATE "amazon_temp"
SET "purchase_date"=
  substr("purchase_date",6,4) ||'-'||
  substr("purchase_date",1,2) ||'-'||'0'||
  substr("purchase_date",4,1)
  WHERE "purchase_date" LIKE '__/_/____';

-- Update date "_/__/____"to ISO format YYYY-MM-DD :
UPDATE "amazon_temp"
SET "purchase_date"=
  substr("purchase_date",6,4) ||'-'||'0'||
  substr("purchase_date",1,1) ||'-'||
  substr("purchase_date",3,2)
  WHERE "purchase_date" LIKE '_/__/____';















