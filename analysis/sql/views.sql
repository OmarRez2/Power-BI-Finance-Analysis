-- SQLite views over the Python-cleaned tables. Amounts remain signed.
-- All statuses are included unless a view explicitly filters them.
DROP VIEW IF EXISTS v_kpi_overview;
DROP VIEW IF EXISTS v_monthly_trends;
DROP VIEW IF EXISTS v_status_breakdown;
DROP VIEW IF EXISTS v_customer_segment;
DROP VIEW IF EXISTS v_state_top5;
DROP VIEW IF EXISTS v_transaction_type;
DROP VIEW IF EXISTS v_channel_performance;
DROP VIEW IF EXISTS v_risk_quality;

CREATE VIEW v_kpi_overview AS
SELECT
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_amount_inr,
    ROUND(AVG(amount), 2) AS avg_transaction_value_inr,
    ROUND(SUM(fee_amount), 2) AS known_fees_inr,
    ROUND(SUM(tax_amount), 2) AS tax_inr,
    SUM(transaction_status = 'Success') AS successful_transactions,
    ROUND(100.0 * SUM(transaction_status = 'Success') / NULLIF(COUNT(*), 0), 2) AS success_rate_pct,
    SUM(fee_amount IS NULL) AS transactions_with_missing_fee,
    SUM(amount < 0) AS transactions_with_negative_amount
FROM transactions;

CREATE VIEW v_monthly_trends AS
SELECT substr(transaction_date, 1, 7) AS month,
       COUNT(*) AS transactions,
       ROUND(SUM(amount), 2) AS total_amount_inr,
       ROUND(AVG(amount), 2) AS avg_transaction_value_inr,
       SUM(transaction_status = 'Success') AS successful_transactions
FROM transactions GROUP BY substr(transaction_date, 1, 7);

CREATE VIEW v_status_breakdown AS
SELECT transaction_status, COUNT(*) AS transactions,
       ROUND(SUM(amount), 2) AS total_amount_inr,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM transactions), 2) AS transaction_share_pct
FROM transactions GROUP BY transaction_status;

CREATE VIEW v_customer_segment AS
SELECT c.customer_segment, COUNT(t.transaction_id) AS transactions,
       COUNT(DISTINCT t.customer_id) AS transacting_customers,
       ROUND(SUM(t.amount), 2) AS total_amount_inr
FROM customers AS c LEFT JOIN transactions AS t ON t.customer_id = c.customer_id
GROUP BY c.customer_segment;

CREATE VIEW v_state_top5 AS
SELECT c.state, COUNT(*) AS transactions, ROUND(SUM(t.amount), 2) AS total_amount_inr
FROM transactions AS t JOIN customers AS c ON c.customer_id = t.customer_id
GROUP BY c.state ORDER BY total_amount_inr DESC LIMIT 5;

CREATE VIEW v_transaction_type AS
SELECT transaction_type, COUNT(*) AS transactions,
       ROUND(SUM(amount), 2) AS total_amount_inr,
       ROUND(SUM(fee_amount), 2) AS known_fees_inr,
       ROUND(SUM(tax_amount), 2) AS tax_inr
FROM transactions GROUP BY transaction_type;

CREATE VIEW v_channel_performance AS
SELECT channel, COUNT(*) AS transactions,
       ROUND(SUM(amount), 2) AS total_amount_inr,
       ROUND(100.0 * SUM(transaction_status = 'Success') / NULLIF(COUNT(*), 0), 2) AS success_rate_pct
FROM transactions GROUP BY channel;

CREATE VIEW v_risk_quality AS
SELECT is_fraud, transaction_status, COUNT(*) AS transactions,
       ROUND(AVG(risk_score), 2) AS avg_recorded_risk_score,
       SUM(fee_amount IS NULL) AS transactions_with_missing_fee
FROM transactions GROUP BY is_fraud, transaction_status;
