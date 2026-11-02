-- 8. BERAPA ANUAL USER YANG MEMAKAI WEB LEBIH DARI SEKALI.  48.366 ORANG
SELECT *
FROM website_sessions_bersih
WHERE total_kunjungan > 1
ORDER BY USER_ID;


-- 9. KAPAN WAKTU PALING BANYAK UNTUK BERKUNJUNG DALAM 24 JAM, DI JAM MANA

SELECT 
    HOUR(created_at) AS JAM_KUNJUNGAN,
    COUNT(website_session_id) AS total_kunjungan,
    COUNT(DISTINCT user_id) AS total_pengunjung_unik
FROM website_sessions_bersih -- (Ganti dengan nama tabel Anda yang sedang dipakai)
GROUP BY 
    HOUR(created_at)
ORDER BY 
    total_kunjungan DESC;



-- 10. PADA TANGGAL BERAPA PENGUNJUNG  PALING RAME
SELECT 
    DATE_FORMAT(created_at, '%D') AS TANGGAL_OPERASIONAL,
    COUNT(website_session_id) AS total_kunjungan,
    COUNT(DISTINCT user_id) AS total_pengunjung_unik
FROM website_sessions_bersih -- (Ganti dengan nama tabel Anda yang sedang dipakai)
GROUP BY 
    DATE_FORMAT(created_at, '%D')
ORDER BY 
    total_kunjungan DESC;
    
    
-- 11. PADA HARI APA YANG PALING SEPI
SELECT 
    DAYNAME(created_at) AS HARI_OPERASIONAL,
    COUNT(website_session_id) AS total_kunjungan,
    COUNT(DISTINCT user_id) AS total_pengunjung_unik
FROM website_sessions_bersih -- (Ganti dengan nama tabel Anda yang sedang dipakai)
GROUP BY 
    DAYNAME(created_at)
ORDER BY 
    total_kunjungan DESC;
    
    
    
-- 12. Tren jumlah pengunjung website dengan product yang terjual 



-- 13. Tingkat konversi pengunjung yang web hingga membeli

-- JUMLAH PENGUNJUNG KE WEB (472.871 PENGUNJUNG)
SELECT COUNT(DISTINCT website_session_id)
FROM website_pageviews; 

-- BANYAK PENGUNJUNG YANG CUMAN STOP DI HOME DAN LANDING PAGE (211.640)
WITH PAGEVIEWS AS
(
select *, 
row_number() over(partition by website_session_id) as page_keberapa, 
count(website_pageview_id) over(partition by website_session_id) as total_kunjungan_page
from website_pageviews 
)
SELECT COUNT(DISTINCT website_session_id)
FROM PAGEVIEWS
WHERE TOTAL_KUNJUNGAN_PAGE = 1; 

-- BANYAK PENGUNJUNG YANG SAMPE LAMAN PRODUCT (51.017)

WITH PAGEVIEWS AS
(
select *, 
row_number() over(partition by website_session_id) as page_keberapa, 
count(website_pageview_id) over(partition by website_session_id) as total_kunjungan_page
from website_pageviews 
)
SELECT COUNT(distinct WEBSITE_SESSION_ID) 
FROM PAGEVIEWS
WHERE TOTAL_KUNJUNGAN_PAGE = 2; 

-- BANYAK PENGUNJUNG YANG SAMPE PILIH PRODUCT (115.261)
WITH PAGEVIEWS AS
(
select *, 
row_number() over(partition by website_session_id) as page_keberapa, 
count(website_pageview_id) over(partition by website_session_id) as total_kunjungan_page
from website_pageviews
)
SELECT COUNT(distinct WEBSITE_SESSION_ID) 
FROM PAGEVIEWS
WHERE TOTAL_KUNJUNGAN_PAGE = 3; 


-- BANYAK PENGUNJUNG YANG SAMPE MASUKIN KERANJANG (30.469)
WITH PAGEVIEWS AS
(
select *, 
row_number() over(partition by website_session_id) as page_keberapa, 
count(website_pageview_id) over(partition by website_session_id) as total_kunjungan_page
from website_pageviews
)
SELECT COUNT(distinct WEBSITE_SESSION_ID) 
FROM PAGEVIEWS
WHERE TOTAL_KUNJUNGAN_PAGE = 4; 


-- BANYAK PENGUNJUNG YANG SAMPE SHIPPING (12.426)
WITH PAGEVIEWS AS
(
select *, 
row_number() over(partition by website_session_id) as page_keberapa, 
count(website_pageview_id) over(partition by website_session_id) as total_kunjungan_page
from website_pageviews
)
SELECT COUNT(distinct WEBSITE_SESSION_ID) 
FROM PAGEVIEWS
WHERE TOTAL_KUNJUNGAN_PAGE = 5; 

-- BANYAK PENGUNJUNG YANG SAMPE PEMBAYARAN  (19.745)
WITH PAGEVIEWS AS
(
select *, 
row_number() over(partition by website_session_id) as page_keberapa, 
count(website_pageview_id) over(partition by website_session_id) as total_kunjungan_page
from website_pageviews
)
SELECT COUNT(distinct WEBSITE_SESSION_ID) 
FROM PAGEVIEWS
WHERE TOTAL_KUNJUNGAN_PAGE = 6; 

WITH PAGEVIEWS AS
(
select *, 
row_number() over(partition by website_session_id) as page_keberapa, 
count(website_pageview_id) over(partition by website_session_id) as total_kunjungan_page
from website_pageviews 
)
SELECT *
FROM PAGEVIEWS
WHERE TOTAL_KUNJUNGAN_PAGE = 7; 

-- 14. marketing mana yang paling menarik banyak pelanggan 

SELECT * 
FROM website_sessions_bersih; 


SELECT 
    utm_source,
    utm_campaign,
    utm_content,
    COUNT(website_session_id) AS total_kunjungan,
    COUNT(DISTINCT user_id) AS pengunjung_unik
FROM website_sessions_bersih
GROUP BY 
    utm_source,
    utm_campaign,
    utm_content
ORDER BY 
    total_kunjungan DESC;
    
-- TINGKAT KONVERSI YANG AKHIRNYA MEMEBELI, ATAU EFEKTIFITAS IKLAN
SELECT 
    ws.utm_source,
    ws.utm_campaign,
    ws.utm_cotent,
    
-- 1. Mengukur Traffic (Banyaknya Orang yang Datang)
    COUNT(DISTINCT ws.user_id) AS total_pengunjung,    
-- 2. Mengukur Hasil Penjualan (Berapa Banyak Pesanan yang Terjadi)
    COUNT(DISTINCT o.order_id) AS total_pesanan,    
-- 3. Mengukur Tingkat Konversi (Persentase Pengunjung yang Berakhir Membeli)
    CONCAT(ROUND((COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.user_id)) * 100, 2), ' %') AS persentase_konversi
    
FROM website_sessions_bersih ws
LEFT JOIN orders o 
    ON ws.user_id = o.user_id
GROUP BY 
    ws.utm_source,
    ws.utm_campaign,
    ws.utm_content
ORDER BY 
    total_pesanan DESC; -- Mengurutkan dari penyumbang pesanan terbanyak




