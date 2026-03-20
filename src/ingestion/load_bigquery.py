from google.cloud import bigquery
from pathlib import Path
from dotenv import load_dotenv
import os

# Load environment variables from .env file, including GOOGLE_APPLICATION_CREDENTIALS for BigQuery authentication
load_dotenv()

# Directories and credentials
BASE_DIR = Path(__file__).resolve().parent.parent.parent
DATA_DIR = BASE_DIR / "data"

# BigQuery configuration
PROJECT_ID = "exalted-bonus-488516-k0"   # ID From BigQuery
DATASET_ID = "raw"                       # Dataset where the tables will be created  

# Create BigQuery client
client = bigquery.Client.from_service_account_json(os.getenv("GOOGLE_APPLICATION_CREDENTIALS"))

# Configure the load job
job_config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.CSV,                     # File format
    skip_leading_rows=1,                                         # Skip the header row
    autodetect=True,                                             # Let BigQuery auto-detect the schema
    write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,  # Overwrite the table if it already exists
    allow_quoted_newlines=True,                                  # Handle newlines within quoted fields, e. g., in descriptions
    allow_jagged_rows=True,                                      # Handle rows with missing columns, e. g., in geolocation data
)

# Load each CSV file in the data directory into BigQuery
for file in DATA_DIR.glob("*.csv"):
    table_id = f"{PROJECT_ID}.{DATASET_ID}.{file.stem}"
    
    # Load the CSV file into BigQuery
    with open(file, "rb") as f:
        job = client.load_table_from_file(f, table_id, job_config=job_config)
    
    job.result() # Await the job to complete
    print(f"✅ {file.name} → {table_id} ({job.output_rows} linhas)") # Log the result of the load job
    