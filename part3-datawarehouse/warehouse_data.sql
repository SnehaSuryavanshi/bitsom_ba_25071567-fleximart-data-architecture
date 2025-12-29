USE fleximart_dw;

-- INSERT dim_date (30+ rows, Jan-Feb 2024, weekdays + weekends)
INSERT INTO dim_date (date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, is_weekend) VALUES
(20240101, '2024-01-01', 'Monday', 1, 1, 'January', 'Q1', 2024, TRUE),
(20240102, '2024-01-02', 'Tuesday', 2, 1, 'January', 'Q1', 2024, FALSE),
(20240106, '2024-01-06', 'Saturday', 6, 1, 'January', 'Q1', 2024, TRUE),
(20240107, '2024-01-07', 'Sunday', 7, 1, 'January', 'Q1', 2024, TRUE),
(20240108, '2024-01-08', 'Monday', 8, 1, 'January', 'Q1', 2024, FALSE),
(20240113, '2024-01-13', 'Saturday', 13, 1, 'January', 'Q1', 2024, TRUE),
(20240114, '2024-01-14', 'Sunday', 14, 1, 'January', 'Q1', 2024, TRUE),
(20240115, '2024-01-15', 'Monday', 15, 1, 'January', 'Q1', 2024, FALSE),
(20240120, '2024-01-20', 'Saturday', 20, 1, 'January', 'Q1', 2024, TRUE),
(20240121, '2024-01-21', 'Sunday', 21, 1, 'January', 'Q1', 2024, TRUE),
(20240122, '2024-01-22', 'Monday', 22, 1, 'January', 'Q1', 2024, FALSE),
(20240127, '2024-01-27', 'Saturday', 27, 1, 'January', 'Q1', 2024, TRUE),
(20240128, '2024-01-28', 'Sunday', 28, 1, 'January', 'Q1', 2024, TRUE),
(20240129, '2024-01-29', 'Monday', 29, 1, 'January', 'Q1', 2024, FALSE),
(20240203, '2024-02-03', 'Saturday', 3, 2, 'February', 'Q1', 2024, TRUE),
(20240204, '2024-02-04', 'Sunday', 4, 2, 'February', 'Q1', 2024, TRUE),
(20240205, '2024-02-05', 'Monday', 5, 2, 'February', 'Q1', 2024, FALSE),
(20240210, '2024-02-10', 'Saturday', 10, 2, 'February', 'Q1', 2024, TRUE),
(20240211, '2024-02-11', 'Sunday', 11, 2, 'February', 'Q1', 2024, TRUE),
(20240212, '2024-02-12', 'Monday', 12, 2, 'February', 'Q1', 2024, FALSE),
(20240217, '2024-02-17', 'Saturday', 17, 2, 'February', 'Q1', 2024, TRUE),
(20240218, '2024-02-18', 'Sunday', 18, 2, 'February', 'Q1', 2024, TRUE),
(20240219, '2024-02-19', 'Monday', 19, 2, 'February', 'Q1', 2024, FALSE),
(20240224, '2024-02-24', 'Saturday', 24, 2, 'February', 'Q1', 2024, TRUE),
(20240225, '2024-02-25', 'Sunday', 25, 2, 'February', 'Q1', 2024, TRUE),
(20240226, '2024-02-26', 'Monday', 26, 2, 'February', 'Q1', 2024, FALSE);

-- INSERT dim_product (15 products, 3 categories, prices 100-100000)
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('ELEC001', 'Samsung Galaxy S21', 'Electronics', 'Smartphones', 69900.00),
('ELEC002', 'iPhone 14', 'Electronics', 'Smartphones', 79900.00),
('ELEC003', 'Dell Laptop', 'Electronics', 'Laptops', 45900.00),
('ELEC004', 'MacBook Air', 'Electronics', 'Laptops', 92900.00),
('ELEC005', 'Sony Headphones', 'Electronics', 'Audio', 12900.00),
('FASH001', 'Nike Air Max', 'Fashion', 'Footwear', 8990.00),
('FASH002', 'Levi Jeans', 'Fashion', 'Apparel', 2990.00),
('FASH003', 'Ray-Ban Sunglasses', 'Fashion', 'Accessories', 8900.00),
('FASH004', 'Gucci T-Shirt', 'Fashion', 'Apparel', 15900.00),
('FASH005', 'Adidas Sneakers', 'Fashion', 'Footwear', 6990.00),
('HOME001', 'IKEA Sofa', 'Home', 'Furniture', 24900.00),
('HOME002', 'Dining Table', 'Home', 'Furniture', 18900.00),
('HOME003', 'LED TV 55"', 'Home', 'Electronics', 39900.00),
('HOME004', 'Refrigerator', 'Home', 'Appliances', 28900.00),
('HOME005', 'Washing Machine', 'Home', 'Appliances', 21900.00);

-- INSERT dim_customer (12 customers, 4 cities)
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('CUST001', 'Riya Sharma', 'Mumbai', 'Maharashtra', 'Loyal'),
('CUST002', 'Arjun Verma', 'Delhi', 'Delhi', 'New'),
('CUST003', 'Priya Singh', 'Bangalore', 'Karnataka', 'High-value'),
('CUST004', 'Rahul Patel', 'Mumbai', 'Maharashtra', 'Regular'),
('CUST005', 'Neha Gupta', 'Pune', 'Maharashtra', 'New'),
('CUST006', 'Vikram Joshi', 'Delhi', 'Delhi', 'Loyal'),
('CUST007', 'Anita Rao', 'Bangalore', 'Karnataka', 'High-value'),
('CUST008', 'Suresh Kumar', 'Chennai', 'Tamil Nadu', 'Regular'),
('CUST009', 'Meera Nair', 'Mumbai', 'Maharashtra', 'Loyal'),
('CUST010', 'Karan Malhotra', 'Delhi', 'Delhi', 'New'),
('CUST011', 'Lakshmi Reddy', 'Hyderabad', 'Telangana', 'Regular'),
('CUST012', 'Amit Desai', 'Pune', 'Maharashtra', 'High-value');

-- INSERT fact_sales (40+ realistic transactions, higher weekend sales)
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
-- Saturday high sales (Jan 13)
(20240113, 1, 1, 2, 69900.00, 0.00, 139800.00),
(20240113, 6, 2, 3, 8990.00, 0.00, 26970.00),
(20240113, 11, 3, 1, 24900.00, 0.00, 24900.00),

-- Sunday sales (Jan 14) 
(20240114, 2, 4, 1, 79900.00, 7990.00, 71910.00),
(20240114, 7, 5, 4, 2990.00, 0.00, 11960.00),
(20240114, 12, 6, 2, 21900.00, 0.00, 43800.00),

-- Weekday sales (lower qty)
(20240115, 3, 7, 2, 45900.00, 0.00, 91800.00),
(20240115, 8, 8, 1, 8900.00, 0.00, 8900.00),

-- More weekend sales...
(20240120, 4, 9, 1, 92900.00, 0.00, 92900.00),
(20240120, 5, 10, 5, 12900.00, 645.00, 60075.00),
(20240121, 9, 11, 2, 15900.00, 0.00, 31800.00),
(20240122, 10, 12, 3, 6990.00, 0.00, 20970.00),

-- February weekends (more high qty)
(20240203, 1, 1, 1, 69900.00, 0.00, 69900.00),
(20240204, 15, 2, 1, 21900.00, 0.00, 21900.00),
(20240210, 3, 3, 2, 45900.00, 0.00, 91800.00),
(20240211, 6, 4, 4, 8990.00, 0.00, 35960.00);

