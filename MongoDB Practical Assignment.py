#1 Write a Python script to load the Superstore dataset from a CSV file into MongoDB<


import pandas as pd
from pymongo import MongoClient

# Load CSV file
df = pd.read_csv("E:\MongoDB Assignment\superstore.csv",encoding="ISO-8859-1")

# Convert to dictionary format
records = df.to_dict(orient="records")

# Connect to MongoDB (local server)
client = MongoClient("mongodb://localhost:27017/")

# Create database and collection
db = client["superstore_db"]
collection = db["orders"]

print(df.head())  # Print the first few rows of the DataFrame to verify data loading

# Insert data into MongoDB
collection.insert_many(records)

print("Superstore data inserted successfully into MongoDB!")


#2 Retrieve and print all documents from the Orders collection

from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database and collection
db = client["superstore_db"]
collection = db["orders"]

# Retrieve all documents
documents = collection.find()

# Print all documents
for doc in documents:
    print(doc)


#3 Count and display the total number of documents in the Orders collection<

from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database and collection
db = client["superstore_db"]
collection = db["orders"]

# Count total documents
total_docs = collection.count_documents({})

# Display result
print("Total number of documents in Orders collection:", total_docs)

#4 Write a query to fetch all orders from the "West" region<

from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database and collection
db = client["superstore_db"]
collection = db["orders"]

# Fetch orders from West region
west_orders = collection.find({"Region": "West"})

# Display results
for order in west_orders:
    print(order)

#5 Write a query to find orders where Sales is greater than 500

from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database and collection
db = client["superstore_db"]
collection = db["orders"]

# Fetch orders where Sales > 500
high_sales_orders = collection.find({"Sales": {"$gt": 500}})

# Display results
for order in high_sales_orders:
    print(order)

#6 Fetch the top 3 orders with the highest Profit<

from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database and collection
db = client["superstore_db"]
collection = db["orders"]

# Fetch top 3 orders with highest Profit
top_profit_orders = collection.find().sort("Profit", -1).limit(3)

# Display results
for order in top_profit_orders:
    print(order)

#7 Update all orders with Ship Mode as "First Class" to "Premium Class.

from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database and collection
db = client["superstore_db"]
collection = db["orders"]

# Update Ship Mode
result = collection.update_many(
    {"Ship Mode": "First Class"},
    {"$set": {"Ship Mode": "Premium Class"}}
)

# Display result
print("Matched documents:", result.matched_count)
print("Modified documents:", result.modified_count)

#8 Delete all orders where Sales is less than 50

from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database and collection
db = client["superstore_db"]
collection = db["orders"]

# Delete orders where Sales < 50
result = collection.delete_many({"Sales": {"$lt": 50}})

# Display result
print("Deleted documents count:", result.deleted_count)

#9 Use aggregation to group orders by Region and calculate total sales per region<

from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database and collection
db = client["superstore_db"]
collection = db["orders"]

# Aggregation pipeline
result = collection.aggregate([
    {
        "$group": {
            "_id": "$Region",
            "total_sales": {"$sum": "$Sales"}
        }
    }
])

# Display results
for r in result:
    print(r)

#10 Fetch all distinct values for Ship Mode from the collection<

from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database and collection
db = client["superstore_db"]
collection = db["orders"]

# Get distinct Ship Mode values
ship_modes = collection.distinct("Ship Mode")

# Display results
print("Distinct Ship Modes:", ship_modes)

#11Count the number of orders for each category.

from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database and collection
db = client["superstore_db"]
collection = db["orders"]

# Aggregation pipeline
result = collection.aggregate([
    {
        "$group": {
            "_id": "$Category",
            "total_orders": {"$sum": 1}
        }
    }
])

# Display results
for r in result:
    print(r)