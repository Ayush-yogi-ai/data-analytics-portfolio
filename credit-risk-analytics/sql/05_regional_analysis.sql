USE credit_risk_analytics;


-- ============================================================
-- 05 REGIONAL ANALYSIS
-- Purpose:
-- Analyze loan activity, portfolio exposure, customer income,
-- credit quality and default risk across different regions.
-- ============================================================


-- ============================================================
-- SECTION 1: REGIONAL LOAN OVERVIEW
-- Shows the basic loan volume and portfolio size by region.
-- ============================================================

SELECT
    Region,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag)
        AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    SUM(Loan_Amount) AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount

FROM credit_risk

GROUP BY Region

ORDER BY default_rate_pct DESC;


-- ============================================================
-- SECTION 2: REGIONAL CUSTOMER PROFILE
-- Compares income, credit score, DTI and LTI across regions.
-- ============================================================

SELECT
    Region,

    COUNT(DISTINCT Customer_ID)
        AS total_customers,

    ROUND(AVG(Annual_Income), 2)
        AS average_income,

    ROUND(AVG(Credit_Score), 2)
        AS average_credit_score,

    ROUND(AVG(Debt_to_Income_Ratio), 2)
        AS average_dti,

    ROUND(AVG(Loan_to_Income_Ratio), 4)
        AS average_lti,

    ROUND(AVG(Account_Balance), 2)
        AS average_account_balance

FROM credit_risk

GROUP BY Region

ORDER BY average_credit_score DESC;


-- ============================================================
-- SECTION 3: REGIONAL PORTFOLIO EXPOSURE
-- Identifies regions carrying the largest total loan exposure.
-- ============================================================

SELECT
    Region,

    COUNT(*) AS total_loans,

    SUM(Loan_Amount) AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount,

    ROUND(
        SUM(Loan_Amount) * 100.0 /
        (SELECT SUM(Loan_Amount) FROM credit_risk),
        2
    ) AS portfolio_share_pct

FROM credit_risk

GROUP BY Region

ORDER BY portfolio_value DESC;


-- ============================================================
-- SECTION 4: REGIONAL DEFAULT RISK
-- Compares default performance between regions.
-- ============================================================

SELECT
    Region,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag)
        AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk

GROUP BY Region

ORDER BY default_rate_pct DESC;


-- ============================================================
-- SECTION 5: REGIONAL CREDIT SCORE ANALYSIS
-- Examines credit quality within each region.
-- ============================================================

SELECT
    Region,

    ROUND(AVG(Credit_Score), 2)
        AS average_credit_score,

    MIN(Credit_Score)
        AS minimum_credit_score,

    MAX(Credit_Score)
        AS maximum_credit_score,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk

GROUP BY Region

ORDER BY average_credit_score DESC;


-- ============================================================
-- SECTION 6: REGIONAL DTI ANALYSIS
-- Compares borrower debt burden across regions.
-- ============================================================

SELECT
    Region,

    ROUND(AVG(Debt_to_Income_Ratio), 2)
        AS average_dti,

    MIN(Debt_to_Income_Ratio)
        AS minimum_dti,

    MAX(Debt_to_Income_Ratio)
        AS maximum_dti,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct

FROM credit_risk

GROUP BY Region

ORDER BY average_dti DESC;


-- ============================================================
-- SECTION 7: REGIONAL LTI ANALYSIS
-- Measures loan size relative to borrower income.
-- ============================================================

SELECT
    Region,

    ROUND(AVG(Loan_to_Income_Ratio), 4)
        AS average_lti,

    MIN(Loan_to_Income_Ratio)
        AS minimum_lti,

    MAX(Loan_to_Income_Ratio)
        AS maximum_lti,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2)
        AS average_income

FROM credit_risk

GROUP BY Region

ORDER BY average_lti DESC;


-- ============================================================
-- SECTION 8: REGIONAL LOAN PURPOSE ANALYSIS
-- Shows which loan purposes dominate each region.
-- ============================================================

SELECT
    Region,

    Loan_Purpose,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag)
        AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    SUM(Loan_Amount)
        AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount

FROM credit_risk

GROUP BY
    Region,
    Loan_Purpose

ORDER BY
    Region,
    portfolio_value DESC;


-- ============================================================
-- SECTION 9: REGIONAL CREDIT SCORE CATEGORY ANALYSIS
-- Breaks regional performance into credit-risk categories.
-- ============================================================

SELECT
    Region,

    Credit_Score_Category,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag)
        AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag)
        AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount

FROM credit_risk

GROUP BY
    Region,
    Credit_Score_Category

ORDER BY
    Region,
    CASE Credit_Score_Category
        WHEN 'Poor' THEN 1
        WHEN 'Fair' THEN 2
        WHEN 'Good' THEN 3
        WHEN 'Very Good' THEN 4
        WHEN 'Excellent' THEN 5
    END;


-- ============================================================
-- SECTION 10: REGIONAL LOAN EXPOSURE CATEGORY
-- Identifies the level of loan exposure within each region.
-- ============================================================

SELECT
    Region,

    Loan_Exposure_Category,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag)
        AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    SUM(Loan_Amount)
        AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount

FROM credit_risk

GROUP BY
    Region,
    Loan_Exposure_Category

ORDER BY
    Region,
    portfolio_value DESC;


-- ============================================================
-- SECTION 11: REGIONAL APPLICATION YEAR TREND
-- Shows how loan activity has changed across years by region.
-- ============================================================

SELECT
    Region,

    Application_Year,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag)
        AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    SUM(Loan_Amount)
        AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount

FROM credit_risk

GROUP BY
    Region,
    Application_Year

ORDER BY
    Region,
    Application_Year;


-- ============================================================
-- SECTION 12: REGIONAL LOAN STATUS ANALYSIS
-- Compares approved/default status across regions.
-- ============================================================

SELECT
    Region,

    Loan_Status,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag)
        AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag)
        AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    SUM(Loan_Amount)
        AS portfolio_value

FROM credit_risk

GROUP BY
    Region,
    Loan_Status

ORDER BY
    Region,
    portfolio_value DESC;


-- ============================================================
-- SECTION 13: REGIONAL APPROVAL PERFORMANCE
-- Measures how quickly applications are approved in each region.
-- ============================================================

SELECT
    Region,

    COUNT(*) AS total_applications,

    ROUND(AVG(Approval_Days), 2)
        AS average_approval_days,

    MIN(Approval_Days)
        AS minimum_approval_days,

    MAX(Approval_Days)
        AS maximum_approval_days,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount

FROM credit_risk

GROUP BY Region

ORDER BY average_approval_days ASC;


-- ============================================================
-- SECTION 14: REGIONAL INCOME VS LOAN SIZE
-- Compares borrower income with average loan size.
-- ============================================================

SELECT
    Region,

    ROUND(AVG(Annual_Income), 2)
        AS average_income,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount,

    ROUND(
        AVG(Loan_Amount) / NULLIF(AVG(Annual_Income), 0),
        4
    ) AS average_loan_to_income_ratio,

    ROUND(AVG(Credit_Score), 2)
        AS average_credit_score,

    ROUND(AVG(Debt_to_Income_Ratio), 2)
        AS average_dti

FROM credit_risk

GROUP BY Region

ORDER BY average_loan_to_income_ratio DESC;


-- ============================================================
-- SECTION 15: FINAL REGIONAL RISK SCORECARD
-- Provides one consolidated view for dashboard/reporting.
-- ============================================================

SELECT
    Region,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag)
        AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag)
        AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    SUM(Loan_Amount)
        AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2)
        AS average_income,

    ROUND(AVG(Credit_Score), 2)
        AS average_credit_score,

    ROUND(AVG(Debt_to_Income_Ratio), 2)
        AS average_dti,

    ROUND(AVG(Loan_to_Income_Ratio), 4)
        AS average_lti,

    ROUND(AVG(Approval_Days), 2)
        AS average_approval_days

FROM credit_risk

GROUP BY Region

ORDER BY default_rate_pct DESC;


-- ============================================================
-- END OF 05_REGIONAL_ANALYSIS.SQL
-- ============================================================