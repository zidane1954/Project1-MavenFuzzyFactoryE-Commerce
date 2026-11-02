-- Coba Cleaning Data Dulu


select *
from order_items
where order_item_id !=  order_id
;

select * from products;


-- banyak orang yang repurchase barang sama (344), 13 orang belanja sampe 3 kali dg barang yang sama
with duplicate_cte as
(
select *, 
row_number() over (partition by user_id, primary_product_id) as kunjungan_ulang
from orders
)
select  distinct count(*) 
from duplicate_cte
where kunjungan_ulang > 2;


-- banyak orang belanja lagi disini (617), terus ada 26bornag yang belanja lebih 3 kali berulang
with duplicate_cte as
(
select *, 
row_number() over (partition by user_id) as kunjungan_ulang
from orders
)
select  distinct count(*) 
from duplicate_cte
where kunjungan_ulang > 2;


select * 
from orders o
join products p
	ON o.primary_product_id = p.product_id
;
-- 40000
select COUNT(*) 
from order_items;

-- 32000
select COUNT(*) 
from orders;


select * 
from website_sessions;

-- CLEAR GADA DUPLICATE DAN NULL
WITH DUPLICATE_REFUNDS AS 
(Select * , 
ROW_NUMBER() OVER(PARTITION BY order_item_id) AS ROW_NUM
FROM order_item_refunds
)
Select *  
FROM DUPLICATE_REFUNDS
WHERE ROW_NUM > 1
; 

-- GADA DUPLICATE DAN GADA NULL, TAPI ADA YANG NGE ORDER , NANTI DI BENERIN
WITH DUPLICATE_ORDERITEMS AS
(
SELECT * ,
ROW_NUMBER () OVER (PARTITION BY ORDER_ITEM_ID) AS ROW_NUM
FROM ORDER_ITEMS
)
SELECT *
FROM DUPLICATE_ORDERITEMS
WHERE ROW_NUM > 1
; 


SELECT * 
FROM order_items
WHERE order_item_id IS NULL 
	OR created_at IS NULL 
    OR ORDER_ID IS NULL 
    OR PRODUCT_ID IS NULL
    OR is_primary_item IS NULL
    OR price_usd IS NULL
    OR cogs_usd IS NULL
;


-- GADA DUPLICATE DAN GADA YANG NULL, NANTI TOLONG DI PISAHIN PER ID BUAT NYARI BERAPA ORANG YANG , DAN APAKAH JAM NYA SAMA 
SELECT * ,row_number() OVER (PARTITION BY ORDER_ID, USER_ID)
FROM ORDERS
ORDER BY 9 DESC
;

SELECT * 
FROM ORDERS
WHERE order_id IS NULL 
	OR created_at IS NULL 
    OR website_session_id IS NULL 
    OR user_id IS NULL
	OR primary_product_id IS NULL 
    OR items_purchased IS NULL 
    OR price_usd IS NULL 
    OR cogs_usd IS NULL 
;

-- AMAN GADA FUPLICATE ATAU NULL 
SELECT * 
FROM PRODUCTS; 
 -- GADA DUPLICATE SAMA GADA NULL
SELECT * , 
ROW_NUMBER() OVER(partition by website_pageview_id, website_session_id)
FROM website_pageviews
ORDER BY 5 DESC; 


SELECT COUNT(*) 
FROM website_sessions
WHERE (utm_source LIKE  'NULL' OR http_referer LIKE 'NULL') AND is_repeat_session = 0
; 

SELECT * 
FROM website_sessions 
 ; 

CREATE TABLE `website_sessions2` (
  `website_session_id` bigint NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `is_repeat_session` int DEFAULT NULL,
  `utm_source` varchar(100) DEFAULT NULL,
  `utm_campaign` varchar(100) DEFAULT NULL,
  `utm_content` varchar(100) DEFAULT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `http_referer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`website_session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



SELECT * 
FROM website_sessions2; 


INSERT INTO website_sessions2
SELECT * 
FROM website_sessions; 



CREATE TABLE `website_sessions_bersih` (
  `website_session_id` bigint NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `is_repeat_session` int DEFAULT NULL,
  `utm_source` varchar(100) DEFAULT NULL,
  `utm_campaign` varchar(100) DEFAULT NULL,
  `utm_content` varchar(100) DEFAULT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `http_referer` varchar(255) DEFAULT NULL,
  `kunjungan_ke` int default null, 
  `total_kunjungan` int default null, 
  PRIMARY KEY (`website_session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert into website_sessions_bersih 
WITH DataKunjungan AS (
    SELECT 
        *, 
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY created_at ASC) AS kunjungan_ke,
        COUNT(website_session_id) OVER(PARTITION BY user_id) AS total_kunjungan
    FROM website_sessions
)
SELECT website_session_id, created_at, 
    user_id,
    is_repeat_session,
-- Mengubah string 'NULL' menjadi NULL asli, lalu mengambil data dari kunjungan pertama
    COALESCE(
        NULLIF(utm_source, 'NULL'), 
        FIRST_VALUE(NULLIF(utm_source, 'NULL')) OVER(PARTITION BY user_id ORDER BY created_at ASC)
    ) AS utm_source,    
    COALESCE(
        NULLIF(utm_campaign, 'NULL'), 
        FIRST_VALUE(NULLIF(utm_campaign, 'NULL')) OVER(PARTITION BY user_id ORDER BY created_at ASC)
    ) AS utm_campaign,
    COALESCE(
        NULLIF(utm_content, 'NULL'), 
        FIRST_VALUE(NULLIF(utm_content, 'NULL')) OVER(PARTITION BY user_id ORDER BY created_at ASC)
    ) AS utm_content,
    device_type,
    COALESCE(
        NULLIF(http_referer, 'NULL'), 
        FIRST_VALUE(NULLIF(http_referer, 'NULL')) OVER(PARTITION BY user_id ORDER BY created_at ASC)
    ) AS http_referer,
    kunjungan_ke,
    total_kunjungan
FROM DataKunjungan
;

select * 
from website_sessions
where is_repeat_session = 0 and utm_source is null
; 


-- CEK ADA DATA ANEH APA ENGGA
SELECT * FROM products ; 

SELECT * 
FROM ORDERS 
WHERE PRIMARY_PRODUCT_ID = 4 AND CREATED_AT < '2014-02-05 10:00:00';




CREATE TABLE `website_sessions_bersih_banget` (
  `website_session_id` bigint NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `is_repeat_session` int DEFAULT NULL,
  `utm_source` varchar(100) DEFAULT NULL,
  `utm_campaign` varchar(100) DEFAULT NULL,
  `utm_content` varchar(100) DEFAULT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `http_referer` varchar(255) DEFAULT NULL,
  `kunjungan_ke` int DEFAULT NULL,
  `total_kunjungan` int DEFAULT NULL,
  PRIMARY KEY (`website_session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- ngubah string NULL menjadi nilai NUll yang sebenarnya

insert into website_sessions_bersih 
WITH DataKunjungan AS (
    SELECT 
        *, 
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY created_at ASC) AS kunjungan_ke,
        COUNT(website_session_id) OVER(PARTITION BY user_id) AS total_kunjungan
    FROM website_sessions
)
SELECT website_session_id, created_at, 
    user_id,
    is_repeat_session,
-- Mengubah string 'NULL' menjadi NULL asli, lalu mengambil data dari kunjungan pertama
    COALESCE(
        NULLIF(utm_source, '%NULL%'), 
        FIRST_VALUE(NULLIF(utm_source, 'NULL')) OVER(PARTITION BY user_id ORDER BY created_at ASC)
    ) AS utm_source,    
    COALESCE(
        NULLIF(utm_campaign, 'NULL'), 
        FIRST_VALUE(NULLIF(utm_campaign, 'NULL')) OVER(PARTITION BY user_id ORDER BY created_at ASC)
    ) AS utm_campaign,
    COALESCE(
        NULLIF(utm_content, 'NULL'), 
        FIRST_VALUE(NULLIF(utm_content, 'NULL')) OVER(PARTITION BY user_id ORDER BY created_at ASC)
    ) AS utm_content,
    device_type,
    COALESCE(
        NULLIF(http_referer, 'NULL'), 
        FIRST_VALUE(NULLIF(http_referer, 'NULL')) OVER(PARTITION BY user_id ORDER BY created_at ASC)
    ) AS http_referer,
    kunjungan_ke,
    total_kunjungan
FROM DataKunjungan;


delete from website_sessions_bersih
where total_kunjungan = 1 and (utm_campaign is null or utm_content is null or utm_source is null); 

select count(*)
from website_sessions_bersih
where total_kunjungan = 1 and (utm_campaign is null or utm_content is null or utm_source is null); 

select * 
from website_sessions_bersih
where utm_campaign is null; 
; 





SELECT website_session_id, created_at, 
    user_id,
    is_repeat_session, utm_source,
    COALESCE(
		utm_source, 
        FIRST_VALUE(utm_source) OVER(PARTITION BY user_id ORDER BY created_at ASC)
    ) AS utm_source_new,  utm_campaign , 
    COALESCE(
        utm_campaign, 
        FIRST_VALUE(utm_campaign) OVER(PARTITION BY user_id ORDER BY created_at ASC)
    ) AS utm_campaign_new, utm_content,
    COALESCE(
        utm_content, 
        FIRST_VALUE(utm_content) OVER(PARTITION BY user_id ORDER BY created_at ASC, website_session_id ASC)
    ) AS utm_content_new,
    device_type, http_referer, 
    COALESCE(
		http_referer,
		FIRST_VALUE(http_referer) OVER (PARTITION BY user_id ORDER BY created_at ASC, website_session_id ASC)
	)  AS http_referer_new,
    kunjungan_ke,
    total_kunjungan
FROM website_sessions_bersih
;

select * 
from website_sessions_bersih
where is_repeat_session = 1 and utm_campaign is null; 

