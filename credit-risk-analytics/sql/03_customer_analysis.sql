USE credit_risk_analytics;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Loan_ID) AS unique_loans,
    SUM(Loan_Amount) AS total_loan_amount,
    MIN(Loan_Amount) AS minimum_loan_amount,
    MAX(Loan_Amount) AS maximum_loan_amount
FROM credit_risk;

SELECT
    Loan_Status,
    COUNT(*) AS loan_count,
    SUM(Loan_Amount) AS portfolio_value
FROM credit_risk
GROUP BY Loan_Status;

SELECT
    Loan_Exposure_Category,
    COUNT(*) AS loan_count,
    SUM(Loan_Amount) AS portfolio_value
FROM credit_risk
GROUP BY Loan_Exposure_Category
ORDER BY loan_count DESC;

SELECT
    SUM(Loan_Amount) AS overall_portfolio,

    (
        SELECT SUM(Loan_Amount)
        FROM credit_risk
        WHERE Loan_Status = 'Default'
    ) +
    (
        SELECT SUM(Loan_Amount)
        FROM credit_risk
        WHERE Loan_Status = 'Approved'
    ) AS status_portfolio,

    (
        SELECT SUM(Loan_Amount)
        FROM credit_risk
        WHERE Loan_Exposure_Category = 'Low'
    ) +
    (
        SELECT SUM(Loan_Amount)
        FROM credit_risk
        WHERE Loan_Exposure_Category = 'Moderate'
    ) +
    (
        SELECT SUM(Loan_Amount)
        FROM credit_risk
        WHERE Loan_Exposure_Category = 'High'
    ) +
    (
        SELECT SUM(Loan_Amount)
        FROM credit_risk
        WHERE Loan_Exposure_Category = 'Very High'
    ) +
    (
        SELECT SUM(Loan_Amount)
        FROM credit_risk
        WHERE Loan_Exposure_Category = 'Extreme'
    ) AS exposure_portfolio;
    
    -- check status against exposure 
SELECT
    Loan_Status,
    Loan_Exposure_Category,
    COUNT(*) AS loan_count,
    SUM(Loan_Amount) AS portfolio_value
FROM credit_risk
GROUP BY
    Loan_Status,
    Loan_Exposure_Category
ORDER BY
    Loan_Status,
    portfolio_value DESC;
    
-- check whether status and exposure are logically consistent 
SELECT
    Loan_Status,
    Loan_Exposure_Category,
    COUNT(*) AS loan_count
FROM credit_risk
GROUP BY
    Loan_Status,
    Loan_Exposure_Category;
    
-- find the approval loans 

SELECT
    Loan_ID,
    Customer_ID,
    Loan_Status,
    Loan_Amount,
    Annual_Income,
    Credit_Score,
    Debt_to_Income_Ratio,
    Loan_to_Income_Ratio,
    Loan_Exposure_Category
FROM credit_risk
WHERE Loan_Status = 'Approved'
ORDER BY Loan_Amount DESC;

-- check whether loan_status and default_risk_flag agree
SELECT
    Default_Risk_Flag,
    Loan_Status,
    COUNT(*) AS loan_count,
    SUM(Loan_Amount) AS portfolio_value
FROM credit_risk
GROUP BY
    Default_Risk_Flag,
    Loan_Status
ORDER BY
    Default_Risk_Flag;
    
-- Customer Financial Profile

SELECT
    Credit_Score_Category,
    COUNT(DISTINCT Customer_ID) AS customers,
    ROUND(AVG(Age), 2) AS average_age,
    ROUND(AVG(Annual_Income), 2) AS average_income,
    ROUND(AVG(Account_Balance), 2) AS average_balance,
    ROUND(AVG(Credit_Score), 2) AS average_credit_score,
    ROUND(AVG(Existing_Loans_Count), 2) AS average_existing_loans,
    ROUND(AVG(Dependents), 2) AS average_dependents
FROM credit_risk
GROUP BY Credit_Score_Category
ORDER BY
    CASE Credit_Score_Category
        WHEN 'Poor' THEN 1
        WHEN 'Fair' THEN 2
        WHEN 'Good' THEN 3
        WHEN 'Very Good' THEN 4
        WHEN 'Excellent' THEN 5
    END;
-- Risk by Employment Type
SELECT
    Employment_Type,
    COUNT(*) AS customers,
    SUM(Loan_Amount) AS portfolio_value,
    ROUND(AVG(Annual_Income), 2) AS average_income,
    ROUND(AVG(Credit_Score), 2) AS average_credit_score,
    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti,
    ROUND(AVG(Loan_to_Income_Ratio), 2) AS average_loan_to_income
FROM credit_risk
GROUP BY Employment_Type
ORDER BY portfolio_value DESC;

-- risk by education
SELECT
    Education_Level,
    COUNT(*) AS customers,
    SUM(Loan_Amount) AS portfolio_value,
    ROUND(AVG(Annual_Income), 2) AS average_income,
    ROUND(AVG(Credit_Score), 2) AS average_credit_score,
    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti
FROM credit_risk
GROUP BY Education_Level
ORDER BY portfolio_value DESC;

-- risk by age group
SELECT
    CASE
        WHEN Age < 30 THEN '18-29'
        WHEN Age < 40 THEN '30-39'
        WHEN Age < 50 THEN '40-49'
        WHEN Age < 60 THEN '50-59'
        ELSE '60+'
    END AS age_group,

    COUNT(*) AS customers,
    SUM(Loan_Amount) AS portfolio_value,
    ROUND(AVG(Annual_Income), 2) AS average_income,
    ROUND(AVG(Credit_Score), 2) AS average_credit_score,
    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti

FROM credit_risk

GROUP BY
    CASE
        WHEN Age < 30 THEN '18-29'
        WHEN Age < 40 THEN '30-39'
        WHEN Age < 50 THEN '40-49'
        WHEN Age < 60 THEN '50-59'
        ELSE '60+'
    END

ORDER BY age_group;

-- extreme loan exposure 
SELECT
    Loan_Exposure_Category,

    COUNT(*) AS customers,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti,

    ROUND(AVG(Loan_to_Income_Ratio), 2) AS average_loan_to_income,

    ROUND(AVG(Interest_Rate), 2) AS average_interest_rate

FROM credit_risk

GROUP BY Loan_Exposure_Category

ORDER BY
    CASE Loan_Exposure_Category
        WHEN 'Low' THEN 1
        WHEN 'Moderate' THEN 2
        WHEN 'High' THEN 3
        WHEN 'Very High' THEN 4
        WHEN 'Extreme' THEN 5
    END;

-- credit score category
USE credit_risk_analytics;

SELECT
    Credit_Score_Category,
    COUNT(*) AS total_loans,
    SUM(Default_Risk_Flag) AS defaulted_loans,
    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,
    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,
    ROUND(AVG(Annual_Income), 2) AS average_income
FROM credit_risk
GROUP BY Credit_Score_Category
ORDER BY
    CASE Credit_Score_Category
        WHEN 'Poor' THEN 1
        WHEN 'Fair' THEN 2
        WHEN 'Good' THEN 3
        WHEN 'Very Good' THEN 4
        WHEN 'Excellent' THEN 5
    END;

