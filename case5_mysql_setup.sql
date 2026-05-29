-- ============================================================
-- CASE 5: Misconnect Risk Identification
-- JetBlue SOC Interview Prep
-- Run this entire file in MySQL Workbench to set up + load data
-- ============================================================

USE jetblue_soc;   -- reuses the database from case 2 setup

DROP TABLE IF EXISTS bookings;
CREATE TABLE bookings (
    pax_id           VARCHAR(10),
    inbound_flight   VARCHAR(10),
    outbound_flight  VARCHAR(10),
    connect_airport  VARCHAR(3)
);

DROP TABLE IF EXISTS flight_ops_c5;
CREATE TABLE flight_ops_c5 (
    flight_num          VARCHAR(10),
    arr_time_actual     DATETIME,
    dep_time_scheduled  DATETIME,
    arr_delay_min       INT,
    status              VARCHAR(20)
);

INSERT INTO bookings VALUES
('PAX001','B6 415','B6 500','JFK'),
('PAX002','B6 415','B6 501','JFK'),
('PAX003','B6 415','B6 502','JFK'),
('PAX004','B6 302','B6 600','JFK'),
('PAX005','B6 302','B6 601','JFK'),
('PAX006','B6 302','B6 700','JFK'),
('PAX007','B6 302','B6 701','JFK'),
('PAX008','B6 118','B6 800','JFK'),
('PAX009','B6 118','B6 801','JFK'),
('PAX010','B6 340','B6 900','JFK'),
('PAX011','B6 340','B6 901','JFK'),
('PAX012','B6 340','B6 902','JFK'),
('PAX013','B6 611','B6 500','JFK'),
('PAX014','B6 611','B6 501','JFK'),
('PAX015','B6 201','B6 600','JFK'),
('PAX016','B6 201','B6 700','JFK'),
('PAX017','B6 887','B6 800','JFK'),
('PAX018','B6 887','B6 900','JFK');

INSERT INTO flight_ops_c5 VALUES
('B6 415', '2024-01-16 09:42:00','2024-01-16 06:00:00',42,'arrived'),
('B6 302', '2024-01-16 10:18:00','2024-01-16 06:30:00',108,'arrived'),
('B6 118', '2024-01-16 08:55:00','2024-01-16 07:00:00',12,'arrived'),
('B6 340', '2024-01-16 09:52:00','2024-01-16 07:15:00',37,'arrived'),
('B6 611', '2024-01-16 10:44:00','2024-01-16 12:00:00',0,'arrived'),
('B6 201', '2024-01-16 08:10:00','2024-01-16 08:00:00',0,'arrived'),
('B6 887', '2024-01-16 07:55:00','2024-01-16 13:30:00',0,'arrived'),
('B6 500', NULL,'2024-01-16 10:15:00',0,'scheduled'),
('B6 501', NULL,'2024-01-16 10:30:00',0,'scheduled'),
('B6 502', NULL,'2024-01-16 10:45:00',0,'scheduled'),
('B6 600', NULL,'2024-01-16 11:00:00',0,'scheduled'),
('B6 601', NULL,'2024-01-16 11:30:00',0,'scheduled'),
('B6 700', NULL,'2024-01-16 11:45:00',0,'scheduled'),
('B6 701', NULL,'2024-01-16 12:00:00',0,'scheduled'),
('B6 800', NULL,'2024-01-16 10:00:00',0,'scheduled'),
('B6 801', NULL,'2024-01-16 10:15:00',0,'scheduled'),
('B6 900', NULL,'2024-01-16 10:30:00',0,'scheduled'),
('B6 901', NULL,'2024-01-16 10:45:00',0,'scheduled'),
('B6 902', NULL,'2024-01-16 11:00:00',0,'scheduled');

-- ============================================================
-- VERIFY
SELECT COUNT(*) AS bookings_rows  FROM bookings;       -- expect 18
SELECT COUNT(*) AS flight_rows    FROM flight_ops_c5;  -- expect 19

-- ============================================================
-- YOUR TASK — write a query that:
-- 1. Joins bookings to flight_ops_c5 twice (inbound + outbound)
-- 2. Computes available connect time in minutes
--    MySQL hint: TIMESTAMPDIFF(MINUTE, arr_time_actual, dep_time_scheduled)
-- 3. Flags pax where connect_time < 45 AND inbound delay >= 15
-- 4. Counts impacted pax by outbound flight, orders by most at risk

-- MYSQL-SPECIFIC NOTE:
-- Use TIMESTAMPDIFF(MINUTE, start, end) instead of DATEDIFF('minute',...)
-- which is Snowflake/Redshift syntax.

-- EXPECTED RESULT: B6 302 passengers (PAX004-007) should dominate the output
-- because B6 302 had a 108-minute delay — those pax have almost no connect time.
-- ============================================================
