import pandas as pd
from pathlib import Path


# ==================================================
# 1. LOAD DATA
# ==================================================

PROJECT_ROOT = Path(__file__).resolve().parents[1]

DATA_PATH = PROJECT_ROOT / "data" / "Banking_Credit_Risk_Dataset.csv"

df = pd.read_csv(DATA_PATH)


# ==================================================
# 2. CALCULATE IMPLIED DTI
# ==================================================

# Loan amount / annual income
df["Loan_to_Income_Ratio"] = (
    df["Loan_Amount"] / df["Annual_Income"]
)


# ==================================================
# 3. COMPARE DTI WITH LOAN / INCOME
# ==================================================

print("\n========== DTI INVESTIGATION ==========\n")

print(
    df[
        [
            "Annual_Income",
            "Loan_Amount",
            "Debt_to_Income_Ratio_%",
            "Loan_to_Income_Ratio"
        ]
    ].head(20)
)


# ==================================================
# 4. DTI STATISTICS
# ==================================================

print("\n========== ORIGINAL DTI ==========\n")

print(
    df["Debt_to_Income_Ratio_%"].describe()
)


print("\n========== LOAN / INCOME RATIO ==========\n")

print(
    df["Loan_to_Income_Ratio"].describe()
)


# ==================================================
# 5. CORRELATION
# ==================================================

print("\n========== CORRELATION ==========\n")

print(
    df[
        [
            "Annual_Income",
            "Loan_Amount",
            "Debt_to_Income_Ratio_%",
            "Loan_to_Income_Ratio"
        ]
    ].corr()
)


# ==================================================
# 6. EXTREME DTI VALUES
# ==================================================

print("\n========== HIGHEST DTI VALUES ==========\n")

print(
    df[
        [
            "Annual_Income",
            "Loan_Amount",
            "Debt_to_Income_Ratio_%",
            "Loan_to_Income_Ratio",
            "Loan_Status"
        ]
    ]
    .sort_values(
        "Debt_to_Income_Ratio_%",
        ascending=False
    )
    .head(20)
)


# ==================================================
# 7. DTI PERCENTILE ANALYSIS
# ==================================================

print("\n========== DTI PERCENTILES ==========\n")

print(
    df["Debt_to_Income_Ratio_%"].quantile(
        [0.50, 0.75, 0.90, 0.95, 0.99, 1.00]
    )
)