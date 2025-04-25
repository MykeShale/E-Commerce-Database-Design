-- Database creation
CREATE DATABASE ecommerce;
USE ecommerce;

-- 1. Table to store product images
CREATE TABLE product_image (
    product_image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- 2. Table to store color options
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL
);

-- 3. Table to store product categories
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- 4. Table to store products
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL,
    brand_id INT,
    category_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- 5. Table to store product items (specific purchasable items with variations)
CREATE TABLE product_item (
    product_item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    stock_quantity INT NOT NULL DEFAULT 0,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- 6. Table to store brand data
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL
);

-- 7. Table to store product variations (e.g., color, size)
CREATE TABLE product_variation (
    product_variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

-- 8. Table to store size categories (e.g., clothing, shoe sizes)
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_name VARCHAR(100) NOT NULL
);

-- 9. Table to store specific size options (e.g., S, M, L, 42)
CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT,
    size_option_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- 10. Table to store custom product attributes (e.g., material, weight)
CREATE TABLE product_attribute (
    product_attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    attribute_id INT,
    attribute_value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_id) REFERENCES attribute_type(attribute_id)
);

-- 11. Table to store attribute categories (e.g., physical, technical)
CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- 12. Table to define types of attributes (e.g., text, number, boolean)
CREATE TABLE attribute_type (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    attribute_name VARCHAR(100) NOT NULL,
    attribute_type VARCHAR(50) NOT NULL, -- E.g., 'text', 'number', 'boolean'
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES attribute_category(attribute_category_id)
);