-- ============================================================
-- CASE 2: OTP by Route & Time-of-Day
-- JetBlue SOC Interview Prep
-- Run this entire file in MySQL Workbench to set up + load data
-- ============================================================

CREATE DATABASE IF NOT EXISTS jetblue_soc;
USE jetblue_soc;

DROP TABLE IF EXISTS flight_ops;
CREATE TABLE flight_ops (
    flight_date     DATE,
    flight_num      VARCHAR(10),
    origin          VARCHAR(3),
    dest            VARCHAR(3),
    dep_hour        INT,
    arr_delay_min   INT
);

INSERT INTO flight_ops VALUES
('2024-01-08','B6 415','JFK','LAX',6,42),
('2024-01-08','B6 416','JFK','LAX',6,38),
('2024-01-08','B6 101','JFK','BOS',7,5),
('2024-01-08','B6 102','JFK','BOS',7,8),
('2024-01-08','B6 200','JFK','FLL',8,12),
('2024-01-08','B6 201','JFK','FLL',8,-3),
('2024-01-08','B6 300','JFK','MCO',9,22),
('2024-01-08','B6 301','JFK','MCO',9,18),
('2024-01-08','B6 400','JFK','SFO',10,5),
('2024-01-08','B6 401','JFK','SFO',10,-2),
('2024-01-08','B6 500','JFK','LAX',14,55),
('2024-01-08','B6 501','JFK','LAX',14,61),
('2024-01-08','B6 502','JFK','LAX',14,48),
('2024-01-08','B6 600','JFK','BOS',15,8),
('2024-01-08','B6 601','JFK','BOS',15,3),
('2024-01-08','B6 700','JFK','FLL',16,30),
('2024-01-08','B6 701','JFK','FLL',16,28),
('2024-01-08','B6 800','JFK','MCO',19,18),
('2024-01-08','B6 801','JFK','MCO',19,22),
('2024-01-08','B6 900','JFK','LAX',20,14),
('2024-01-09','B6 415','JFK','LAX',6,18),
('2024-01-09','B6 416','JFK','LAX',6,22),
('2024-01-09','B6 101','JFK','BOS',7,3),
('2024-01-09','B6 102','JFK','BOS',7,-1),
('2024-01-09','B6 200','JFK','FLL',8,6),
('2024-01-09','B6 300','JFK','MCO',9,35),
('2024-01-09','B6 301','JFK','MCO',9,28),
('2024-01-09','B6 400','JFK','SFO',10,-4),
('2024-01-09','B6 500','JFK','LAX',14,72),
('2024-01-09','B6 501','JFK','LAX',14,65),
('2024-01-09','B6 502','JFK','LAX',14,58),
('2024-01-09','B6 600','JFK','BOS',15,4),
('2024-01-09','B6 700','JFK','FLL',16,38),
('2024-01-09','B6 701','JFK','FLL',16,41),
('2024-01-09','B6 800','JFK','MCO',19,25),
('2024-01-09','B6 900','JFK','LAX',20,8),
('2024-01-10','B6 415','JFK','LAX',6,8),
('2024-01-10','B6 101','JFK','BOS',7,2),
('2024-01-10','B6 200','JFK','FLL',8,-2),
('2024-01-10','B6 300','JFK','MCO',9,12),
('2024-01-10','B6 400','JFK','SFO',10,6),
('2024-01-10','B6 500','JFK','LAX',14,44),
('2024-01-10','B6 501','JFK','LAX',14,50),
('2024-01-10','B6 600','JFK','BOS',15,2),
('2024-01-10','B6 700','JFK','FLL',16,20),
('2024-01-10','B6 800','JFK','MCO',19,30),
('2024-01-10','B6 900','JFK','LAX',20,5),
('2024-01-10','B6 102','BOS','JFK',22,62),
('2024-01-10','B6 103','BOS','JFK',23,78),
('2024-01-10','B6 104','BOS','JFK',23,55);

-- ============================================================
-- VERIFY: should return 50 rows
SELECT COUNT(*) AS total_rows FROM flight_ops;

-- PREVIEW
SELECT * FROM flight_ops LIMIT 10;

-- ============================================================
-- YOUR TASK — write a query that:
-- 1. Buckets flights by time-of-day (morning/afternoon/evening/red-eye)
-- 2. Computes OTP% (arr_delay_min < 15) per route + time bucket
-- 3. Ranks routes within each bucket by worst OTP
-- 4. Returns the bottom 10 route-bucket combos

-- HINT: start with the bucketing CTE below, then build up
-- SELECT
--   origin, dest,
--   CASE
--     WHEN dep_hour BETWEEN 5  AND 11 THEN 'morning'
--     WHEN dep_hour BETWEEN 12 AND 17 THEN 'afternoon'
--     WHEN dep_hour BETWEEN 18 AND 21 THEN 'evening'
--     ELSE 'red-eye'
--   END AS time_bucket,
--   COUNT(*) AS total_flights,
--   SUM(CASE WHEN arr_delay_min < 15 THEN 1 ELSE 0 END) AS on_time_flights
-- FROM flight_ops
-- GROUP BY 1, 2, 3;
-- ============================================================
