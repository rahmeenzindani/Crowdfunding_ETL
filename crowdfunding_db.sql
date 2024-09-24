-- Database: crowdfunding_db

-- DROP DATABASE IF EXISTS crowdfunding_db;

CREATE DATABASE crowdfunding_db
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- 1. Create the Category Table
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category VARCHAR(255) NOT NULL
);

-- 2. Create the Subcategory Table
CREATE TABLE subcategory (
    subcategory_id SERIAL PRIMARY KEY,
    subcategory VARCHAR(255) NOT NULL
);

-- 3. Create the Contacts Table
CREATE TABLE contacts (
    contact_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

-- 4. Create the Campaign Table
CREATE TABLE campaign (
    cf_id SERIAL PRIMARY KEY,
    contact_id INT REFERENCES contacts(contact_id),
    company_name VARCHAR(255) NOT NULL,
    description TEXT,
    goal FLOAT NOT NULL,
    pledged FLOAT NOT NULL,
    outcome VARCHAR(50),
    backers_count INT,
    country VARCHAR(100),
    currency VARCHAR(10),
    launch_date TIMESTAMP,
    end_date TIMESTAMP,
    category_id INT REFERENCES category(category_id),
    subcategory_id INT REFERENCES subcategory(subcategory_id)
);

-- Import Category Data
COPY category(category_id, category)
FROM '/resources/category.csv' 
DELIMITER ',' 
CSV HEADER;

-- Import Subcategory Data
COPY subcategory(subcategory_id, subcategory)
FROM '/resources/subcategory.csv' 
DELIMITER ',' 
CSV HEADER;

-- Import Contacts Data
COPY contacts(contact_id, first_name, last_name, email)
FROM '/resources/contacts.csv' 
DELIMITER ',' 
CSV HEADER;

-- Import Campaign Data
COPY campaign(cf_id, contact_id, company_name, description, goal, pledged, outcome, backers_count, country, currency, launch_date, end_date, category_id, subcategory_id)
FROM '/resources/campaign.csv' 
DELIMITER ',' 
CSV HEADER;

SELECT * FROM category;
SELECT * FROM subcategory;
SELECT * FROM contacts;
SELECT * FROM campaign;