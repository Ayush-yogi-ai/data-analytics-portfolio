CREATE DATABASE IF NOT EXISTS credit_risk_analytics;

USE credit_risk_analytics;

CREATE TABLE credit_risk (
    Customer_ID VARCHAR(20),
    Age INT,
    Gender VARCHAR(20),
    Marital_Status VARCHAR(30),
    Education_Level VARCHAR(50),
    Employment_Type VARCHAR(50),
    Annual_Income DECIMAL(15,2),
    Region VARCHAR(30),
    Credit_Score INT,
    Existing_Loans_Count INT,
    Dependents INT,
    Account_Balance DECIMAL(15,2),
    Loan_ID VARCHAR(20),
    Loan_Purpose VARCHAR(50),
    Loan_Amount DECIMAL(15,2),
    Loan_Term_Months INT,
    Interest_Rate DECIMAL(6,2),
    Debt_to_Income_Ratio DECIMAL(12,2),
    Application_Date DATE,
    Approval_Date DATE,
    Loan_Status VARCHAR(20),
    Default_Risk_Flag INT,

    Approval_Days INT,
    Loan_to_Income_Ratio DECIMAL(12,4),
    Loan_to_Income_Exposure DECIMAL(12,2),
    Application_Year INT,
    Application_Month INT,
    Application_Month_Name VARCHAR(20),
    Approval_Year INT,
    Loan_Size_Category VARCHAR(20),
    Credit_Score_Category VARCHAR(20),
    Loan_Exposure_Category VARCHAR(20)
);