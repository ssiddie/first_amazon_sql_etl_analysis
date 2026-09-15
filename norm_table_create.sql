CREATE TABLE "products"(
 "product_id" TEXT NOT NULL PRIMARY KEY,
 "category" TEXT ,
 "subcategory" TEXT,
 "price" REAL NOT NULL  CHECK ("price"= ROUND("price",2)),
 "ratings" REAL CHECK ("ratings"= ROUND("ratings",1)),
 "review_count" INTEGER,
 "stock" INTEGER CHECK (stock >=0)
);

CREATE TABLE "sellers"(
    "seller_id" TEXT NOT NULL PRIMARY KEY,
    "seller_rating" REAL CHECK ("seller_rating"=ROUND("seller_rating",1))
);

CREATE TABLE "users"(
    "user_id" TEXT NOT NULL PRIMARY KEY
);

CREATE TABLE "orders"(
"order_id" INTEGER PRIMARY KEY AUTOINCREMENT,
"user_id" TEXT NOT NULL,
"product_id" TEXT NOT NULL,
"seller_id" TEXT NOT NULL,
"discount_percent" REAL CHECK ("discount_percent"=ROUND("discount_percent",2) AND "discount_percent" BETWEEN 0 AND 100),
"final_price" REAL NOT NULL  CHECK ("final_price"=ROUND("final_price",2) AND "final_price">=0),
"purchase_date" TEXT NOT NULL,
"shipping_time_days" INTEGER,
"location" TEXT,
"order_device" TEXT,
"payment_method" TEXT CHECK("payment_method" IN ('UPI', 'Credit Card','Debit Card','Cash on Delivery')),
"is_returned" TEXT CHECK ("is_returned" IN('TRUE','FALSE') ),
"delivery_status" TEXT CHECK ("delivery_status" IN ('Returned','In Transit','Delayed','Delivered','Canceled')),
FOREIGN KEY ("user_id")REFERENCES "users"("user_id"),
FOREIGN KEY ("product_id") REFERENCES "products"("product_id"),
FOREIGN KEY ("seller_id") REFERENCES "sellers"("seller_id")
);
