# Finance analysis

Open [Finance_Analysis.ipynb](Finance_Analysis.ipynb) and run it from top to bottom. This is the only Python source file for the analysis. It reads the root CSVs without changing them, cleans them, builds `output/finance.sqlite` from [SQL views](sql/views.sql), and creates static and optional interactive visualizations. The saved notebook includes the PNG result and the verified KPI output.

## Cleaning policy and quality

The raw transaction file has 50,069 rows. There are 68 excess exact duplicate rows and one inspected `transaction_id` conflict (`T00000009`); the row with observed fee 21.19 is retained. The cleaned table has 50,000 unique transactions. The customer table has 5,000 unique customers. IDs remain text, dates are parsed as `dd-mm-yyyy`, `fisrt_name` becomes `first_name` only in the derived data, amount signs remain intact, and blank fees remain unknown.

The review found 23 blank fees, eight negative amounts, zero orphan transaction/customer keys, 1,017 customers without transactions, and 9,333 transactions dated before the customer's `join_date`. The date-order cases require business review; the notebook flags them but does not silently delete them. 2026 stops in April, so compare years using the same month window.

Reference totals: signed transaction amount INR 455,391,141.16, known fees INR 725,914.91, tax INR 130,736.35. The notebook recalculates these and checks them against the SQLite KPI view. SQLite uses floating-point `REAL` for exploration and rounds view output; the cleaning audit uses `Decimal`.

## SQL views

`v_kpi_overview` covers the main counts, signed amount, average, observed fees, tax, success rate, and data-quality flags. `v_monthly_trends` gives the time series. `v_status_breakdown`, `v_customer_segment`, `v_state_top5`, `v_transaction_type`, `v_channel_performance`, and `v_risk_quality` support visual and business breakdowns. Unless a view says otherwise, it includes all transaction statuses. `v_state_top5` spans the **full dataset**.

## Power Query

The `.m` files in `power_query/` are optional alternatives, **not** applied to the live model. Define a Text parameter `pDataFolder` ending in a backslash before using them. `Finance_Date_Audit.m` expects queries named `finance_transactions` and `customers`. Review before replacing existing Power Query steps.

The notebook's Plotly HTML cell is optional when Plotly is unavailable; Pillow generates the PNG regardless. To run the Plotly cell, install `analysis/requirements.txt`.
