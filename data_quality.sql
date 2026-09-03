-- Reviewing rating and review_count:
SELECT "product-id", "review_count", "rating"
FROM "amazon_org"
   LIMIT 20;

SELECT SUM(CASE WHEN "rating" = CAST("rating" AS INTEGER) THEN 1 ELSE 0 END) AS "whole_numbers",
COUNT (*) AS "total_records"
FROM "amazon_org";


-- Reviewing Brands in Different Categories and subcategories:
SELECT "product_id", "category", "subcategory", "Brand" FROM "amazon_org"
LIMIT 20;

SELECT "brand", COUNT(DISTINCT("subcategory")) AS "total_subcategories" FROM "amazon_org"
 GROUP BY "brand";

-- Reviewing final price:
SELECT "product_id","price","discount","final_price"
 FROM "amazon_org"
 LIMIT 10;

SELECT "product_id","price","discount","final_price"
 FROM "amazon_org"
 WHERE "price"-"discount" != "final_price"
 LIMIT 20;

-- found all records had incorrect final_prices.
 SELECT COUNT("final_price") AS "Invalid_final_price", COUNT(*) AS "total_records"
 FROM "amazon_org"
 WHERE "price"-"discount" != "final_price";

-- found final price is less than price-discount:
SELECT "product_id","price","discount","final_price",
("price"-"discount") AS "discounted_price",
("final_price"- ("price"-"discount")) AS "difference_in_price"
 FROM "amazon_org"
 LIMIT 20;

-- Making sure all final_price is less than price-discount:
SELECT "product_id","price","discount","final_price",
("price"-"discount") AS "discounted_price",
("final_price"- ("price"-"discount")) AS "difference_in_price"
 FROM "amazon_org"
 WHERE "final_price" > ("price"-"discount")
 LIMIT 20;

--Assuming discount as percentage and not as flat:
SELECT "product_id","price","discount","final_price",
ROUND(("price"- ("price"*"discount"/100)),2) AS "discounted_percentage_price",
"final_price"- ("price"- ("price"*"discount"/100)) AS "difference_in_prices"
FROM "amazon_org"
LIMIT 20;

-- finding negative stock values:
SELECT "product_id","category","stock"
   FROM "amazon_org"
   WHERE "stock"< 0;

--Making sure minimum seller rating is 2.5 and max does not exceed 5.
SELECT "seller_id","seller_rating"
FROM "amazon_org"
WHERE "seller_rating" <2.5
OR "seller_rating">5;

--records with discount:
SELECT COUNT(*) AS total_records, COUNT("discount") AS "records_with_discount"
FROM "amazon_org"
WHERE "discount">0;

---purchase_date quality:
SELECT
 MIN(CAST(substr("purchase_date",-4)AS INTEGER)) AS earliest_year,
 MAX(CAST(substr("purchase_date",-4)AS INTEGER)) AS latest_year
 FROM "amazon_org";

SELECT
 MIN(CAST(purchase_date AS INTEGER)) AS min_month,
 MAX(CAST(purchase_date AS INTEGER)) AS max_month
 FROM amazon_org;

 SELECT
MIN(CAST(CASE
        WHEN purchase_date LIKE '%/__/____' THEN substr(purchase_date, -5, -2)
        WHEN purchase_date LIKE '%/_/____'  THEN substr(purchase_date, -5, -1)
        END AS INTEGER)) AS min_day,
    MAX(CAST(CASE
        WHEN purchase_date LIKE '%/__/____' THEN substr(purchase_date, -5, -2)
        WHEN purchase_date LIKE '%/_/____'  THEN substr(purchase_date, -5, -1)
        END AS INTEGER)) AS max_day
FROM amazon_org;
