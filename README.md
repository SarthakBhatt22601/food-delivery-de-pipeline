# Food Delivery Data Engineering Pipeline

An end-to-end data engineering pipeline using AWS S3, Snowflake, Snowpipe, dbt, and Apache Airflow to transform food delivery data into analytics-ready fact, dimension, and mart tables.

## Architecture

```text
Source CSV Files
      ↓
   AWS S3
      ↓
  Snowpipe
      ↓
Snowflake RAW
      ↓
    dbt
      ↓
Staging → Fact / Dimension → Analytics Marts
      ↑
   Airflow
```

## Tech Stack

- AWS S3 — source data storage
- Snowflake — cloud data warehouse
- Snowpipe — automated S3-to-Snowflake ingestion
- dbt — SQL transformations, modeling, and data quality tests
- Apache Airflow — scheduling and orchestration
- SQL / Python / Docker

## Pipeline

### 1. Data Ingestion

Food delivery source data is stored as CSV files in Amazon S3. Snowpipe with `AUTO_INGEST` automatically loads newly arrived files into Snowflake RAW tables.

Source datasets include:

- Restaurants
- Users
- Food
- Menu
- Orders
- Order Items
- Reviews

### 2. dbt Transformation

dbt transforms the RAW data through staging and analytical models.

```text
RAW
 ↓
STAGING
 ↓
FACT / DIMENSION
 ↓
MARTS
```

Staging models handle data cleaning and standardization. Fact and dimension models provide the core analytical data model.

The project also uses incremental dbt models with the `MERGE` strategy for order and order-item data.

### 3. Analytics Marts

Business-focused marts are created for:

- Daily city revenue
- Delivery SLA / delivery performance
- Restaurant performance

These models provide analytics-ready data for downstream reporting.

### 4. Data Quality

dbt tests are used to validate the transformed data, including:

- `unique`
- `not_null`
- `relationships`
- `accepted_values`

### 5. Airflow

Apache Airflow is used to schedule and orchestrate the dbt workflow.

The Airflow DAG executes `dbt build`, which runs the dbt models and associated tests.

Airflow is run locally using Docker.

## Snowflake Layers

```text
FOOD_DLV
├── RAW
├── STAGING
└── MARTS
```

## Repository Structure

```text
food-delivery-de-pipeline/
├── aws/
├── Snowflake_scripts/
├── airflow/
├── food_dlv_dbt/
│   ├── models/
│   │   ├── staging/
│   │   └── marts/
│   └── dbt_project.yml
└── README.md
```

## Key Concepts

- S3 and Snowflake integration
- Snowpipe AUTO_INGEST
- RAW / STAGING / MART architecture
- dbt models and `ref()` dependencies
- Incremental dbt models
- dbt data quality tests
- Fact and dimension modeling
- Apache Airflow DAGs and scheduling
- Dockerized Airflow

## Outcome

This project demonstrates an end-to-end modern data engineering workflow from cloud-based data ingestion to transformation, orchestration, and analytics-ready data models.
