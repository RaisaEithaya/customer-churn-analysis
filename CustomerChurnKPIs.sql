CREATE TABLE churn_data (
    customerid TEXT,
    gender TEXT,
    seniorcitizen TEXT,
    partner TEXT,
    dependents TEXT,
    tenure INT,
    phoneservice TEXT,
    multiplelines TEXT,
    internetservice TEXT,
    onlinesecurity TEXT,
    onlinebackup TEXT,
    deviceprotection TEXT,
    techsupport TEXT,
    streamingtv TEXT,
    streamingmovies TEXT,
    contract TEXT,
    paperlessbilling TEXT,
    paymentmethod TEXT,
    monthlycharges NUMERIC(10,2),
    totalcharges NUMERIC(10,2),
    churn TEXT
);
select * from churn_data

--Total number of customers
select count(*) as total_customers
from churn_data

--Churn count (churn = 'Yes')
select count(*) as churned_customers
from churn_data
where churn ='Yes'

--Churn rate %
SELECT 
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS churn_rate
FROM churn_data;

--Avg monthly charges
select avg(monthlycharges) as avg_monthly_charges
from churn_data

--Total revenue
select sum(totalcharges) as total_revenue
from churn_data

--Churn by contract type
SELECT contract, churn, COUNT(*) AS customer_count
FROM churn_data
GROUP BY contract, churn
ORDER BY contract, churn;

--Churn by tenure
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-12'
        WHEN tenure <= 24 THEN '13-24'
        ELSE '25+'
    END AS tenure_group,
    churn,
    COUNT(*) AS customer_count
FROM churn_data
GROUP BY tenure_group, churn
ORDER BY tenure_group;

--Avg monthly charges (churn vs non-churn)
select count(*) as customer_count, churn, Avg(monthlycharges) as avg_monthly_charges
from churn_data
group by churn

--Customers by payment method
select count(*) as customer_count,paymentmethod,
from churn_data
group by paymentmethod

--Internet service vs churn
select churn,internetservice,count(*) as customer_count
from churn_data
group by internetservice,churn
order by internetservice, churn;

--Churn rate by contract
SELECT 
    contract,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*) AS churn_rate
FROM churn_data
GROUP BY contract;

--Revenue by churn
SELECT 
    churn,
    SUM(totalcharges) AS total_revenue
FROM churn_data
GROUP BY churn;

--High-risk customers 
SELECT 
    churn,
    COUNT(*) AS customer_count
FROM churn_data
WHERE tenure < 12 AND monthlycharges > 70
GROUP BY churn;