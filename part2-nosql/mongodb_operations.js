// Operation 1: Load Data
// Import the provided JSON file into collection 'products'
// Run this in the Mongo shell (mongosh) from the folder where products_catalog.json is saved:
//
//   use fleximart_nosql
//   db.products.drop()
//   mongoimport --db=fleximart_nosql --collection=products --file=products_catalog.json --jsonArray
//
// In MongoDB Compass you can do: Collection -> Import Data -> select products_catalog.json


// Operation 2: Basic Query
// Find all products in "Electronics" category with price less than 50000
// Return only: name, price, stock

db.products.find(
    {
      category: "Electronics",
      price: { $lt: 50000 }
    },
    {
      _id: 0,
      name: 1,
      price: 1,
      stock: 1
    }
  );
  

  // Operation 3: Review Analysis
// Find all products that have average rating >= 4.0
// Use aggregation to calculate average from reviews array

db.products.aggregate([
    {
      $addFields: {
        avg_rating: { $avg: "$reviews.rating" }
      }
    },
    {
      $match: {
        avg_rating: { $gte: 4.0 }
      }
    },
    {
      $project: {
        _id: 0,
        product_id: 1,
        name: 1,
        category: 1,
        avg_rating: 1
      }
    }
  ]);

  
  // Operation 4: Update Operation
// Add a new review to product "ELEC001"
// Review: {user: "U999", rating: 4, comment: "Good value", date: ISODate()}

db.products.updateOne(
    { product_id: "ELEC001" },
    {
      $push: {
        reviews: {
          user_id: "U999",
          username: "NewUser",
          rating: 4,
          comment: "Good value",
          date: new Date()
        }
      }
    }
  );

  
  // Operation 5: Complex Aggregation
// Calculate average price by category
// Return: category, avg_price, product_count
// Sort by avg_price descending

db.products.aggregate([
    {
      $group: {
        _id: "$category",
        avg_price: { $avg: "$price" },
        product_count: { $sum: 1 }
      }
    },
    {
      $project: {
        _id: 0,
        category: "$_id",
        avg_price: { $round: ["$avg_price", 2] },
        product_count: 1
      }
    },
    {
      $sort: { avg_price: -1 }
    }
  ]);
  