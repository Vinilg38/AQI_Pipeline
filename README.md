# AQI Data Pipeline with dbt, Airflow, and PostgreSQL

### Project Overview

This project demonstrates a complete, end-to-end data pipeline built using a modern data stack. The goal is to ingest raw Air Quality Index (AQI) data from a static source, transform it using a **Medallion Architecture**, and orchestrate the entire workflow with **Apache Airflow**.

The final, aggregated data is stored in a clean format, ready for analysis and visualization in a business intelligence (BI) tool. This project showcases proficiency in data modeling, data quality testing, and workflow automation.

### The Dataset

The dataset used in this pipeline is the [India Air Quality Index (AQI) Dataset 2023-2025](https://www.kaggle.com/datasets/saikiranudayana/india-air-quality-index-aqi-dataset-20232025), sourced from Kaggle. It contains daily records of air pollutant concentrations, AQI values, and air quality status for various cities and states in India.

### Data Architecture: The Medallion Approach

The pipeline is structured using a three-tiered Medallion Architecture, ensuring that data is progressively cleaned and enriched at each stage.

* **Bronze Layer (Raw):** This is the ingestion layer where the raw `aqi.csv` file is loaded into a PostgreSQL database with no transformations. The original data is preserved as a historical record. This layer is created using **dbt seeds**.

* **Silver Layer (Cleaned & Standardized):** This layer takes the raw data from the Bronze layer and applies cleaning and standardization rules. It involves tasks such as:
    * Casting data types (e.g., date strings to a proper `DATE` type).
    * Handling missing values.
    * Standardizing column names.
    * Adding data quality tests (e.g., checking for duplicates and NULL values).

* **Gold Layer (Enriched & Aggregated):** This is the final layer, where the cleaned data from the Silver layer is aggregated for business intelligence and reporting. It includes models for:
    * Monthly average AQI values by city and state.
    * Counting the number of "Poor" air quality days.
    * These tables are optimized for fast querying and are directly consumed by the visualization service.

---
### Setup and Execution

To run this project, you need to have **dbt**, **PostgreSQL**, and **Apache Airflow** installed locally or configured in the cloud.

1.  **Set up your environment:**
    * Configure your PostgreSQL database (local or cloud-hosted).
    * The database is hosted on Supabase, providing a permanent and accessible endpoint for the dashboard.
    * Update the `profiles.yml` file with your Supabase database credentials.
    * Run `dbt deps` to install the necessary packages.

2.  **Run the pipeline manually:**
    * Load the raw data: `dbt seed`
    * Run the transformations: `dbt run`
    * Test the data quality: `dbt test`

3.  **Automate with Airflow:**
    * Set your `AIRFLOW_HOME` and start Airflow's services.
    * The `aqi.py` DAG will then automate all three dbt commands in the correct order.

---
### Dashboard

The final dashboard, built on the database, provides a clear overview of AQI trends over time and a geographic breakdown of air quality across India. **By connecting this dashboard to the Supabase-hosted database, the visualizations are always online and accessible to anyone, demonstrating a robust, production-ready pipeline.**

**[View the Live Dashboard Here](https://lookerstudio.google.com/reporting/9b3c68af-730d-4579-be6b-cf13fd437763)**
