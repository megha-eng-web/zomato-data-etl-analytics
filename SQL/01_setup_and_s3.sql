-- ============================================================
-- 01_setup_and_s3.sql
-- Zomato Data ETL & Analytics Pipeline
-- ============================================================
-- Purpose:
--   Create the Snowflake database/schema, configure the AWS S3
--   storage integration, create the external stage and CSV file format,
--   and validate access to the S3 source file.
--
-- SECURITY:
--   The original AWS IAM role ARN has been replaced with a placeholder.
--   Never commit AWS access keys, secret keys, passwords or other secrets.
-- ============================================================

CREATE DATABASE IF NOT EXISTS ZOMATO_PROJECT;
CREATE SCHEMA IF NOT EXISTS ZOMATO_PROJECT.RAW;

CREATE OR REPLACE STORAGE INTEGRATION ZOMATO_S3_INTEGRATION
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = '<YOUR_AWS_IAM_ROLE_ARN>'
  STORAGE_ALLOWED_LOCATIONS = ('s3://zomato-bucket-1122/');

  DESC INTEGRATION ZOMATO_S3_INTEGRATION;

  ALTER STORAGE INTEGRATION ZOMATO_S3_INTEGRATION
SET STORAGE_AWS_ROLE_ARN = '<YOUR_AWS_IAM_ROLE_ARN>';

CREATE OR REPLACE STAGE ZOMATO_PROJECT.RAW.MANAGE_STAGE
  URL = 's3://zomato-bucket-1122/'
  STORAGE_INTEGRATION = ZOMATO_S3_INTEGRATION;

  DESC STAGE ZOMATO_PROJECT.RAW.MANAGE_STAGE;


  SELECT SYSTEM$VALIDATE_STORAGE_INTEGRATION(
    'ZOMATO_S3_INTEGRATION',
    's3://zomato-bucket-1122/',
    'zomato.csv',
    'read'
);

LIST @ZOMATO_PROJECT.RAW.MANAGE_STAGE;
LIST @RAW.ZOMATO_STAGE;

DESC STAGE ZOMATO_PROJECT.RAW.MANAGE_STAGE;

CREATE OR REPLACE FILE FORMAT ZOMATO_PROJECT.RAW.ZOMATO_CSV_FORMAT
  TYPE = 'CSV'
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  SKIP_HEADER = 1
  MULTI_LINE = TRUE
  TRIM_SPACE = TRUE
  NULL_IF = ('', 'NULL', 'null');


  SELECT
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    t.$5,
    t.$6,
    t.$7,
    t.$8,
    t.$9,
    t.$10,
    t.$11,
    t.$12,
    t.$13,
    t.$14,
    t.$15,
    t.$16,
    t.$17
FROM @ZOMATO_PROJECT.RAW.MANAGE_STAGE/zomato.csv
(
    FILE_FORMAT => 'ZOMATO_PROJECT.RAW.ZOMATO_CSV_FORMAT'
) t
LIMIT 3;
