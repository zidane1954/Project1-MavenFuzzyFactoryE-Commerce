SHOW VARIABLES LIKE 'secure_file_priv';
CREATE TABLE `order_item_refunds` (
  `order_item_refund_id` BIGINT NOT NULL,
  `created_at` DATETIME,
  `order_item_id` BIGINT,
  `order_id` BIGINT,
  `refund_amount_usd` DECIMAL(10,2),
  PRIMARY KEY (`order_item_refund_id`)
);

CREATE TABLE `order_items` (
  `order_item_id` BIGINT NOT NULL,
  `created_at` DATETIME,
  `order_id` BIGINT,
  `product_id` BIGINT,
  `is_primary_item` INT,
  `price_usd` DECIMAL(10,2),
  `cogs_usd` DECIMAL(10,2),
  PRIMARY KEY (`order_item_id`)
);

CREATE TABLE `orders` (
  `order_id` BIGINT NOT NULL,
  `created_at` DATETIME,
  `website_session_id` BIGINT,
  `user_id` BIGINT,
  `primary_product_id` BIGINT,
  `items_purchased` INT,
  `price_usd` DECIMAL(10,2),
  `cogs_usd` DECIMAL(10,2),
  PRIMARY KEY (`order_id`)
);

CREATE TABLE `products` (
  `product_id` BIGINT NOT NULL,
  `created_at` DATETIME,
  `product_name` VARCHAR(255),
  PRIMARY KEY (`product_id`)
);

CREATE TABLE `website_pageviews` (
  `website_pageview_id` BIGINT NOT NULL,
  `created_at` DATETIME,
  `website_session_id` BIGINT,
  `pageview_url` VARCHAR(255),
  PRIMARY KEY (`website_pageview_id`)
);


CREATE TABLE `website_sessions` (
  `website_session_id` BIGINT NOT NULL,
  `created_at` DATETIME,
  `user_id` BIGINT,
  `is_repeat_session` INT,
  `utm_source` VARCHAR(100),
  `utm_campaign` VARCHAR(100),
  `utm_content` VARCHAR(100),
  `device_type` VARCHAR(50),
  `http_referer` VARCHAR(255),
  PRIMARY KEY (`website_session_id`)
);






LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/website_pageviews.csv' 
INTO TABLE website_pageviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 LINES;


select * 
from website_pageviews;
