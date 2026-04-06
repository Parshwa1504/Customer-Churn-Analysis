
-- =============================================
-- Customer Churn Analysis — SQL Queries
-- Author: Parshwa Shah
-- Dataset: IBM Telco Customer Churn
-- =============================================

-- Query 1: Overall churn rate
SELECT 
    Churn,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM customers
GROUP BY Churn
ORDER BY Churn DESC;

-- Query 2: Churn rate by contract type
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned,
    ROUND(SUM(Churn_Binary) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- Query 3: Churn rate by tenure band
SELECT 
    CASE 
        WHEN tenure BETWEEN 0  AND 12 THEN '0-12 months'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
        WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_band,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned,
    ROUND(SUM(Churn_Binary) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY tenure_band
ORDER BY churn_rate_pct DESC;

-- Query 4: Avg charges — churned vs retained
SELECT
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(TotalCharges), 2)   AS avg_total_charges,
    ROUND(AVG(tenure), 1)         AS avg_tenure_months,
    COUNT(*) AS customer_count
FROM customers
GROUP BY Churn;

-- Query 5: Churn rate by payment method
SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned,
    ROUND(SUM(Churn_Binary) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;
