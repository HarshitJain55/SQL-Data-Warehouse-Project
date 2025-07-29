-- Create a new database for our data warehouse
CREATE DATABASE datawarehouse;

-- After creating the database, connect to it in pgAdmin or your SQL tool.
-- Then run the following to set up the basic schemas:

-- Raw data layer
CREATE SCHEMA bronze;

-- Cleaned and transformed data
CREATE SCHEMA silver;

-- Final analytics-ready layer
CREATE SCHEMA gold;
