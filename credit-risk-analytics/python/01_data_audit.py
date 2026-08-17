import pandas as pd
from pathlib import Path


# --------------------------------------------------
# 1. Locate dataset
# --------------------------------------------------

PROJECT_ROOT = Path(__file__).resolve().parents[1]

DATA_PATH = PROJECT_ROOT / "data" / "Banking_Credit_Risk_Dataset.csv"


# --------------------------------------------------
# 2. Load dataset
# --------------------------------------------------

df = pd.read_csv(DATA_PATH)


# --------------------------------------------------
# 3. Basic dataset information
# --------------------------------------------------

print("\n========== DATASET OVERVIEW ==========\n")

print("Rows:", df.shape[0])
print("Columns:", df.shape[1])

print("\nColumn Names:")
print(df.columns.tolist())


# --------------------------------------------------
# 4. First five records
# --------------------------------------------------

print("\n========== FIRST 5 RECORDS ==========\n")

print(df.head())


# --------------------------------------------------
# 5. Data types
# --------------------------------------------------

print("\n========== DATA TYPES ==========\n")

print(df.dtypes)


# --------------------------------------------------
# 6. Missing values
# --------------------------------------------------

print("\n========== MISSING VALUES ==========\n")

missing_values = df.isnull().sum()

print(missing_values)


# --------------------------------------------------
# 7. Duplicate records
# --------------------------------------------------

print("\n========== DUPLICATES ==========\n")

print("Duplicate rows:", df.duplicated().sum())


# --------------------------------------------------
# 8. Numerical summary
# --------------------------------------------------

print("\n========== NUMERICAL SUMMARY ==========\n")

print(df.describe())


# --------------------------------------------------
# 9. Categorical summary
# --------------------------------------------------

print("\n========== CATEGORICAL SUMMARY ==========\n")

categorical_columns = df.select_dtypes(
    include="object"
).columns

for column in categorical_columns:
    print(f"\n--- {column} ---")
    print(df[column].value_counts())


# --------------------------------------------------
# 10. Target distribution
# --------------------------------------------------

print("\n========== LOAN STATUS ==========\n")

print(df["Loan_Status"].value_counts())

print("\nLoan Status Percentage:")

print(
    df["Loan_Status"]
    .value_counts(normalize=True)
    .mul(100)
    .round(2)
)