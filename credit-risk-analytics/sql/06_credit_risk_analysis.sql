USE credit_risk_analytics;


-- ============================================================
-- 06 CREDIT RISK ANALYSIS
-- Purpose:
-- Analyze borrower credit risk, default behavior,
-- financial ratios, and high-risk customer segments.
-- ============================================================



-- ============================================================
-- SECTION 1: OVERALL CREDIT RISK PROFILE
-- Purpose:
-- Get the overall number of loans, defaults,
-- non-defaults and default rate.
-- ============================================================

SELECT
    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS overall_default_rate_pct,

    ROUND(SUM(Loan_Amount), 2) AS total_loan_portfolio,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti,

    ROUND(AVG(Loan_to_Income_Ratio), 4) AS average_lti

FROM credit_risk;



-- ============================================================
-- SECTION 2: DEFAULT RATE BY CREDIT SCORE CATEGORY
-- Purpose:
-- Understand how default behavior differs across
-- Poor, Fair, Good, Very Good and Excellent borrowers.
-- ============================================================

SELECT
    Credit_Score_Category,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

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



-- ============================================================
-- SECTION 3: DEFAULT RATE BY LOAN EXPOSURE
-- Purpose:
-- Identify whether borrowers with larger financial
-- exposure represent greater credit risk.
-- ============================================================

SELECT
    Loan_Exposure_Category,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti

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



-- ============================================================
-- SECTION 4: DEFAULT RATE BY DTI CATEGORY
-- Purpose:
-- Analyze the relationship between debt burden
-- and loan default risk.
-- ============================================================

SELECT
    CASE
        WHEN Debt_to_Income_Ratio < 20
            THEN 'Low DTI'

        WHEN Debt_to_Income_Ratio < 40
            THEN 'Moderate DTI'

        WHEN Debt_to_Income_Ratio < 60
            THEN 'High DTI'

        WHEN Debt_to_Income_Ratio < 80
            THEN 'Very High DTI'

        ELSE 'Extreme DTI'
    END AS dti_category,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score

FROM credit_risk

GROUP BY
    CASE
        WHEN Debt_to_Income_Ratio < 20
            THEN 'Low DTI'
        WHEN Debt_to_Income_Ratio < 40
            THEN 'Moderate DTI'
        WHEN Debt_to_Income_Ratio < 60
            THEN 'High DTI'
        WHEN Debt_to_Income_Ratio < 80
            THEN 'Very High DTI'
        ELSE 'Extreme DTI'
    END

ORDER BY
    CASE
        WHEN dti_category = 'Low DTI' THEN 1
        WHEN dti_category = 'Moderate DTI' THEN 2
        WHEN dti_category = 'High DTI' THEN 3
        WHEN dti_category = 'Very High DTI' THEN 4
        WHEN dti_category = 'Extreme DTI' THEN 5
    END;



-- ============================================================
-- SECTION 5: DEFAULT RATE BY LOAN-TO-INCOME RATIO
-- Purpose:
-- Determine whether the loan size relative to income
-- is associated with higher default risk.
-- ============================================================

SELECT
    CASE
        WHEN Loan_to_Income_Ratio < 2
            THEN 'Low LTI'

        WHEN Loan_to_Income_Ratio < 4
            THEN 'Moderate LTI'

        WHEN Loan_to_Income_Ratio < 6
            THEN 'High LTI'

        WHEN Loan_to_Income_Ratio < 8
            THEN 'Very High LTI'

        ELSE 'Extreme LTI'
    END AS lti_category,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2) AS average_income

FROM credit_risk

GROUP BY
    CASE
        WHEN Loan_to_Income_Ratio < 2 THEN 'Low LTI'
        WHEN Loan_to_Income_Ratio < 4 THEN 'Moderate LTI'
        WHEN Loan_to_Income_Ratio < 6 THEN 'High LTI'
        WHEN Loan_to_Income_Ratio < 8 THEN 'Very High LTI'
        ELSE 'Extreme LTI'
    END

ORDER BY
    CASE
        WHEN lti_category = 'Low LTI' THEN 1
        WHEN lti_category = 'Moderate LTI' THEN 2
        WHEN lti_category = 'High LTI' THEN 3
        WHEN lti_category = 'Very High LTI' THEN 4
        WHEN lti_category = 'Extreme LTI' THEN 5
    END;



-- ============================================================
-- SECTION 6: DEFAULT RISK BY LOAN PURPOSE
-- Purpose:
-- Identify which types of loans contribute the most
-- to credit risk and portfolio exposure.
-- ============================================================

SELECT
    Loan_Purpose,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score

FROM credit_risk

GROUP BY Loan_Purpose

ORDER BY default_rate_pct DESC;



-- ============================================================
-- SECTION 7: DEFAULT RISK BY REGION
-- Purpose:
-- Compare credit performance across geographical regions.
-- ============================================================

SELECT
    Region,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti

FROM credit_risk

GROUP BY Region

ORDER BY default_rate_pct DESC;



-- ============================================================
-- SECTION 8: HIGH-RISK BORROWER SEGMENT
-- Purpose:
-- Find borrowers who simultaneously have:
-- 1. Low credit score
-- 2. High DTI
-- 3. High loan exposure
-- These borrowers represent potentially higher-risk customers.
-- ============================================================

SELECT

    Customer_ID,

    Credit_Score,

    Credit_Score_Category,

    Annual_Income,

    Loan_Amount,

    Debt_to_Income_Ratio,

    Loan_to_Income_Ratio,

    Loan_Exposure_Category,

    Default_Risk_Flag

FROM credit_risk

WHERE
    Credit_Score_Category IN ('Poor', 'Fair')

    AND Debt_to_Income_Ratio >= 40

    AND Loan_Exposure_Category IN ('High', 'Very High', 'Extreme')

ORDER BY
    Debt_to_Income_Ratio DESC;



-- ============================================================
-- SECTION 9: RISK SCORE SEGMENTATION
-- Purpose:
-- Create a simple analytical risk classification
-- using credit score, DTI and loan exposure.
-- ============================================================

SELECT

    Customer_ID,

    Credit_Score,

    Debt_to_Income_Ratio,

    Loan_to_Income_Ratio,

    Loan_Amount,

    Annual_Income,

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

    END AS risk_segment,

    Default_Risk_Flag

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
-- SECTION 10: CREDIT RISK BY LOAN STATUS
-- Purpose:
-- Compare Approved and Default loan populations.
-- ============================================================

SELECT

    Loan_Status,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(SUM(Loan_Amount), 2) AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score

FROM credit_risk

GROUP BY Loan_Status

ORDER BY default_rate_pct DESC;



-- ============================================================
-- SECTION 11: FINAL CREDIT RISK KPI SUMMARY
-- Purpose:
-- Produce one compact result that can later be used
-- in Python or Power BI as an executive KPI table.
-- ============================================================

SELECT

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS overall_default_rate_pct,

    ROUND(SUM(Loan_Amount), 2) AS total_portfolio_value,

    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2) AS average_income,

    ROUND(AVG(Credit_Score), 2) AS average_credit_score,

    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti,

    ROUND(AVG(Loan_to_Income_Ratio), 4) AS average_lti,

    ROUND(AVG(Approval_Days), 2) AS average_approval_days

FROM credit_risk;


-- ============================================================
-- END OF 06_CREDIT_RISK_ANALYSIS.SQL
-- ============================================================