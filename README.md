# Jaffle Shop dbt Project

A simple dbt project showcasing dbt documentation features using the classic Jaffle Shop dataset with a local Postgres database.

## Project Structure

```
.
├── models/
│   ├── staging/          # Staging models (views)
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   ├── stg_payments.sql
│   │   └── schema.yml
│   └── marts/            # Business logic models (tables)
│       ├── customer_orders.sql
│       ├── order_summary.sql
│       └── schema.yml
├── seeds/
│   ├── raw_customers.csv
│   ├── raw_orders.csv
│   └── raw_payments.csv
├── docker-compose.yml
├── dbt_project.yml
└── profiles.yml
```

## Setup Instructions

### 1. Start the Postgres Database

```bash
docker-compose up -d
```

This will start a Postgres database with:
- Host: localhost
- Port: 5432
- Database: jaffle_shop
- User: dbt_user
- Password: dbt_password

### 2. Install dbt

If you haven't already installed dbt with Postgres support:

```bash
pip install dbt-postgres
```

### 3. Set up dbt Profile

Copy the `profiles.yml` file to your `~/.dbt/` directory:

```bash
mkdir -p ~/.dbt
cp profiles.yml ~/.dbt/profiles.yml
```

Or simply use the local profiles.yml by running dbt with `--profiles-dir .`

### 4. Run dbt

```bash
# Load seed data
dbt seed --profiles-dir .

# Run staging models
dbt run --select staging --profiles-dir .

# Run all models
dbt run --profiles-dir .

# Run tests
dbt test --profiles-dir .

# Generate documentation
dbt docs generate --profiles-dir .

# Serve documentation site
dbt docs serve --profiles-dir .
```

## Data Model

### Staging Layer
- **stg_customers**: Customer dimension with basic info
- **stg_orders**: Order facts with customer references
- **stg_payments**: Payment transactions linked to orders

### Marts Layer
- **customer_orders**: Customer-level aggregation showing lifetime value, order count, and key dates
- **order_summary**: Order-level summary with payment breakdown by method

## Features Highlighted

This project demonstrates:
- Basic dbt project structure with staging and mart layers
- Data modeling with CTEs and aggregations
- Documentation in `schema.yml` files
- Data quality tests (unique, not_null, accepted_values)
- Seeds for sample data
- Docker-based development environment

## Cleaning Up

To stop and remove the database:

```bash
docker-compose down -v
```