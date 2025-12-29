# FlexiMart Database Schema Documentation

## 1. Entity–Relationship Description (Text)

### ENTITY: customers

Purpose: Stores customer information.  
Attributes:
- customer_id: Unique identifier (Primary Key, auto-increment).
- first_name: Customer's first name (NOT NULL).
- last_name: Customer's last name (NOT NULL).
- email: Customer's email address (UNIQUE, NOT NULL).
- phone: Standardized phone number with country code.
- city: City where the customer lives.
- registration_date: Date when the customer registered.

Relationships:
- One customer can place MANY orders (1:M relationship with the `orders` table).

### ENTITY: products

Purpose: Stores information about products.  
Attributes:
- product_id: Unique identifier (Primary Key, auto-increment).
- product_name: Name of the product (NOT NULL).
- category: Standardized category name (for example, Electronics).
- price: Price of one unit of the product.
- stock_quantity: Number of units available in stock.

Relationships:
- One product can appear in MANY order_items (1:M relationship with `order_items` table).

### ENTITY: orders

Purpose: Stores order header information.  
Attributes:
- order_id: Unique identifier (Primary Key, auto-increment).
- customer_id: Foreign key referencing `customers.customer_id`.
- order_date: Date when the order was placed.
- total_amount: Total value of the order.
- status: Current status of the order (for example, Pending, Shipped).

Relationships:
- Each order BELONGS TO one customer (M:1 with `customers`).
- One order can have MANY order_items (1:M with `order_items`).

### ENTITY: order_items

Purpose: Stores detailed line items for each order.  
Attributes:
- order_item_id: Unique identifier (Primary Key, auto-increment).
- order_id: Foreign key referencing `orders.order_id`.
- product_id: Foreign key referencing `products.product_id`.
- quantity: Number of units ordered for this product.
- unit_price: Price per unit at the time of order.
- subtotal: Line total (quantity × unit_price).

Relationships:
- Each order_item BELONGS TO one order.
- Each order_item refers to one product.

## 2. Normalization Explanation (3NF)

The FlexiMart schema follows Third Normal Form (3NF).

- Each table stores one type of data only: customers, products, orders, or order_items. All columns are atomic values (no repeated groups), so the design is in 1NF.
- In each table, every non-key attribute depends on the whole primary key and not just a part of it. For example, in `orders`, the columns order_date, total_amount, and status all depend only on order_id.
- There are no transitive dependencies between non-key attributes. Customer details (name, email, city) depend only on customer_id and are kept in `customers`, not repeated in `orders`. Product details (name, category, price) depend only on product_id and are kept in `products`, not repeated in `order_items`.

Functional dependencies:

- customers: customer_id → first_name, last_name, email, phone, city, registration_date.  
- products: product_id → product_name, category, price, stock_quantity.  
- orders: order_id → customer_id, order_date, total_amount, status.  
- order_items: order_item_id → order_id, product_id, quantity, unit_price, subtotal.

Because attributes are stored in their correct tables:

- Update anomalies are avoided: changing a customer’s email or a product’s price is done once in its own table.
- Insert anomalies are avoided: new customers and products can be inserted without any orders yet.
- Delete anomalies are avoided: deleting order_items or orders does not remove the master customer or product records.

## 3. Sample Data Representation

### customers (sample)

| customer_id | first_name | last_name | email                 | phone          | city   | registration_date |
|------------|------------|-----------|-----------------------|----------------|--------|-------------------|
| 1          | Riya       | Sharma    | riya@example.com      | +919876543210  | Mumbai | 2024-01-05        |
| 2          | Arjun      | Verma     | arjun@example.com     | +919812345678  | Pune   | 2024-02-10        |

### products (sample)

| product_id | product_name      | category     | price | stock_quantity |
|-----------|-------------------|--------------|-------|----------------|
| 1         | Wireless Mouse    | Electronics  | 799.0 | 25             |
| 2         | Cotton T-Shirt    | Clothing     | 499.0 | 40             |

### orders (sample)

| order_id | customer_id | order_date  | total_amount | status   |
|---------|-------------|-------------|--------------|----------|
| 1       | 1           | 2024-03-12  | 1298.0       | Shipped  |
| 2       | 2           | 2024-03-15  | 499.0        | Pending  |

### order_items (sample)

| order_item_id | order_id | product_id | quantity | unit_price | subtotal |
|--------------|----------|------------|----------|------------|----------|
| 1            | 1        | 1          | 2        | 649.0      | 1298.0   |
| 2            | 2        | 2          | 1        | 499.0      | 499.0    |
