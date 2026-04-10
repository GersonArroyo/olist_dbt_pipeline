# Olist dbt Pipeline

End-to-end data pipeline built with Python and dbt, using the Brazilian e-commerce dataset from Olist available on Kaggle.

## Objective

This project aims to simulate a real-world data pipeline for an e-commerce company, transforming raw transactional data into analytical datasets to support business decisions such as:

- Customer behavior analysis
- Delivery performance tracking
- Revenue and product insights

## Data Sources

[Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle

## Architecture

```BASH
CSV Files → Python (ingestion) → BigQuery (raw) → dbt (staging/intermediate/marts) → Power BI
```

## Project Structure

<!-- TREE_START -->
```
.
├── analyses
├── docs
│   └── diagram-olist-dbt.drawio.svg
├── macros
├── models
│   ├── intermediate
│   │   ├── _intermediate.yml
│   │   └── int_orders_enriched.sql
│   ├── marts
│   │   ├── commercial
│   │   ├── customer_experience
│   │   ├── logistics
│   │   └── shared
│   └── staging
│       ├── _src_olist.yml
│       ├── _src_olist__customers.yml
│       ├── _src_olist__geolocation.yml
│       ├── _src_olist__order_items.yml
│       ├── _src_olist__order_payments.yml
│       ├── _src_olist__order_reviews.yml
│       ├── _src_olist__orders.yml
│       ├── _src_olist__products.yml
│       ├── _src_olist__sellers.yml
│       ├── stg_olist__customers.sql
│       ├── stg_olist__geolocation.sql
│       ├── stg_olist__order_items.sql
│       ├── stg_olist__order_payments.sql
│       ├── stg_olist__order_reviews.sql
│       ├── stg_olist__orders.sql
│       ├── stg_olist__product_category_name_translation.sql
│       ├── stg_olist__products.sql
│       └── stg_olist__sellers.sql
├── seeds
├── snapshots
├── src
│   └── ingestion
│       └── load_bigquery.py
├── tests
├── README.md
├── dbt_project.yml
├── package-lock.yml
├── packages.yml
└── requirements.txt

17 directories, 27 files

```
<!-- TREE_END -->

## Datasets

| Layer        | Dataset              | Description            |
| ------------ | -------------------- | ---------------------- |
| Raw          | raw                  | CSV files loaded as-is |
| Staging      | olist_dev_staging    | Cleaned and renamed    |
| Marts        | olist_dev_marts      | Business-ready tables  |

## Documentation

[dbt docs](https://gersonarroyo.github.io/olist_dbt_pipeline/)

## How to Run

#### Prerequisites

- Python 3.x
- dbt 1.x
- Google Cloud account with BigQuery enabled

#### Setup

**1.** Clone the repository

```bash
git clone https://github.com/GersonArroyo/olist_dbt_pipeline.git
cd olist_dbt_pipeline
```

**2.** Install Python dependencies

```bash
pip install -r requirements.txt
```

**3.** Configure credentials

```bash
cp .env.example .env # Fill in your Google Cloud credentials path
```

**4.** Run ingestion

```bash
python src/ingestion/load_bigquery.py
```

**5.** Install dbt packages

```bash
dbt deps
```

**6.** Run dbt

```bash
dbt build
```

## Models

#### Staging

Cleans and standardizes raw data. One model per source table.

 - `_src` files define source metadata (dbt sources)
 - `stg_` models transform raw data into cleaned staging tables

#### Intermediate

Reusable transformations shared across marts. Contains date calculations and delivery metrics.

 - Order flow is a common transformation that can be used in other models.

#### Marts

Business-ready tables organized by domain:

 - Commercial — orders, payments and product analysis
 - Logistics — delivery performance and timing
 - Customer Experience — reviews and satisfaction metrics
 - Shared — dimensions used across multiple domains

## Future Improvements
> [!NOTE]
> Planned enhancements for this project:
> - Custom macros for reusable transformations
> - Data quality tests (schema + custom)
> - Snapshots for slowly changing dimensions (SCD Type 2)
> - Seeds for static reference data

## CI/CD

This project includes a CI/CD pipeline using GitHub Actions:

 - Pull Requests: run dbt tests for validation
 - Push to main: executes dbt build for deployment
 - Scheduled runs: automated dbt execution
 - Authentication with Google Cloud is handled via Workload Identity Federation (OIDC).

![GitHub Actions](https://github.com/GersonArroyo/olist_dbt_pipeline/actions/workflows/push.yml/badge.svg)

## Data Flow Diagram

![Order Flow](docs/diagram-olist-dbt.drawio.svg)
