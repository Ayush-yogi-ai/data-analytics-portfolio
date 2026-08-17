import pandas as pd
from pathlib import Path


# ==================================================
# 1. PROJECT PATHS
# ==================================================

PROJECT_ROOT = Path(__file__).resolve().parents[1]

RAW_DATA_PATH = (
    PROJECT_ROOT
    / "data"
    / "raw"
    / "Banking_Credit_Risk_Dataset.csv"
)

PROCESSED_DIR = (
    PROJECT_ROOT
    / "data"
    / "processed"
)

PROCESSED_DIR.mkdir(
    parents=True,
    exist_ok=True
)

OUTPUT_PATH = (
    PROCESSED_DIR
    / "credit_risk_analytical.csv"
)


# ==================================================
# 2. LOAD RAW DATA
# ==================================================

df = pd.read_csv(RAW_DATA_PATH)

print("\n========== RAW DATA ==========\n")

print("Rows:", len(df))
print("Columns:", len(df.columns))


# ==================================================
# 3. CONVERT DATE COLUMNS
# ==================================================

df["Application_Date"] = pd.to_datetime(
    df["Application_Date"],
    errors="coerce"
)

df["Approval_Date"] = pd.to_datetime(
    df["Approval_Date"],
    errors="coerce"
)


# ==================================================
# 4. CREATE APPROVAL PROCESSING TIME
# ==================================================

df["Approval_Days"] = (
    df["Approval_Date"]
    - df["Application_Date"]
).dt.days


# ==================================================
# 5. CREATE LOAN-TO-INCOME RATIO
# ==================================================

df["Loan_to_Income_Ratio"] = (
    df["Loan_Amount"]
    / df["Annual_Income"]
)


# ==================================================
# 6. CREATE LOAN-TO-INCOME EXPOSURE %
# ==================================================

df["Loan_to_Income_Exposure_%"] = (
    df["Loan_to_Income_Ratio"] * 100
)


# ==================================================
# 7. CREATE DATE DIMENSIONS
# ==================================================

df["Application_Year"] = (
    df["Application_Date"].dt.year
)

df["Application_Month"] = (
    df["Application_Date"].dt.month
)

df["Application_Month_Name"] = (
    df["Application_Date"].dt.month_name()
)

df["Approval_Year"] = (
    df["Approval_Date"].dt.year
)


# ==================================================
# 8. CREATE LOAN SIZE CATEGORY
# ==================================================

df["Loan_Size_Category"] = pd.cut(
    df["Loan_Amount"],
    bins=[
        0,
        250000,
        500000,
        1000000,
        float("inf")
    ],
    labels=[
        "Small",
        "Medium",
        "Large",
        "Very Large"
    ]
)


# ==================================================
# 9. CREATE CREDIT SCORE CATEGORY
# ==================================================

df["Credit_Score_Category"] = pd.cut(
    df["Credit_Score"],
    bins=[
        0,
        579,
        669,
        739,
        799,
        900
    ],
    labels=[
        "Poor",
        "Fair",
        "Good",
        "Very Good",
        "Excellent"
    ]
)


# ==================================================
# 10. CREATE EXPOSURE CATEGORY
# ==================================================

df["Loan_Exposure_Category"] = pd.cut(
    df["Loan_to_Income_Ratio"],
    bins=[
        -float("inf"),
        1,
        3,
        5,
        10,
        float("inf")
    ],
    labels=[
        "Low",
        "Moderate",
        "High",
        "Very High",
        "Extreme"
    ]
)


# ==================================================
# 11. VERIFY CREATED FEATURES
# ==================================================

created_columns = [
    "Approval_Days",
    "Loan_to_Income_Ratio",
    "Loan_to_Income_Exposure_%",
    "Application_Year",
    "Application_Month",
    "Application_Month_Name",
    "Approval_Year",
    "Loan_Size_Category",
    "Credit_Score_Category",
    "Loan_Exposure_Category"
]

print("\n========== CREATED FEATURES ==========\n")

print(df[created_columns].head(10))


# ==================================================
# 12. VERIFY DATA QUALITY
# ==================================================

print("\n========== PROCESSED DATA QUALITY ==========\n")

print("Rows:", len(df))
print("Columns:", len(df.columns))

print(
    "Missing values:",
    df.isnull().sum().sum()
)

print(
    "Duplicate rows:",
    df.duplicated().sum()
)

print(
    "Negative approval days:",
    (df["Approval_Days"] < 0).sum()
)


# ==================================================
# 13. SAVE PROCESSED DATASET
# ==================================================

df.to_csv(
    OUTPUT_PATH,
    index=False
)

print("\n========== DATASET SAVED ==========\n")

print(OUTPUT_PATH)