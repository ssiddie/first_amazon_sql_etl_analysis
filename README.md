Amazon E-Commerce Data Analysis
Project Overview

This project analyzes an Amazon e-commerce dataset obtained from Kaggle. The goal is to examine the raw data, assess its quality, prepare it for analysis, normalize it into logical tables, and generate insights about products, customers, sellers, and sales activity.
The original dataset is preserved in its raw form. No changes were made to the original data during the initial profiling phase.

Project Workflow

This project follows the workflow below:

Raw Data
   ↓
Initial Data Profiling
   ↓
Profiling Observations
   ↓
Data Quality Investigation
   ↓
Staging and Data Transformation
   ↓
Staged Data Validation
   ↓
Data Normalization
   ↓
Business Analysis
   ↓
Dashboard and Final Insights

INITIAL PROFILING:

Data Structure: The raw dataset was imported into SQLite and stored in the table: "amazon_org". The dataset contains 20 columns related to Users, Products, Product categories and sub categories, Brands, Prices and discounts, Products' Reviews and ratings, stock, Sellers and Seller ratings, purchase date, shipping, location, order device, Payment methods, Returns and Delivery status.
The total number of records/rows are 1000,000.
              <img width="194" height="212" alt="amazon_org_schema" src="https://github.com/user-attachments/assets/d66a8048-1806-4e5e-                  a5cd-389c2822962a" />
              
Data Completeness: The dataset was checked for both:
                        SQL NULL values = 0
                        Blank or empty values = 0
This was done separately because missing values from a CSV import can be represented differently after being imported into                a database.The initial profiling results showed no significant missing-value issues in the dataset.
Any missing values identified during later stages will be investigated further.

Categorical Profiling: Distinct values were reviewed for several categorical fields, including:

Category: Electronics, Sports, Beauty, Home and Clothing.

Subcategory: For Electronics: Mobile, Laptop, Camera, Headphones.
<img width="284" height="104" alt="subcategory for ELECTRONICS" src="https://github.com/user-attachments/assets/3db877f5-75b8-4626-8a74-eb49cbe2c577" />

For Sports: Outdoor, Fitness, Cycling 
<img width="269" height="100" alt="Subcatecory for SPORTS" src="https://github.com/user-attachments/assets/961e74cc-e6ab-4a45-8003-033e783b2871" />

For Beauty: Makeup, Skincare, Haircare 
<img width="261" height="103" alt="subcategory for BEAUTY" src="https://github.com/user-attachments/assets/dfb9449e-940d-4823-bc01-a51caaf0eefc" />

For Clothing: Kids, Women, Men 
<img width="273" height="98" alt="subcategory for CLOTHING" src="https://github.com/user-attachments/assets/dba756b4-6b56-4eca-966c-409bc79ae1ea" />

For Home: Decor, Furniture, Kitchen <img width="265" height="105" alt="subcategory for HOME" src="https://github.com/user-attachments/assets/89a3d0b1-85aa-4199-9c2e-21adb5c94987" />

Brands: Samsung, H&M, Adidas, Nike, Lenovo, Apple, Zara, Boat, LG, HP, Sony, Puma

Location: Bangalore, Dehli, Chennai, Mumbai, Hyderabad.

Order device: Tablet, Mobile App, Web.

Payment method: UPI, Credit card, Debit card, Cash on Delivery

Return status: TRUE, FALSE.

Delivery status: Returned, In transit, Delayed, Delivered.

This review was used to understand the data, to find any inconsistencies in text format and anomalies in categories.

Numerical Profiling: The following numerical fields were reviewed using minimum and maximum values:

Price: min:200.03, max:79999.7.

Discount: min:5.0, max:70.0.

Review count: min:1.5, max:5.

Rating: min:0, max: 3408.0.

Stock: min:0, max:500.

Seller rating: min: 2.5, max: 5.0.

Shipping time in days: min:1, max:6.

This initial review was used to identify ranges and potential anomalies that may require further investigation.

 Date Profiling :The purchase_date field was reviewed to determine its existing format and any anomalies
 <img width="239" height="67" alt="date_format" src="https://github.com/user-attachments/assets/376ed7aa-b45f-423a-bf96-7c431a32ab4f" />
 
The raw date values are not stored in ISO format and will require standardization in a later transformation stage before                  reliable date-based analysis can be performed.
The original date values will remain unchanged in the raw source table.

PROFILING OBSERVATIONS:

The initial profiling process identified several patterns and potential issues that require further investigation. These observations are not yet considered confirmed data-quality errors.

Observation 1: Potential Rating and Review Count Column Mismatch

The field labeled rating contains values ranging from approximately 0 to 3,408, while the field labeled review_count                      contains values ranging from approximately 1.5 to 5.
These ranges do not appear consistent with the expected meaning of the column names.
This suggests a potential column-label mismatch where:

                rating may contain review-count data
                review_count may contain rating data
                
This observation will be investigated before making any changes to the dataset.

<img width="344" height="73" alt="Xrating_min_max" src="https://github.com/user-attachments/assets/df8ecf00-f86d-42a3-8d2a-85a0d7384f02" />
<img width="435" height="73" alt="Xreview_count" src="https://github.com/user-attachments/assets/59d95a74-2a5d-416d-a1e6-af8debd42a82" />

Observation 2: Brand Values Appear Across Unrelated Categories

Distinct brand values were reviewed within each major product category.
The brand lists appeared to contain similar or identical values across unrelated categories, including:

                Electronics
                
                Sports
                
                Beauty
                
                Home
                
                Clothing
                
This pattern was flagged for further investigation because some brands may not logically align with the categories in                     which they appear.
               
At this stage, this is recorded as a profiling observation rather than a confirmed data-quality issue.

<img width="242" height="173" alt="Xdistinct_brand_Electronics" src="https://github.com/user-attachments/assets/08916ca4-46ad-469f-8057-87be14dec0e9" />
<img width="247" height="178" alt="Xdistinc_brands_Sports" src="https://github.com/user-attachments/assets/1df18f1c-3e44-4e15-91af-ae059b925a8a" />
<img width="242" height="173" alt="Xdistinct_brands_Home" src="https://github.com/user-attachments/assets/3e7690b7-006c-43a6-9664-78cb18e30246" />
<img width="243" height="181" alt="Xdistinct_brands_Clothing" src="https://github.com/user-attachments/assets/f560880f-151c-4511-bede-d51c5dde9035" />
<img width="257" height="172" alt="Xdistinct_brands_Beauty" src="https://github.com/user-attachments/assets/75c9a625-bfdd-4c45-86ee-b864093567b9" />

Observation 3: Discount Values Are Always Positive

The discount field contains values ranging from $5 to $75.
No NULL or blank discount values were identified during initial profiling. Since the minimum observed value is $5, no                     zero-value discounts were observed.
This pattern was flagged for later investigation.

<img width="347" height="71" alt="Xdiscount_min_max" src="https://github.com/user-attachments/assets/9945219c-3a11-4e3f-97e6-5b69b45141b9" />

Observation 4: Seller Rating Range

The seller_rating field ranges from 2.5 to 5.0.
No seller ratings below 2.5 were observed.
This is not currently considered a data-quality issue because the expected seller-rating scale has not yet been confirmed.

<img width="436" height="75" alt="Xseller_rating_min_max" src="https://github.com/user-attachments/assets/29c5bde1-081a-4c3e-8720-28be2f8e3255" />


              

