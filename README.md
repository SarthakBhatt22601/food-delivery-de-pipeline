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

- AWS S3 — Cloud object storage for source CSV files
- Snowflake — Cloud data warehouse
- Snowpipe — Automated S3-to-Snowflake ingestion
- dbt — SQL transformations, modeling, and data quality tests
- Apache Airflow — Scheduling and Pipeline orchestration
- Python — Airflow DAG and supporting pipeline configuration
- SQL — Data transformation and Snowflake development
- Docker — Local Airflow environment

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
│
├── aws/
│   ├── iam/
│   └── s3_uplod.txt
│
├── Snowflake_scripts/
│   ├── setup.sql
│   ├── Storage_Integration.sql
│   ├── Stage_and_Formats.sql
│   ├── Raw_Tables.sql
│   └── Snowpipe.sql
│
├── airflow/
│   ├── dags/
│   │   └── food_dlv_batch.py
│   ├── Dockerfile
│   ├── docker-compose.yaml
│   └── example.env
│
├── food_dlv_dbt/
│   ├── models/
│   │   ├── staging/
│   │   └── marts/
│   ├── macros/
│   ├── dbt_project.yml
│   └── README.md
│
├── .gitignore
└── README.md
```

## Key Concepts

- AWS S3 object storage
- Snowpipe AUTO_INGEST
- Snowflake integration
- S3 event notifications
- RAW / STAGING / MART architecture
- dbt models and `ref()` dependencies
- Incremental dbt models
- dbt data quality tests
- Fact and dimension modeling
- Apache Airflow DAGs and scheduling
- Dockerized Airflow

## Outcome

The project demonstrates an end-to-end modern data engineering workflow, from cloud-based source ingestion through transformation and orchestration to analytics-ready data models.
It also provides hands-on experience with dbt and Apache Airflow while building on existing knowledge of SQL, Snowflake, AWS S3, Python, and ETL workflows.
