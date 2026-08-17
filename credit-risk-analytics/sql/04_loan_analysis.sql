USE credit_risk_analytics;


-- ============================================================
-- 04 LOAN ANALYSIS
-- Purpose:
-- Analyze loan characteristics, loan exposure, risk,
-- approval time, interest rates and portfolio performance.
-- ============================================================


-- ============================================================
-- SECTION 1: LOAN EXPOSURE CATEGORY ANALYSIS
-- ============================================================

SELECT
    Loan_Exposure_Category,
    COUNT(*) AS total_loans,
    SUM(Default_Risk_Flag) AS defaulted_loans,
    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,
    ROUND(SUM(Default_Risk_Flag) * 100.0 / COUNT(*), 2)
        AS default_rate_pct,
    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,
    ROUND(AVG(Annual_Income), 2) AS average_income,
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


-- ============================================================
-- SECTION 2: CREDIT SCORE CATEGORY ANALYSIS
-- ============================================================

SELECT
    Credit_Score_Category,
    COUNT(*) AS total_loans,
    SUM(Default_Risk_Flag) AS defaulted_loans,
    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,
    ROUND(SUM(Default_Risk_Flag) * 100.0 / COUNT(*), 2)
        AS default_rate_pct,
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
-- SECTION 3: DEBT-TO-INCOME RATIO (DTI) ANALYSIS
-- ============================================================

SELECT
    CASE
        WHEN Debt_to_Income_Ratio < 20 THEN 'Low DTI'
        WHEN Debt_to_Income_Ratio < 35 THEN 'Moderate DTI'
        WHEN Debt_to_Income_Ratio < 50 THEN 'High DTI'
        WHEN Debt_to_Income_Ratio < 70 THEN 'Very High DTI'
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
        WHEN Debt_to_Income_Ratio < 20 THEN 'Low DTI'
        WHEN Debt_to_Income_Ratio < 35 THEN 'Moderate DTI'
        WHEN Debt_to_Income_Ratio < 50 THEN 'High DTI'
        WHEN Debt_to_Income_Ratio < 70 THEN 'Very High DTI'
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
-- SECTION 4: LOAN PURPOSE ANALYSIS
-- ============================================================

SELECT
    Loan_Purpose,
    COUNT(*) AS total_loans,
    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    SUM(Loan_Amount) AS portfolio_value,
    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,
    ROUND(AVG(Annual_Income), 2) AS average_income,
    ROUND(AVG(Debt_to_Income_Ratio), 2) AS average_dti

FROM credit_risk

GROUP BY Loan_Purpose

ORDER BY default_rate_pct DESC;


-- ============================================================
-- SECTION 5: REGIONAL LOAN ANALYSIS
-- ============================================================

SELECT
    Region,
    COUNT(*) AS total_loans,
    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    SUM(Loan_Amount) AS portfolio_value,
    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount,
    ROUND(AVG(Annual_Income), 2) AS average_income,
    ROUND(AVG(Credit_Score), 2) AS average_credit_score

FROM credit_risk

GROUP BY Region

ORDER BY default_rate_pct DESC;


-- ============================================================
-- SECTION 6: CREDIT SCORE + LOAN PERFORMANCE
-- ============================================================

SELECT
    Credit_Score_Category,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag)
        AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Credit_Score), 2)
        AS average_credit_score,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount

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
-- SECTION 7: LOAN AMOUNT CATEGORY ANALYSIS
-- ============================================================

SELECT
    Loan_Size_Category,
    COUNT(*) AS total_loans,
    SUM(Default_Risk_Flag) AS defaulted_loans,
    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2)
        AS average_income

FROM credit_risk

GROUP BY Loan_Size_Category

ORDER BY
    default_rate_pct DESC;


-- ============================================================
-- SECTION 8: LOAN-TO-INCOME RATIO (LTI) ANALYSIS
-- ============================================================

SELECT
    CASE
        WHEN Loan_to_Income_Ratio < 1 THEN 'Low LTI'
        WHEN Loan_to_Income_Ratio < 2 THEN 'Moderate LTI'
        WHEN Loan_to_Income_Ratio < 3 THEN 'High LTI'
        WHEN Loan_to_Income_Ratio < 4 THEN 'Very High LTI'
        ELSE 'Extreme LTI'
    END AS lti_category,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag)
        AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2)
        AS average_income

FROM credit_risk

GROUP BY
    CASE
        WHEN Loan_to_Income_Ratio < 1 THEN 'Low LTI'
        WHEN Loan_to_Income_Ratio < 2 THEN 'Moderate LTI'
        WHEN Loan_to_Income_Ratio < 3 THEN 'High LTI'
        WHEN Loan_to_Income_Ratio < 4 THEN 'Very High LTI'
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
-- SECTION 9: LOAN TERM ANALYSIS
-- ============================================================

SELECT
    Loan_Term_Months,
    COUNT(*) AS total_loans,
    SUM(Default_Risk_Flag) AS defaulted_loans,
    COUNT(*) - SUM(Default_Risk_Flag) AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount,

    ROUND(AVG(Credit_Score), 2)
        AS average_credit_score

FROM credit_risk

GROUP BY Loan_Term_Months

ORDER BY Loan_Term_Months;


-- ============================================================
-- SECTION 10: INTEREST RATE ANALYSIS
-- ============================================================

SELECT
    Interest_Rate,
    COUNT(*) AS total_loans,
    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount,

    ROUND(AVG(Credit_Score), 2)
        AS average_credit_score

FROM credit_risk

GROUP BY Interest_Rate

ORDER BY Interest_Rate;


-- ============================================================
-- SECTION 11: APPROVAL TIME ANALYSIS
-- ============================================================

SELECT
    CASE
        WHEN Approval_Days <= 3 THEN '0-3 Days'
        WHEN Approval_Days <= 7 THEN '4-7 Days'
        WHEN Approval_Days <= 14 THEN '8-14 Days'
        WHEN Approval_Days <= 30 THEN '15-30 Days'
        ELSE '30+ Days'
    END AS approval_time_category,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount,

    ROUND(AVG(Approval_Days), 2)
        AS average_approval_days

FROM credit_risk

GROUP BY
    CASE
        WHEN Approval_Days <= 3 THEN '0-3 Days'
        WHEN Approval_Days <= 7 THEN '4-7 Days'
        WHEN Approval_Days <= 14 THEN '8-14 Days'
        WHEN Approval_Days <= 30 THEN '15-30 Days'
        ELSE '30+ Days'
    END

ORDER BY
    CASE
        WHEN approval_time_category = '0-3 Days' THEN 1
        WHEN approval_time_category = '4-7 Days' THEN 2
        WHEN approval_time_category = '8-14 Days' THEN 3
        WHEN approval_time_category = '15-30 Days' THEN 4
        ELSE 5
    END;


-- ============================================================
-- SECTION 12: APPLICATION YEAR ANALYSIS
-- ============================================================

SELECT
    Application_Year,
    COUNT(*) AS total_loans,
    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    SUM(Loan_Amount) AS portfolio_value,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount

FROM credit_risk

GROUP BY Application_Year

ORDER BY Application_Year;


-- ============================================================
-- SECTION 13: INTEREST RATE CATEGORY ANALYSIS
-- ============================================================

SELECT
    CASE
        WHEN Interest_Rate < 8 THEN 'Below 8%'
        WHEN Interest_Rate < 12 THEN '8-11.99%'
        WHEN Interest_Rate < 16 THEN '12-15.99%'
        WHEN Interest_Rate < 20 THEN '16-19.99%'
        ELSE '20%+'
    END AS interest_rate_category,

    COUNT(*) AS total_loans,
    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag)
        AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount,

    ROUND(AVG(Credit_Score), 2)
        AS average_credit_score

FROM credit_risk

GROUP BY
    CASE
        WHEN Interest_Rate < 8 THEN 'Below 8%'
        WHEN Interest_Rate < 12 THEN '8-11.99%'
        WHEN Interest_Rate < 16 THEN '12-15.99%'
        WHEN Interest_Rate < 20 THEN '16-19.99%'
        ELSE '20%+'
    END

ORDER BY interest_rate_category;


-- ============================================================
-- SECTION 14: MONTHLY LOAN ANALYSIS
-- ============================================================

SELECT
    Application_Month,
    Application_Month_Name,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    SUM(Loan_Amount) AS portfolio_value

FROM credit_risk

GROUP BY
    Application_Month,
    Application_Month_Name

ORDER BY Application_Month;


-- ============================================================
-- SECTION 15: LOAN STATUS + LOAN PURPOSE ANALYSIS
-- ============================================================

SELECT
    Loan_Status,
    Loan_Purpose,

    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    SUM(Loan_Amount) AS portfolio_value

FROM credit_risk

GROUP BY
    Loan_Status,
    Loan_Purpose

ORDER BY portfolio_value DESC;


-- ============================================================
-- SECTION 16: OVERALL LOAN PORTFOLIO SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_loans,

    SUM(Default_Risk_Flag) AS defaulted_loans,

    COUNT(*) - SUM(Default_Risk_Flag)
        AS non_defaulted_loans,

    ROUND(
        SUM(Default_Risk_Flag) * 100.0 / COUNT(*),
        2
    ) AS overall_default_rate_pct,

    SUM(Loan_Amount) AS total_portfolio_value,

    ROUND(AVG(Loan_Amount), 2)
        AS average_loan_amount,

    ROUND(AVG(Annual_Income), 2)
        AS average_income,

    ROUND(AVG(Credit_Score), 2)
        AS average_credit_score,

    ROUND(AVG(Debt_to_Income_Ratio), 2)
        AS average_dti,

    ROUND(AVG(Loan_to_Income_Ratio), 4)
        AS average_lti

FROM credit_risk;


-- ============================================================
-- END OF 04_LOAN_ANALYSIS.SQL
-- ============================================================