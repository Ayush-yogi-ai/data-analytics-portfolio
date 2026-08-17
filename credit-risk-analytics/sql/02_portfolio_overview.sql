-- portfolio size

USE credit_risk_analytics;

SELECT
    COUNT(*) AS total_loans,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    SUM(Loan_Amount) AS total_loan_value,
    AVG(Loan_Amount) AS average_loan_amount,
    AVG(Interest_Rate) AS average_interest_rate,
    AVG(Credit_Score) AS average_credit_score
FROM credit_risk;

-- loan status composition

SELECT
    Loan_Status,
    COUNT(*) AS loan_count,
    SUM(Loan_Amount) AS loan_value,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS loan_percentage
FROM credit_risk
GROUP BY Loan_Status
ORDER BY loan_count DESC;

-- portfolio by region

SELECT
    Region,
    COUNT(*) AS total_loans,
    SUM(Loan_Amount) AS portfolio_value,
    AVG(Loan_Amount) AS average_loan_amount,
    AVG(Credit_Score) AS average_credit_score,
    AVG(Approval_Days) AS average_approval_days
FROM credit_risk
GROUP BY Region
ORDER BY portfolio_value DESC;

-- query by loan purpose

SELECT
    Loan_Purpose,
    COUNT(*) AS total_loans,
    SUM(Loan_Amount) AS portfolio_value,
    AVG(Loan_Amount) AS average_loan_amount,
    AVG(Interest_Rate) AS average_interest_rate,
    AVG(Loan_to_Income_Ratio) AS average_loan_to_income
FROM credit_risk
GROUP BY Loan_Purpose
ORDER BY portfolio_value DESC;

-- credit score segments

SELECT
    Credit_Score_Category,
    COUNT(*) AS total_loans,
    SUM(Loan_Amount) AS portfolio_value,
    AVG(Loan_Amount) AS average_loan_amount,
    AVG(Loan_to_Income_Ratio) AS average_loan_to_income,
    AVG(Interest_Rate) AS average_interest_rate
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
    
-- loan exposure segmentations
SELECT
    Loan_Exposure_Category,
    COUNT(*) AS total_loans,
    SUM(Loan_Amount) AS portfolio_value,
    AVG(Annual_Income) AS average_income,
    AVG(Loan_Amount) AS average_loan_amount,
    AVG(Credit_Score) AS average_credit_score
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
    
-- one query to show all the results 

USE credit_risk_analytics;

SELECT
    COUNT(*) AS total_loans,
    COUNT(DISTINCT Customer_ID) AS unique_customers,

    ROUND(SUM(Loan_Amount), 2) AS total_portfolio_value,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Interest_Rate), 2) AS average_interest_rate,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Annual_Income), 2) AS average_annual_income,

    ROUND(AVG(Loan_to_Income_Ratio), 2) AS average_loan_to_income,

    ROUND(AVG(Approval_Days), 2) AS average_approval_days

FROM credit_risk;

-- loan status distribution

SELECT
    Loan_Status,

    COUNT(*) AS loan_count,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS loan_percentage,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount

FROM credit_risk

GROUP BY Loan_Status

ORDER BY loan_count DESC;

-- loan region
SELECT
    Region,

    COUNT(*) AS total_loans,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(
        SUM(Loan_Amount) * 100.0 /
        SUM(SUM(Loan_Amount)) OVER (),
        2
    ) AS portfolio_share_pct,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Approval_Days), 2) AS average_approval_days

FROM credit_risk

GROUP BY Region

ORDER BY portfolio_value DESC;

-- loan purpose

SELECT
    Loan_Purpose,

    COUNT(*) AS total_loans,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(
        SUM(Loan_Amount) * 100.0 /
        SUM(SUM(Loan_Amount)) OVER (),
        2
    ) AS portfolio_share_pct,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Interest_Rate), 2) AS average_interest_rate,

    ROUND(AVG(Loan_to_Income_Ratio), 2) AS average_loan_to_income

FROM credit_risk

GROUP BY Loan_Purpose

ORDER BY portfolio_value DESC;

-- credit score 
SELECT
    Credit_Score_Category,

    COUNT(*) AS total_loans,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS customer_share_pct,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Loan_to_Income_Ratio), 2) AS average_loan_to_income,

    ROUND(AVG(Interest_Rate), 2) AS average_interest_rate

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

-- loan exposure
SELECT
    Loan_Exposure_Category,

    COUNT(*) AS total_loans,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS customer_share_pct,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score

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
