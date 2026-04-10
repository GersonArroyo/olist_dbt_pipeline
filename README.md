# Olist dbt Pipeline

End-to-end data pipeline built with Python and dbt, using the Brazilian e-commerce dataset from Olist available on Kaggle.

## Data Sources

[Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle

## Architecture

```BASH
CSV Files → Python (ingestion) → BigQuery (raw) → dbt (staging/intermediate/marts) → Power BI
```

## Project Structure

<!-- TREE_START -->
```
$TREE
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

#### Intermediate

Reusable transformations shared across marts. Contains date calculations and delivery metrics.

#### Marts

Business-ready tables organized by domain:

- Commercial — orders, payments and product analysis
- Logistics — delivery performance and timing
- Customer Experience — reviews and satisfaction metrics
- Shared — dimensions used across multiple domains

## Order Flow

![Order Flow](docs/diagram-olist-dbt.drawio.svg)
