import pandas as pd
from pathlib import Path


# ==================================================
# 1. LOAD DATA
# ==================================================

PROJECT_ROOT = Path(__file__).resolve().parents[1]

DATA_PATH = PROJECT_ROOT / "data" / "Banking_Credit_Risk_Dataset.csv"

df = pd.read_csv(DATA_PATH)


# ==================================================
# 2. CONVERT DATES
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
# 3. DATE QUALITY CHECK
# ==================================================

print("\n========== DATE QUALITY ==========\n")

print(
    "Invalid Application Dates:",
    df["Application_Date"].isna().sum()
)

print(
    "Invalid Approval Dates:",
    df["Approval_Date"].isna().sum()
)


# ==================================================
# 4. APPROVAL PROCESSING TIME
# ==================================================

df["Approval_Days"] = (
    df["Approval_Date"] - df["Application_Date"]
).dt.days


print("\n========== APPROVAL TIME ==========\n")

print(
    df["Approval_Days"].describe()
)

print(
    "\nNegative approval times:",
    (df["Approval_Days"] < 0).sum()
)


# ==================================================
# 5. NUMERICAL RANGE CHECK
# ==================================================

print("\n========== NUMERICAL RANGES ==========\n")

numeric_columns = [
    "Age",
    "Annual_Income",
    "Credit_Score",
    "Existing_Loans_Count",
    "Dependents",
    "Account_Balance",
    "Loan_Amount",
    "Loan_Term_Months",
    "Interest_Rate",
    "Debt_to_Income_Ratio_%"
]

for column in numeric_columns:

    print(f"\n--- {column} ---")

    print("Minimum:", df[column].min())
    print("Maximum:", df[column].max())
    print("Mean:", round(df[column].mean(), 2))
    print("Median:", round(df[column].median(), 2))


# ==================================================
# 6. NEGATIVE VALUE CHECK
# ==================================================

print("\n========== NEGATIVE VALUES ==========\n")

for column in numeric_columns:

    negative_count = (df[column] < 0).sum()

    print(
        f"{column}: {negative_count}"
    )


# ==================================================
# 7. UNIQUE VALUES
# ==================================================

print("\n========== UNIQUE VALUES ==========\n")

categorical_columns = [
    "Gender",
    "Marital_Status",
    "Education_Level",
    "Employment_Type",
    "Region",
    "Loan_Purpose",
    "Loan_Status"
]

for column in categorical_columns:

    print(f"\n--- {column} ---")

    print(df[column].unique())


# ==================================================
# 8. LOAN STATUS VS DEFAULT FLAG
# ==================================================

print("\n========== STATUS / FLAG CONSISTENCY ==========\n")

status_flag_table = pd.crosstab(
    df["Loan_Status"],
    df["Default_Risk_Flag"]
)

print(status_flag_table)


# ==================================================
# 9. CUSTOMER / LOAN UNIQUENESS
# ==================================================

print("\n========== ID UNIQUENESS ==========\n")

print(
    "Unique Customers:",
    df["Customer_ID"].nunique()
)

print(
    "Unique Loans:",
    df["Loan_ID"].nunique()
)

print(
    "Rows:",
    len(df)
)


# ==================================================
# 10. DATA QUALITY SUMMARY
# ==================================================

print("\n========== DATA QUALITY SUMMARY ==========\n")

print("Rows:", len(df))
print("Columns:", len(df.columns))
print("Duplicates:", df.duplicated().sum())
print("Missing Values:", df.isnull().sum().sum())

print(
    "Negative Approval Days:",
    (df["Approval_Days"] < 0).sum()
)

print(
    "Default Rate:",
    round(
        (df["Loan_Status"] == "Default").mean() * 100,
        2
    ),
    "%"
)



