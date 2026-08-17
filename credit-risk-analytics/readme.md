# Credit Risk & Loan Portfolio Analytics

## 📌 Project Overview

An end-to-end Credit Risk and Loan Portfolio Analytics project built using Python, SQL, and Power BI.

The project analyzes customer demographics, loan applications, credit scores, debt-to-income ratios, loan exposure, approval performance, regional trends, and default-risk indicators.

The objective is to transform raw loan data into actionable business insights through data cleaning, exploratory analysis, SQL analytics, and an interactive Power BI dashboard.

---

## 🎯 Business Objectives

The project focuses on answering key business questions:

- How large is the overall loan portfolio?
- What is the total number of loan applications?
- Which loan purposes contribute the most to portfolio value?
- How does credit score relate to default risk?
- How does Debt-to-Income Ratio affect borrower risk?
- How does Loan-to-Income exposure vary?
- Which regions have the highest portfolio exposure?
- Which employment groups have the highest borrowing activity?
- How long does loan approval take?
- How does loan performance change over time?
- Which loan categories represent higher risk exposure?

---

## 🗂️ Dataset

The dataset contains customer and loan-level information including:

### Customer Information
- Customer ID
- Age
- Gender
- Marital Status
- Education Level
- Employment Type
- Annual Income
- Region
- Dependents

### Financial Information
- Credit Score
- Existing Loans Count
- Account Balance
- Debt-to-Income Ratio
- Loan-to-Income Ratio
- Loan-to-Income Exposure

### Loan Information
- Loan ID
- Loan Purpose
- Loan Amount
- Loan Term
- Interest Rate
- Application Date
- Approval Date
- Loan Status
- Default Risk Flag
- Approval Days

### Derived Attributes
- Application Year
- Application Month
- Application Month Name
- Approval Year
- Loan Size Category
- Credit Score Category
- Loan Exposure Category

---

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data auditing, quality checks and preprocessing |
| Pandas | Data manipulation |
| SQL | Business analysis and aggregation |
| MySQL | Database management |
| Power BI | Interactive dashboard and visualization |
| DAX | Measures and calculated analysis |
| Git/GitHub | Version control and project portfolio |

---

## 🔄 Project Workflow

Raw Dataset
        ↓
Python Data Audit
        ↓
Data Quality Validation
        ↓
Data Cleaning & Preparation
        ↓
MySQL Database
        ↓
SQL Business Analysis
        ↓
Power BI Data Model
        ↓
DAX Measures
        ↓
Interactive Dashboard
        ↓
Business Insights

---

## 🐍 Python Analysis

Python was used for:

- Dataset inspection
- Missing-value analysis
- Duplicate detection
- Data type validation
- Data quality checks
- DTI investigation
- Dataset preparation
- Exporting the analytical dataset

Python scripts are organized inside:

`/python`

---

## 🗄️ SQL Analysis

SQL was used to perform:

- Portfolio analysis
- Customer analysis
- Loan analysis
- Regional analysis
- Credit risk analysis
- Business insight generation

SQL scripts are organized inside:

`/sql`

### SQL Analysis Modules

1. Database Setup
2. Portfolio Overview
3. Customer Analysis
4. Loan Analysis
5. Regional Analysis
6. Credit Risk Analysis
7. Business Insights

---

## 📊 Power BI Dashboard

The Power BI dashboard contains four analytical pages.

### 1. Executive Overview

Provides a high-level view of:

- Total Customers
- Total Loans
- Total Portfolio Value
- Defaulted Loans
- Default Rate
- Loan Status Distribution
- Portfolio Trend by Year
- Regional Portfolio Performance
- Loan Purpose Performance

---

### 2. Credit Risk Analysis

Focuses on borrower and credit risk.

Includes:

- Average Credit Score
- Default Rate by Credit Score Category
- Default Rate by Loan Exposure
- Loan Status Distribution
- Default Risk by DTI Category
- Default Risk by LTI Category

---

### 3. Loan & Customer Analysis

Analyzes borrowing behavior and customer characteristics.

Includes:

- Loan Portfolio by Purpose
- Portfolio by Employment Type
- Average Loan Amount by Loan Term
- Average Loan Amount by Credit Score
- Customers by Employment Type
- Average Loan Amount by Interest Rate
- Customer Age Distribution
- Customer Distribution by Gender

---

### 4. Regional Performance

Analyzes geographic performance.

Includes:

- Regional Portfolio Value
- Average DTI by Region
- Average Approval Time by Region
- Default Rate by Region
- Average Credit Score by Region
- Loan Distribution by Region and Purpose

---

## 📈 Key Project Metrics

Based on the analytical dataset:

- **12,000 loan records analyzed**
- **₹9.38B total loan portfolio**
- **11,954 records flagged with default risk**
- **99.62% overall default-risk flag rate**
- **595.75 average credit score**
- Data analyzed across **2018–2023**
- Analysis performed across multiple regions and loan purposes

> Note: The `Default_Risk_Flag` metric is treated according to the supplied dataset definition and should not automatically be interpreted as a real-world banking default rate.

---

## 💡 Business Insights

The analysis enables stakeholders to:

- Identify high-risk borrower segments
- Compare portfolio exposure across regions
- Understand borrowing patterns by loan purpose
- Evaluate credit-score-based risk categories
- Monitor DTI and LTI exposure
- Analyze loan approval efficiency
- Identify major contributors to portfolio value
- Compare customer borrowing behavior across employment groups

---

## 📁 Project Structure

```text
credit-risk-analytics/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── python/
│   ├── 01_data_audit.py
│   ├── 02_data_quality.py
│   ├── 03_dti_investigation.py
│   └── 04_prepare_dataset.py
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_portfolio_overview.sql
│   ├── 03_customer_analysis.sql
│   ├── 04_loan_analysis.sql
│   ├── 05_regional_analysis.sql
│   ├── 06_credit_risk_analysis.sql
│   └── 07_business_insights.sql
│
├── powerbi/
│   └── Credit_Risk_Dashboard.pbix
│
├── screenshots/
│
├── docs/
│
└── README.md

👨‍💻 Author

Ayush Yogi

B.Tech – Artificial Intelligence

Aspiring Data Analyst / AI Engineer