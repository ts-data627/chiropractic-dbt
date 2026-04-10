# chiropractic-dbt
 
A dbt transformation layer built on top of a synthetic chiropractic clinic dataset, converting raw operational data into clean, tested, analysis-ready models for clinical and billing analytics.
 
Built as part of a self-directed career transition from chiropractic practice into data engineering. The underlying data was generated and loaded into AWS RDS PostgreSQL as part of a separate ETL pipeline project ([chiropractic-clinic-dashboard](https://github.com/ts-data627/chiropractic-clinic-dashboard)).
 
---
 
## Project Architecture
 
```
Raw Source Tables (AWS RDS PostgreSQL)
        │
        ▼
┌─────────────────────┐
│   Staging Layer     │  Cleans, casts, filters invalid rows
│   (dbt views)       │  One model per source table
└─────────────────────┘
        │
        ▼
┌─────────────────────┐
│    Mart Layer       │  Business logic, aggregations, derived metrics
│    (dbt tables)     │  Analysis-ready for BI tools or dashboards
└─────────────────────┘
```
 
---
 
## Models
 
### Staging Layer
 
| Model | Description |
|---|---|
| `stg_patients` | Cleaned patient records — casts, filters invalid rows, standardizes types |
| `stg_providers` | Cleaned provider records |
| `stg_appointments` | Cleaned appointments with derived `is_no_show` flag |
| `stg_billing` | Cleaned billing records with calculated `collection_rate` per claim |
 
### Mart Layer
 
| Model | Description |
|---|---|
| `dim_patients` | Patient dimension table with age buckets and demographics |
| `fct_appointments` | Appointment volume and no-show rates by provider, date, and service type |
| `fct_billing` | Revenue, collection rates, and claim counts by insurance type and service type |
 
---
 
## Tech Stack
 
- **dbt** — transformation layer, testing, documentation
- **PostgreSQL** — AWS RDS (same instance as source ETL pipeline)
- **Python** — source data generated and loaded via separate ETL pipeline
 
---
 
## Data Tests
 
22 tests across all 7 models covering:
 
- Primary key uniqueness and not-null constraints on all staging models
- Not-null constraints on all mart metrics
- Accepted values test on `age_bucket` in `dim_patients`
 
Run tests with:
 
```bash
dbt test
```
 
---
 
## How to Run
 
**Prerequisites**
- dbt Core installed (`pip install dbt-postgres`)
- Access to the AWS RDS PostgreSQL instance
- `~/.dbt/profiles.yml` configured with credentials
 
**Run all models**
```bash
dbt run
```
 
**Run tests**
```bash
dbt test
```
 
**Run models and tests together**
```bash
dbt build
```
 
---
 
## Source Data
 
The source tables (`patients`, `providers`, `appointments`, `billing`) were generated synthetically using Python's Faker library and loaded into AWS RDS PostgreSQL via a production-grade ETL pipeline. See [chiropractic-clinic-dashboard](https://github.com/ts-data627/chiropractic-clinic-dashboard) for full pipeline details.
 
---
 
## Stretch Goals
 
- Incremental materialization on `stg_appointments` and `stg_billing` as dataset grows
- Metabase or Streamlit dashboard connected directly to mart tables
- dbt documentation site via `dbt docs generate`
 
---
 
## Author
 
Tevin Sellers — [github.com/ts-data627](https://github.com/ts-data627) | [linkedin.com/in/tevin-s-ba030512b](https://linkedin.com/in/tevin-s-ba030512b)