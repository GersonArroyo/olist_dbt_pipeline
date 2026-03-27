
# Olist dbt Pipeline

End-to-end data pipeline built with Python and dbt, using the Brazilian e-commerce dataset from Olist available on Kaggle.


## Data Sources

[Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle


## Architecture

```BASH
CSV Files → Python (ingestion) → BigQuery (raw) → dbt (staging/intermediate/marts) → Power BI
```


## Project Structure

```bash

olist_dbt_pipeline/
├── src/
│   └── ingestion/
│       └── load_bigquery.py    # Loads CSV files into BigQuery raw dataset
├── models/
│   ├── staging/                # Data cleaning and renaming
│   ├── intermediate/           # Reusable transformations
│   └── marts/
│       ├── commercial/         # Revenue and sales analysis
│       ├── logistics/          # Delivery performance analysis
│       ├── customer_experience/# Reviews and satisfaction analysis
│       └── shared/             # Shared dimensions
└── dbt_project.yml

```


## Datasets

| Layer   | Dataset     | Description            |
| ------- | ----------- | ---------------------- |
| Raw     | raw         | CSV files loaded as-is |
| Staging | olist_dev   | Cleaned and renamed    |
| Marts   | olist_dev_* | Business-ready tables  |


## How to Run

#### Prerequisites

- Python 3.x
- dbt 1.x
- Google Cloud account with BigQuery enabled

#### Setup

**1.** Clone the repository

```bash
clone https://github.com/GersonArroyo/olist_dbt_pipeline.git
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
