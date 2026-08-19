-- ============================================================
-- 05_data_quality_and_validation.sql
-- Zomato Data ETL & Analytics Pipeline
-- ============================================================
-- Purpose:
--   Validate row counts, duplicates, dimension/fact relationships,
--   orphan keys and overall KPI consistency.
-- ============================================================

SELECT
    COUNT(*) AS TOTAL_ROWS,
    COUNT_IF(RESTAURANT_ID IS NULL) AS MISSING_RESTAURANT,
    COUNT_IF(LOCATION_ID IS NULL) AS MISSING_LOCATION,
    COUNT_IF(CUISINE_ID IS NULL) AS MISSING_CUISINE,
    COUNT_IF(TYPE_ID IS NULL) AS MISSING_TYPE
FROM FACT_RESTAURANT;
