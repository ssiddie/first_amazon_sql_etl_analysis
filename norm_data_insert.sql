


INSERT INTO "products" ("product_id","category","subcategory","price","ratings","review_count","stock")
SELECT "product_id","category","subcategory","price","ratings","review_count","stock"
FROM (
  SELECT "product_id","category","subcategory","price","ratings","review_count","stock",
         ROW_NUMBER() OVER (
           PARTITION BY "product_id"
           ORDER BY "purchase_date" DESC
         ) AS rn
  FROM "amazon_temp"
) AS ranked
WHERE rn = 1;

INSERT INTO "sellers" ("seller_id","seller_rating")
SELECT "seller_id","seller_rating"
FROM (SELECT "seller_id", "seller_rating",  ROW_NUMBER() OVER (
           PARTITION BY "seller_id"
           ORDER BY "purchase_date" DESC
         ) AS rn
  FROM "amazon_temp"
) AS ranked
WHERE rn = 1;

INSERT INTO "users" ("user_id")
SELECT DISTINCT "user_id" FROM "amazon_temp";


INSERT INTO "orders" ("user_id","product_id","seller_id","discount_percent","final_price","purchase_date",
"shipping_time_days","location","order_device" ,"payment_method","is_returned","delivery_status")
SELECT "user_id","product_id","seller_id","discount_percent","final_price","purchase_date",
"shipping_time_days","location","order_device","payment_method","is_returned","delivery_status" FROM "amazon_temp";
