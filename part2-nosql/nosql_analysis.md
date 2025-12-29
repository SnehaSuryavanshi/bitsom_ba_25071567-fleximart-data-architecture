# NoSQL Analysis for FlexiMart

## Section A: Limitations of RDBMS (≈150 words)

The current relational database works well for structured, predictable data, but it struggles with a highly diverse product catalog. Products like laptops, phones, and shoes all have different attributes. In MySQL, this usually means either a very wide products table with many nullable columns, or many separate tables joined together. Both options become hard to maintain and inefficient to query as new product types are added.

Relational schemas are rigid. Adding a new product attribute, such as screen_refresh_rate for monitors, requires altering the table and possibly touching existing ETL code and reports. Frequent schema changes are slow and risky in production.

Storing customer reviews as nested data is also awkward. Reviews may contain ratings, comments, images, and metadata. In MySQL this typically needs separate review tables with foreign keys, and multiple joins to fetch a single product plus its reviews. As review volume grows, these joins can become heavy and harder to scale horizontally.

## Section B: NoSQL Benefits with MongoDB (≈150 words)

MongoDB is a good fit for a diverse product catalog because it uses a flexible document schema. Each product is stored as a JSON-like document, so laptops can have fields like ram and processor, while shoes can have size and color in the same collection. New attributes can be added to only those documents that need them without changing a global table structure.

Customer reviews can be embedded directly inside the product document as an array of subdocuments. Each review can include rating, comment, author, and timestamps. Fetching a product with its reviews becomes a single query, which simplifies the application code and avoids complex SQL joins.

MongoDB is also designed for horizontal scalability. Collections can be sharded across multiple servers based on a key such as product_id or category. This lets FlexiMart handle increasing read and write traffic as the catalog and review volume grow, while keeping response times acceptable.

## Section C: Trade-offs of Using MongoDB (≈100 words)

Using MongoDB instead of MySQL introduces some trade-offs. First, MongoDB does not enforce strict relational integrity with foreign keys. Application code must handle consistency between related data such as customers, products, and orders, which increases responsibility on developers.

Second, complex analytical queries and ad-hoc joins are often easier and more efficient in a relational database using SQL. For reporting across many tables, MySQL may still be a better choice or might require exporting MongoDB data into a warehouse. The team also needs new skills and operational tooling to deploy, monitor, and back up an additional database technology.
