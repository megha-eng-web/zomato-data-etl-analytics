<!-- # Zomato Data ETL & Analytics Pipeline

An end-to-end data engineering and business analytics project built using **AWS S3, Snowflake, SQL, dimensional modeling, and Power BI**. The project processes Zomato restaurant data, performs data cleaning and transformation, builds a star schema, generates business analytics, exports analytical results to S3, and presents insights through an interactive Power BI dashboard.

---

## 📌 Project Overview

This project demonstrates a complete data pipeline starting from raw Zomato restaurant data and ending with business intelligence dashboards.

The pipeline uses **AWS S3 as cloud storage** and **Snowflake as the data warehouse**. Raw data is ingested from S3 into Snowflake, cleaned and transformed using SQL, modeled using a dimensional star schema, and analyzed through business-focused SQL queries.

The resulting analytical datasets are exported back to S3 and visualized using **Microsoft Power BI**.

---

## 🎯 Project Objectives

* Build an end-to-end cloud-based ETL pipeline.
* Store and manage raw data using AWS S3.
* Integrate AWS S3 with Snowflake using an external stage.
* Perform data cleaning and transformation using SQL.
* Implement a dimensional **Star Schema**.
* Perform data quality checks and validation.
* Generate meaningful business analytics.
* Export analytical results back to S3.
* Build an interactive Power BI dashboard.
* Document the complete data engineering workflow.

---

## 🏗️ Architecture

```text
                 ZOMATO RAW DATA
                       │
                       ▼
                ┌─────────────┐
                │   AWS S3    │
                │ Raw Storage │
                └──────┬──────┘
                       │
                       ▼
             ┌───────────────────┐
             │     Snowflake     │
             │   External Stage  │
             └─────────┬─────────┘
                       │
                       ▼
             ┌───────────────────┐
             │    Raw Layer      │
             │  STAGE_RAW_DATA   │
             └─────────┬─────────┘
                       │
                       ▼
             ┌───────────────────┐
             │ Cleaning &        │
             │ Transformation    │
             └─────────┬─────────┘
                       │
                       ▼
             ┌───────────────────┐
             │    Star Schema    │
             ├───────────────────┤
             │ Dim Restaurant    │
             │ Dim Location      │
             │ Dim Cuisine       │
             │ Dim Type          │
             │ Fact Restaurant   │
             └─────────┬─────────┘
                       │
                       ▼
             ┌───────────────────┐
             │ Business Analytics│
             │      using SQL    │
             └───────┬─────┬─────┘
                     │     │
                     ▼     ▼
                AWS S3    Power BI
                Exports   Dashboard
```

---

## 🛠️ Technology Stack

| Technology               | Purpose                                          |
| ------------------------ | ------------------------------------------------ |
| **AWS S3**               | Cloud object storage for raw and analytical data |
| **Snowflake**            | Cloud data warehouse                             |
| **SQL**                  | ETL, transformation, validation and analytics    |
| **Dimensional Modeling** | Star schema design                               |
| **Power BI**             | Data visualization and dashboarding              |
| **CSV**                  | Source and exported analytical data              |

---

## 📊 Dataset

The project uses a Zomato restaurant dataset containing restaurant-level information such as:

* Restaurant name
* Location
* Rating
* Votes
* Approximate cost
* Cuisine
* Restaurant type
* Online ordering availability
* Table booking availability
* Listed restaurant type
* Other restaurant attributes

The processed dataset contains approximately **51,717 restaurant records**.

> The original large dataset is not included in this repository. It was uploaded to AWS S3 and processed through the pipeline.

---

# 🔄 ETL Pipeline

## 1. Data Ingestion

The raw Zomato dataset was uploaded to an **AWS S3 bucket**.

S3 acts as the initial cloud storage layer for the pipeline.

```text
Zomato CSV
    ↓
AWS S3
```

---

## 2. Snowflake Integration

Snowflake was connected to AWS S3 using a **Storage Integration** and **External Stage**.

```text
AWS S3
   ↓
Snowflake External Stage
```

The external stage allows Snowflake to access the files stored in S3.

---

## 3. Raw Data Loading

The raw dataset was loaded into Snowflake using `COPY INTO`.

A raw table was created to preserve the source data before transformation.

```text
S3
 ↓
External Stage
 ↓
STAGE_RAW_DATA
```

---

## 4. Data Cleaning & Transformation

SQL transformations were applied to prepare the dataset for analytics.

Key operations included:

* Removing unnecessary whitespace using `TRIM`
* Handling numeric conversion using `TRY_TO_NUMBER`
* Extracting values using `SPLIT_PART`
* Handling missing values
* Standardizing fields
* Converting rating, vote and cost fields into appropriate numeric formats
* Preparing data for dimensional modeling

---

# ⭐ Star Schema

The cleaned data was transformed into a dimensional **Star Schema**.

```text
                  DIM_LOCATION
                       │
                       │
                       ▼
DIM_CUISINE ───► FACT_RESTAURANT ◄─── DIM_TYPE
                       ▲
                       │
                       │
                DIM_RESTAURANT
```

### Dimension Tables

#### `DIM_RESTAURANT`

Contains restaurant-level descriptive information.

#### `DIM_LOCATION`

Contains location-related information.

#### `DIM_CUISINE`

Contains cuisine information.

#### `DIM_TYPE`

Contains restaurant/type-related attributes.

### Fact Table

#### `FACT_RESTAURANT`

Contains measurable restaurant metrics such as:

* Rating
* Votes
* Approximate cost
* Restaurant count
* Online ordering status
* Table booking status

---

# 🔍 Data Quality & Validation

Data quality checks were performed before generating analytical results.

The validation process included:

* Record count validation
* NULL value checks
* Duplicate checks
* Numeric value validation
* Rating range validation
* Cost validation
* Dimension/fact relationship validation
* Comparison of source and transformed record counts
* KPI validation

These checks helped ensure that the transformed data was reliable for downstream analytics.

---

# 📈 Business Analytics

SQL-based business analytics were developed on top of the dimensional model.

Key analytical questions included:

### 🏆 Restaurant Performance

* Which restaurants have the highest ratings?
* Which restaurants receive the most votes?
* Which locations contain the largest number of restaurants?

### 🍛 Cuisine Analysis

* Which cuisines are most common?
* Which cuisines have the highest ratings?
* How does average cost vary across cuisines?

### 💰 Cost Analysis

* What is the average restaurant cost?
* Which restaurant types are more expensive?
* Which cuisines provide lower-cost dining options?

### 📱 Online Ordering

* What percentage of restaurants support online ordering?
* How does online ordering vary across locations?

### 🪑 Table Booking

* How many restaurants support table booking?
* What is the distribution of restaurants with and without table booking?

### ⭐ Rating & Votes

* How are restaurants distributed across vote categories?
* What locations and restaurant types receive higher engagement?

---

# 📊 Key KPIs

The final analytical layer produced the following overall KPIs:

| KPI                      |       Value |
| ------------------------ | ----------: |
| Total Restaurants        |  **51,717** |
| Average Rating           |    **3.70** |
| Average Votes            |     **284** |
| Average Approximate Cost | **₹555.43** |

---

# 📊 Power BI Dashboard

The analytical results were connected to **Microsoft Power BI** to create an interactive dashboard.

The dashboard includes:

* Total restaurant count
* Average rating
* Average votes
* Average approximate cost
* Restaurant count by location
* Online order distribution
* Cuisine distribution
* Vote category analysis
* Restaurant type analysis
* Table booking analysis

### Dashboard Preview

Add the dashboard screenshot to this repository and update the filename below if necessary:

```text
![Zomato Power BI Dashboard](dashboard/dashboard_screenshot.png)
```

---

# ☁️ S3 Analytics Export

After generating the business analytics, selected analytical results were exported from Snowflake back to AWS S3 as CSV files.

```text
Snowflake Analytics
        ↓
     COPY INTO
        ↓
      AWS S3
        ↓
 Analytical CSV Files
```

This demonstrates both **data ingestion into the warehouse** and **analytical data export from the warehouse**.

---

# 📁 Repository Structure

```text
zomato-data-etl-analytics/
│
├── README.md
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_s3_stage_setup.sql
│   ├── 03_raw_data_load.sql
│   ├── 04_data_cleaning.sql
│   ├── 05_star_schema.sql
│   ├── 06_data_quality.sql
│   ├── 07_validation.sql
│   ├── 08_analytics.sql
│   └── 09_s3_export.sql
│
├── architecture/
│   └── zomato_pipeline_architecture.png
│
├── dashboard/
│   ├── Zomato_Dashboard.pbix
│   └── dashboard_screenshot.png
│
├── screenshots/
│   ├── s3_bucket.png
│   ├── snowflake_tables.png
│   ├── snowflake_analytics.png
│   ├── star_schema.png
│   └── s3_export.png
│
├── documentation/
│   └── Zomato_Project_Documentation.pdf
│
└── data/
    └── README.md
```

---

# 🔐 Data & Security

The original large dataset is not included in the repository.

No credentials or secrets should be committed to GitHub.

The following must never be uploaded:

* AWS Access Keys
* AWS Secret Keys
* Snowflake passwords
* `.env` files containing credentials
* Private account information

---

# 🚀 Future Improvements

Possible future improvements include:

* Automating the pipeline using Apache Airflow
* Incremental data ingestion
* Automated data-quality monitoring
* Scheduled Snowflake transformations
* Real-time or near-real-time restaurant data
* Advanced Power BI drill-through reports
* Predictive restaurant rating analysis
* Customer/review sentiment analysis
* Automated dashboard refresh

---

# 💡 Key Learning Outcomes

This project provided practical experience in:

* Cloud data storage with AWS S3
* Snowflake data warehousing
* ETL and ELT workflows
* SQL-based data transformation
* Data quality and validation
* Dimensional modeling
* Star schema design
* Business analytics
* Data visualization with Power BI
* Analytical data export
* End-to-end data engineering architecture

---

# 👩‍💻 Project Status

| Component           | Status         |
| ------------------- | -------------- |
| AWS S3              | ✅ Completed    |
| Snowflake           | ✅ Completed    |
| ETL                 | ✅ Completed    |
| Data Cleaning       | ✅ Completed    |
| Star Schema         | ✅ Completed    |
| Data Quality        | ✅ Completed    |
| Validation          | ✅ Completed    |
| S3 Analytics Export | ✅ Completed    |
| Business Analytics  | ✅ Completed    |
| Power BI Dashboard  | ✅ Completed    |
| GitHub Repository   | 🚧 In Progress |
| Documentation       | 🚧 In Progress |

---

## 📌 Conclusion

The Zomato Data ETL & Analytics Pipeline demonstrates a complete workflow for transforming raw restaurant data into reliable, business-ready insights.

The project combines **AWS S3, Snowflake, SQL, dimensional modeling and Power BI** to implement an end-to-end data engineering and analytics solution.

The final dashboard enables users to explore restaurant distribution, cuisine trends, ratings, votes, costs, online ordering and table-booking patterns from the processed dataset. -->
