# FinSight | Finance Analysis

A Power BI finance dashboard and analysis project for exploring customer and transaction trends, KPI views, and reporting-ready datasets.

This repository includes:
- the Power BI project files (`.pbip`, `.Report`, `.SemanticModel`)
- source data files (`customers.csv`, `finance_transactions.csv`)
- a reproducible Python notebook for cleaning and analysis
- SQL KPI view definitions and optional Power Query scripts
- supporting design assets and business requirements

## Project structure

| Path | Purpose |
| --- | --- |
| `FINANACE ANALYSIS PROJECT.pbip` | Power BI project entry point |
| `FINANACE ANALYSIS PROJECT.Report/` | Power BI report definition |
| `FINANACE ANALYSIS PROJECT.SemanticModel/` | Semantic model definition |
| `customers.csv` | Customer dataset |
| `finance_transactions.csv` | Finance transaction dataset |
| `analysis/Finance_Analysis.ipynb` | Main Python workflow for cleaning, validation, and KPI generation |
| `analysis/sql/views.sql` | SQL KPI views used by the notebook |
| `analysis/power_query/` | Optional M-based Power Query alternatives |
| `analysis/README.md` | Data checks and SQL notes |
| `docs/Business Requirements.docx` | Business brief |
| `assets/source_images/` | Source visual assets |
| `archive/` | Local non-portfolio working materials |

## Quick start

### 1) Open the report
Open `FINANACE ANALYSIS PROJECT.pbip` in Power BI Desktop.

### 2) Run the Python analysis notebook
```powershell
python -m pip install -r analysis/requirements.txt
python -m jupyter lab
```
Then open `analysis/Finance_Analysis.ipynb` and run the cells in order.

The notebook creates local analysis outputs under `analysis/output/` such as cleaned data, SQLite DB files, quality checks, and charts. Those generated files are ignored by Git.

## Important notes

- `amount` is a signed transaction volume, not bank revenue.
- Blank fee values remain unknown.
- The Power BI model uses reporting-specific rules that may differ from the Python analysis logic.
- The notebook and M scripts do not modify the main report; they support analysis and validation.

## Repository status

This project is published to GitHub and tracks the main branch.
