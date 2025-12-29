# FlexiMart Star Schema Design

## Section 1: Schema Overview

FACT TABLE: fact_sales  
Grain: One row per product per order line item  
Business Process: Sales transactions

Measures (Numeric Facts):
- quantity_sold: Number of units sold
- unit_price: Price per unit at time of sale
- discount_amount: Discount applied
- total_amount: Final amount (quantity × unit_price − discount_amount)

Foreign Keys:
- date_key → dim_date
- product_key → dim_product
- customer_key → dim_customer

DIMENSION TABLE: dim_date  
Purpose: Date dimension for time-based analysis  
Type: Conformed dimension  
Attributes:
- date_key (PK): Surrogate key (integer, format: YYYYMMDD)
- full_date: Actual date
- day_of_week: Monday, Tuesday, etc.
- month: 1–12
- month_name: January, February, etc.
- quarter: Q1, Q2, Q3, Q4
- year: 2023, 2024, etc.
- is_weekend: Boolean

DIMENSION TABLE: dim_product  
Purpose: Product details for category and pricing analysis  
Attributes:
- product_key (PK): Surrogate key (integer)
- product_id: Original operational system product ID
- product_name: Name of the product
- category: High-level category (Electronics, Fashion, etc.)
- subcategory: More detailed group (Smartphones, Laptops, Shoes)
- brand: Brand name
- current_price: Current catalog price
- is_active: Whether product is currently sold

DIMENSION TABLE: dim_customer  
Purpose: Customer information for segmentation  
Attributes:
- customer_key (PK): Surrogate key (integer)
- customer_id: Original operational system customer ID
- customer_name: Full name
- email: Email address
- city: City of residence
- state: State or region
- registration_date: First signup date
- segment: Derived segment (for example, New, Loyal, High-value)


## Section 2: Design Decisions (≈150 words)

The grain is chosen as transaction line-item level because it provides the most detailed view of sales. From this lowest level of detail, reports can roll up to order-level, daily, monthly, product-level, or customer-level summaries without losing information. Analysts can answer questions about individual products within orders as well as aggregated trends.

Surrogate keys are used instead of natural keys to decouple the warehouse from source system IDs and formats. If operational systems change their primary keys or migrate to new platforms, only the ETL mapping needs adjustment while the warehouse keys remain stable. Surrogate keys also allow slowly changing dimensions, where historical versions of a product or customer can be kept with different surrogate keys.

This star schema supports drill-down and roll-up because measures in fact_sales link consistently to conformed dimensions. Analysts can start from total revenue by year, then drill down to quarter, month, product category, and finally individual customers or products using the same fact table.


## Section 3: Sample Data Flow

Source transaction example:  
Order #101, Customer "John Doe", Product "Laptop", Qty: 2, Price: 50000, Discount: 0

Becomes in Data Warehouse:

fact_sales: {
  date_key: 20240115,
  product_key: 5,
  customer_key: 12,
  quantity_sold: 2,
  unit_price: 50000,
  discount_amount: 0,
  total_amount: 100000
}

dim_date: {
  date_key: 20240115,
  full_date: '2024-01-15',
  day_of_week: 'Monday',
  month: 1,
  month_name: 'January',
  quarter: 'Q1',
  year: 2024,
  is_weekend: false
}

dim_product: {
  product_key: 5,
  product_id: 'ELEC010',
  product_name: 'Laptop',
  category: 'Electronics',
  subcategory: 'Laptops',
  brand: 'FlexiBrand',
  current_price: 52000,
  is_active: true
}

dim_customer: {
  customer_key: 12,
  customer_id: 'C0101',
  customer_name: 'John Doe',
  email: 'john.doe@example.com',
  city: 'Mumbai',
  state: 'Maharashtra',
  registration_date: '2023-11-10',
  segment: 'New'
}
s