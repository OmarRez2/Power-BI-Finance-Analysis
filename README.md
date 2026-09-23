# FinSight | Finance Analysis

Power BI finance project with one reproducible Jupyter Notebook for Python cleaning, SQLite KPI views, and visualization. Open `FINANACE ANALYSIS PROJECT.pbip` in Power BI Desktop. Keep the two raw CSVs at the project root: the existing model references their current location.

## Folder map

| Path | Purpose |
| --- | --- |
| `FINANACE ANALYSIS PROJECT.pbip`, `.Report/`, `.SemanticModel/` | Original Power BI project |
| `customers.csv`, `finance_transactions.csv` | Original source data; unchanged |
| `analysis/Finance_Analysis.ipynb` | **The single Python workflow**: clean, validate, build SQL, visualize |
| `analysis/sql/views.sql` | KPI view definitions used by the notebook |
| `analysis/power_query/` | Optional reviewed Power Query M alternatives |
| `analysis/preview.png` | Sample static result |
| `docs/Business Requirements.docx` | Original business brief |
| `assets/source_images/` | Original design images; report has its own embedded resources |
| `archive/Course_Materials/` | Local course drafts, excluded from Git |

## Run the notebook

Install Python 3.11+ and dependencies, then open `analysis/Finance_Analysis.ipynb` in JupyterLab or VS Code and run cells top to bottom:

```powershell
python -m pip install -r analysis/requirements.txt
python -m jupyter lab
```

Start Jupyter from this project folder. The notebook can also run from `analysis/`; if launched elsewhere, set `FINANCE_PROJECT_ROOT` to this folder. It writes cleaned CSVs, `quality_report.json`, `finance.sqlite`, a PNG chart, and an interactive Plotly HTML to `analysis/output/`. That output is local and ignored by Git. Query the database with `SELECT * FROM v_kpi_overview;` or the other views in `analysis/sql/views.sql`.

`amount` is signed transaction **volume**, not bank revenue. Blank fees remain unknown. The current Power BI model uses different rules (absolute amount and filling blank fees with `14.52`), so its dashboard figures will differ until its Power Query steps are deliberately updated. The notebook and M alternatives do **not** change the report. See [analysis/README.md](analysis/README.md) for data checks and SQL definitions.

Local Git is initialized; no commit, remote, or upload has been made.
