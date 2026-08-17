USE credit_risk_analytics;


-- ============================================================
-- 07 BUSINESS INSIGHTS
-- Purpose:
-- Convert the analytical results into business-oriented
-- metrics, rankings, risk segments and actionable insights.
-- ============================================================


-- ============================================================
-- SECTION 1: PORTFOLIO EXECUTIVE SUMMARY
-- Gives management-level KPIs for the entire loan portfolio.
-- ============================================================

SELECT
    COUNT(*) AS total_loans,

    COUNT(DISTINCT Customer_ID) AS unique_customers,

    ROUND(SUM(Loan_Amount), 2) AS total_portfolio_value,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2) AS average_customer_income,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Interest_Rate), 2) AS average_interest_rate,

    ROUND(AVG(Approval_Days), 2) AS average_approval_days,

    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti,

    ROUND(AVG(Loan_to_Income_Ratio), 4) AS average_lti,

    SUM(Default_Risk_Flag) AS total_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk;



-- ============================================================
-- SECTION 2: TOP REGIONS BY PORTFOLIO VALUE
-- Identifies the regions generating the largest loan exposure.
-- ============================================================

SELECT
    Region,

    COUNT(*) AS total_loans,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(
        SUM(Loan_Amount) * 100.0 /
        (SELECT SUM(Loan_Amount) FROM credit_risk),
        2
    ) AS portfolio_share_pct,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk

GROUP BY Region

ORDER BY portfolio_value DESC;



-- ============================================================
-- SECTION 3: TOP LOAN PURPOSES BY PORTFOLIO VALUE
-- Identifies the products contributing the most loan value.
-- ============================================================

SELECT
    Loan_Purpose,

    COUNT(*) AS total_loans,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(
        SUM(Loan_Amount) * 100.0 /
        (SELECT SUM(Loan_Amount) FROM credit_risk),
        2
    ) AS portfolio_share_pct,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Interest_Rate), 2) AS average_interest_rate,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk

GROUP BY Loan_Purpose

ORDER BY portfolio_value DESC;



-- ============================================================
-- SECTION 4: HIGHEST-RISK CREDIT SEGMENTS
-- Identifies credit-score categories with the highest
-- observed default rates.
-- ============================================================

SELECT
    Credit_Score_Category,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti

FROM credit_risk

GROUP BY Credit_Score_Category

ORDER BY default_rate_pct DESC;



-- ============================================================
-- SECTION 5: LOAN EXPOSURE RISK
-- Shows how portfolio value and defaults vary by
-- loan exposure category.
-- ============================================================

SELECT
    Loan_Exposure_Category,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(
        SUM(Loan_Amount) * 100.0 /
        (SELECT SUM(Loan_Amount) FROM credit_risk),
        2
    ) AS portfolio_share_pct,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2) AS average_income

FROM credit_risk

GROUP BY Loan_Exposure_Category

ORDER BY portfolio_value DESC;



-- ============================================================
-- SECTION 6: REGIONAL PERFORMANCE SCORECARD
-- Combines business volume, portfolio value and credit risk.
-- ============================================================

SELECT
    Region,

    COUNT(*) AS total_loans,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti,

    ROUND(AVG(Loan_to_Income_Ratio), 4) AS average_lti,

    ROUND(AVG(Approval_Days), 2) AS average_approval_days,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk

GROUP BY Region

ORDER BY default_rate_pct DESC;



-- ============================================================
-- SECTION 7: HIGH-VALUE LOAN SEGMENTS
-- Identifies loan exposure categories with large
-- average loan amounts.
-- ============================================================

SELECT
    Loan_Size_Category,

    COUNT(*) AS total_loans,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk

GROUP BY Loan_Size_Category

ORDER BY average_loan_amount DESC;



-- ============================================================
-- SECTION 8: HIGH-RISK CUSTOMER IDENTIFICATION
-- Identifies customers combining multiple risk indicators.
-- ============================================================

SELECT
    Customer_ID,

    Region,

    Annual_Income,

    Credit_Score,

    Credit_Score_Category,

    Loan_Amount,

    Loan_Purpose,

    Debt_to_Income_Ratio,

    Loan_to_Income_Ratio,

    Loan_Exposure_Category,

    Default_Risk_Flag

FROM credit_risk

WHERE
    Credit_Score_Category IN ('Poor', 'Fair')

    AND Debt_to_Income_Ratio >= 40

    AND Loan_Exposure_Category IN
        ('High', 'Very High', 'Extreme')

ORDER BY
    Debt_to_Income_Ratio DESC,
    Loan_Amount DESC;



-- ============================================================
-- SECTION 9: BUSINESS RISK SEGMENTATION
-- Creates an analytical business classification based on
-- credit quality, debt burden and loan exposure.
-- ============================================================

SELECT

    Customer_ID,

    Region,

    Credit_Score,

    Credit_Score_Category,

    Annual_Income,

    Loan_Amount,

    Debt_to_Income_Ratio,

    Loan_to_Income_Ratio,

    Loan_Exposure_Category,

    CASE

        WHEN Credit_Score_Category = 'Poor'
             AND Debt_to_Income_Ratio >= 40
             AND Loan_Exposure_Category IN
                 ('High', 'Very High', 'Extreme')
            THEN 'Critical Risk'

        WHEN Credit_Score_Category IN ('Poor', 'Fair')
             AND Debt_to_Income_Ratio >= 30
            THEN 'High Risk'

        WHEN Credit_Score_Category IN ('Fair', 'Good')
             AND Debt_to_Income_Ratio >= 20
            THEN 'Moderate Risk'

        ELSE 'Lower Risk'

    END AS business_risk_segment

FROM credit_risk

ORDER BY
    CASE

        WHEN Credit_Score_Category = 'Poor'
             AND Debt_to_Income_Ratio >= 40
             AND Loan_Exposure_Category IN
                 ('High', 'Very High', 'Extreme')
            THEN 1

        WHEN Credit_Score_Category IN ('Poor', 'Fair')
             AND Debt_to_Income_Ratio >= 30
            THEN 2

        WHEN Credit_Score_Category IN ('Fair', 'Good')
             AND Debt_to_Income_Ratio >= 20
            THEN 3

        ELSE 4

    END;



-- ============================================================
-- SECTION 10: APPROVAL EFFICIENCY BY REGION
-- Identifies regions where loan processing is faster/slower.
-- ============================================================

SELECT
    Region,

    COUNT(*) AS total_applications,

    ROUND(AVG(Approval_Days), 2) AS average_approval_days,

    MIN(Approval_Days) AS fastest_approval_days,

    MAX(Approval_Days) AS slowest_approval_days,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk

GROUP BY Region

ORDER BY average_approval_days ASC;



-- ============================================================
-- SECTION 11: YEARLY BUSINESS TREND
-- Tracks portfolio growth and credit risk over time.
-- ============================================================

SELECT
    Application_Year,

    COUNT(*) AS total_loans,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk

GROUP BY Application_Year

ORDER BY Application_Year;



-- ============================================================
-- SECTION 12: MONTHLY APPLICATION TREND
-- Identifies seasonal differences in application volume.
-- ============================================================

SELECT
    Application_Month,

    Application_Month_Name,

    COUNT(*) AS total_loans,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk

GROUP BY
    Application_Month,
    Application_Month_Name

ORDER BY Application_Month;



-- ============================================================
-- SECTION 13: TOP CUSTOMERS BY LOAN EXPOSURE
-- Identifies individual customers with the largest loans.
-- ============================================================

SELECT
    Customer_ID,

    Region,

    Annual_Income,

    Credit_Score,

    Loan_Purpose,

    Loan_Amount,

    Loan_to_Income_Ratio,

    Debt_to_Income_Ratio,

    Loan_Exposure_Category,

    Default_Risk_Flag

FROM credit_risk

ORDER BY Loan_Amount DESC

LIMIT 20;



-- ============================================================
-- SECTION 14: RISK CONCENTRATION BY REGION AND PURPOSE
-- Identifies combinations of region and loan purpose
-- carrying significant default or portfolio exposure.
-- ============================================================

SELECT
    Region,

    Loan_Purpose,

    COUNT(*) AS total_loans,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk

GROUP BY
    Region,
    Loan_Purpose

ORDER BY
    default_rate_pct DESC,
    portfolio_value DESC;



-- ============================================================
-- SECTION 15: FINAL BUSINESS KPI SCORECARD
-- This is the main executive-level output for reporting.
-- ============================================================

SELECT

    COUNT(*) AS total_loans,

    COUNT(DISTINCT Customer_ID) AS total_customers,

    ROUND(SUM(Loan_Amount), 2) AS total_portfolio_value,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2) AS average_customer_income,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Interest_Rate), 2) AS average_interest_rate,

    ROUND(AVG(Approval_Days), 2) AS average_approval_days,

    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti,

    ROUND(AVG(Loan_to_Income_Ratio), 4) AS average_lti,

    SUM(Default_Risk_Flag) AS total_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk;


-- ============================================================
-- END OF 07_BUSINESS_INSIGHTS.SQL
-- ============================================================