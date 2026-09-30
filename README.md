# Advanced SQL Operations Analytics

## Project Overview

This project demonstrates an end-to-end SQL analytics workflow using MySQL on a healthcare claims operations dataset.

The project focuses on operational reporting, KPI analysis, advanced SQL techniques, and systematic data-quality validation. It was designed to demonstrate practical SQL skills relevant to Data Operations Analyst and Data Analyst roles.

## Dataset

- **Records:** 2,975 healthcare claims
- **Database:** MySQL 8.0
- **Domain:** Healthcare claims operations
- **Key entities:** Claims, patients, providers, payers, claim status, financial amounts, dates, and QA indicators

The dataset is used for analytical and portfolio demonstration purposes.

## SQL Skills Demonstrated

### Data Profiling
- Record counts
- Distinct patients, providers, and payers
- Missing-value checks
- Claim-status distributions
- Financial summaries

### Common Table Expressions (CTEs)
- Reusable analytical transformations
- Multi-stage KPI calculations
- Payer-level denial-rate analysis
- Monthly operational analysis

### Window Functions
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `LAG()`
- `LEAD()`
- `NTILE()`

Applications include:

- Latest claim identification
- Provider ranking
- Month-over-month analysis
- Trend comparison
- Billing segmentation

### Advanced Aggregation
- `GROUP BY`
- `ROLLUP`
- Conditional aggregation
- Multi-dimensional operational summaries

### Recursive CTE
A recursive CTE was implemented to reconstruct an organizational hierarchy from employee-manager relationships.

### Data Quality & Exception Detection

The project includes SQL checks for:

- Duplicate claim IDs
- Missing payer information
- Missing denial reasons
- Negative financial values
- Paid amount greater than allowed amount
- Submission dates before service dates
- Other operational data-quality exceptions

## Key Analyses

### 1. Payer Performance

Payer-level claim volumes, denied claims, and denial rates were calculated to support operational comparison.

### 2. Provider Ranking

Providers were ranked according to total paid amounts using:

- `RANK()`
- `DENSE_RANK()`

### 3. Monthly Trend Analysis

Monthly claim volumes were analyzed using:

- `LAG()`
- `LEAD()`
- Month-over-month change calculations

### 4. Claim Segmentation

Claims were divided into four billing segments using `NTILE(4)` to identify different billing-value groups.

### 5. Data Quality Analysis

Automated SQL checks were developed to identify potentially problematic records and operational exceptions.

### 6. Payer × Claim Status Analysis

`ROLLUP` was used to produce hierarchical summaries across payer and claim status.

### 7. Organizational Hierarchy

A recursive CTE was used to generate employee reporting levels from manager relationships.

### 8. Integrated Operations Analysis

A multi-stage SQL workflow combines:

- Monthly payer metrics
- Denial rates
- Previous-month comparison
- Denial-rate changes
- Monthly payer ranking

## Selected Data-Quality Findings

The implemented validation queries identified examples of:

| Data-quality issue | Records |
|---|---:|
| Duplicate Claim IDs | 35 |
| Missing Payer | 30 |
| Negative Financial Values | 15 |
| Paid > Allowed Amount | 22 |
| Submission Before Service Date | 28 |
| Denied Claim Missing Denial Reason | 25 |

These checks demonstrate how SQL can be used for operational quality assurance and exception reporting.

## Project Structure

```text
advanced-sql-operations-analytics/
│
├── data/
│   └── healthcare_claims_operations.csv
│
├── outputs/
│   ├── 01_data_profile.csv
│   ├── 02_cte_analysis.csv
│   ├── 03_window_functions.csv
│   ├── 04_segmentation.csv
│   ├── 05_data_quality_checks.csv
│   ├── 06_rollup_analysis.csv
│   ├── 07_recursive_cte.csv
│   └── 08_operations_case_study.csv
│
├── screenshots/
│   ├── 01_data_profile.png
│   ├── 02_cte_analysis.png
│   ├── 03_window_functions.png
│   ├── 04_segmentation.png
│   ├── 05_data_quality_checks.png
│   ├── 06_rollup_analysis.png
│   ├── 07_recursive_cte.png
│   └── 08_operations_case_study.png
│
├── sql/
│   ├── 01_data_profile.sql
│   ├── 02_cte_analysis.sql
│   ├── 03_window_functions.sql
│   ├── 04_segmentation.sql
│   ├── 05_data_quality_checks.sql
│   ├── 06_rollup_analysis.sql
│   ├── 07_recursive_cte.sql
│   └── 08_operations_case_study.sql
│
├── LICENSE
└── README.md
## Author

**Nazmul Al Hossen**

Data Analyst | SQL | Python | Statistics

