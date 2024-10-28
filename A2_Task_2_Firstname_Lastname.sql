  
  -- TASK 1:Using the provided Book Shop scripts, you are required to provide DML statements to answer the 
-- following questions and sub-questions where applicable

-- Author: [Your Firstname Lastname]
-- File: A2_Task_2_Firstname_Lastname.sql
-- Description: SQL script to create AGENT, PURCHASE_ORDER, and CUSTOMER tables based on the ERD

-- Drop tables if they already exist to avoid duplication

  -- 1. Display the names of all authors in the database, limited to 10 rows.
  USE ICT128RELATIONALDB;
  
  -- Fetching the names of authors limited to 10 results
SELECT name 
FROM author 
LIMIT 10;

-- 2. Query to show the quantities of book_id 7091 in all warehouses, update warehouses, and rerun the query.
-- Showing the current quantities of book_id 7091 in all warehouses
SELECT warehouse_id, quantity 
FROM availability 
WHERE book_id = 7091;

-- Updating warehouse 2 to increase quantity by 10 for book_id 7091
UPDATE availability 
SET quantity = quantity + 10 
WHERE warehouse_id = 2 AND book_id = 7091;

-- Doubling the quantity in warehouse 1 for book_id 7091
UPDATE availability 
SET quantity = quantity * 2 
WHERE warehouse_id = 1 AND book_id = 7091;

-- Rerun query to verify updates
SELECT warehouse_id, quantity 
FROM availability 
WHERE book_id = 7091;

-- 3. Show all books in the “Dogs” category priced between 10 and 12, excluding books with year 0. Sort by year descending.
-- Fetching books in the "Dogs" category, with price between 10 and 12, and year not equal to 0
SELECT * 
FROM book 
WHERE category = 'Dogs' 
  AND price BETWEEN 10 AND 12 
  AND year != 0 
ORDER BY year DESC;


-- 4. Get all publishers with phone numbers starting with +44, sorted alphabetically.
-- Fetching publishers with phone numbers that start with '+44' (UK code), ordered alphabetically by name
SELECT * 
FROM publisher 
WHERE phone LIKE '+44%' 
ORDER BY name ASC;

-- 5. Retrieve titles and categories of books in cart 214, using book_id from cart items.
-- Step 1: Get book_id for items in cart 214
SELECT book_id 
FROM cart_item 
WHERE cart_id = 214;

-- Step 2: Retrieve titles and categories of books in the book_id list
SELECT title, category 
FROM book 
WHERE book_id IN (SELECT book_id FROM cart_item WHERE cart_id = 214);

-- 6. Delete the book “Shadowmancer” from all relevant tables (shopping carts, warehouses, and books).
-- Step 1: Remove "Shadowmancer" from shopping carts
DELETE FROM cart_item 
WHERE book_id = (SELECT book_id FROM book WHERE title = 'Shadowmancer');

-- Step 2: Remove "Shadowmancer" from all warehouses
DELETE FROM availability 
WHERE book_id = (SELECT book_id FROM book WHERE title = 'Shadowmancer');

-- Step 3: Remove "Shadowmancer" from the book table
DELETE FROM book 
WHERE title = 'Shadowmancer';

-- 7. Add a pages column to book, calculate values as price * 18, and show first 7 records.
-- Adding the pages column to book table
ALTER TABLE book 
ADD pages INT;

-- Updating the pages column with estimated values calculated by multiplying price by 18
UPDATE book 
SET pages = ROUND(price * 18);

-- Selecting the first 7 records to confirm page numbers are updated
SELECT * 
FROM book 
LIMIT 7;

-- 8. Show titles, publication years, and pages of books by author with author_id 122.
-- Fetching titles, years, and pages of books by author_id 122
SELECT title, year, pages 
FROM book 
WHERE author_id = 122;

-- 9. Create a shopping cart for customer ‘Darci Jupp’ to buy one copy of ‘No Safe Place.’
-- Step 1: Find customer_id for "Darci Jupp"
SELECT customer_id 
FROM customer 
WHERE first_name = 'Darci' AND last_name = 'Jupp';

-- Step 2: Find book_id for "No Safe Place"
SELECT book_id 
FROM book 
WHERE title = 'No Safe Place';

-- Step 3: Create a new shopping cart for the customer
INSERT INTO shopping_cart (customer_id, created, ordered) 
VALUES ((SELECT customer_id FROM customer WHERE first_name = 'Darci' AND last_name = 'Jupp'), NOW(), NULL);

-- Step 4: Insert the book into the cart as an item with quantity 1
INSERT INTO cart_item (cart_id, book_id, quantity, unit_price) 
VALUES ((SELECT MAX(cart_id) FROM shopping_cart), 
        (SELECT book_id FROM book WHERE title = 'No Safe Place'), 
        1, 
        (SELECT price FROM book WHERE title = 'No Safe Place'));

-- 10. Add a new book titled “ICT128 Lab Manual” without a publisher.
-- Adding a new book without a publisher

ALTER TABLE book 
MODIFY author_id INT NULL;
INSERT INTO book (isbn, year, title, category, price, author_id, publisher_id) 
VALUES ('1234567890123', 2024, 'ICT128 Lab Manual', 'Education', 25.00, NULL, NULL);

-- End of script
-- THE END OF TASK 2



