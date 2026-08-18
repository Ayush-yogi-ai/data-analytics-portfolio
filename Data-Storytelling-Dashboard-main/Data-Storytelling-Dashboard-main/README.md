# Data Storytelling Dashboard, E-Commerce Analytics

An interactive **data visualization and analytics dashboard** that transforms raw e-commerce data into **actionable business insights**.  
Built with **Python**, **Streamlit**, and **Plotly**, this project demonstrates advanced **data storytelling**, combining statistical analysis, cohort segmentation, and dynamic visualization.

---

## Project Overview

This dashboard simulates a full-fledged analytics workflow for an e-commerce company.  
It provides end-to-end functionality from data ingestion and cleaning to **KPI reporting**, **customer segmentation**, **retention analysis**, and **geographical sales intelligence**.

The project is powered by a **synthetic dataset** (4,000+ orders across 2 years, 1,600+ customers, 10+ countries, and 5 categories).  

---

## Objectives

1. **Tell a story with data:** Convert large, unstructured datasets into interactive visual narratives.  
2. **Build an analyst-friendly interface:** Enable filtering by country, channel, category, and time period.  
3. **Provide actionable insights:** Identify best-performing channels, categories, and customer segments.  
4. **Demonstrate advanced analytics:** Use RFM segmentation and cohort analysis to uncover retention patterns.  

---

## Key Metrics & Definitions

| Metric | Description |
|--------|--------------|
| **Revenue** | Total gross sales after discounts |
| **Profit** | Revenue − Cost |
| **Orders** | Number of unique purchase transactions |
| **Customers** | Number of unique buyers |
| **AOV (Average Order Value)** | Mean revenue per order |
| **Margin %** | Profit ÷ Revenue |

---

## Analytics Features

**KPI Cards** | Summaries for Revenue, Profit, Orders, Customers, AOV, and Margin  
**Trend Charts** | Monthly revenue & profit trends  
**Category & Product Insights** | Top-performing product lines  
**Channel Revenue Share** | Pie chart for sales by acquisition channel  
**Geographical Breakdown** | Country → City treemap for global sales distribution  
**Cohort Retention Analysis** | Track customer re-purchase behavior  
**RFM Segmentation** | Classify customers into “Champions”, “Active”, and “New/Cold”  

---

## Dashboard Preview

### KPI Overview & Monthly Revenue Trends
<img width="1358" height="443" alt="Screenshot 2025-11-01 at 19-31-23 Data Storytelling Dashboard" src="https://github.com/user-attachments/assets/4fc7a6fa-5303-46c1-9e78-df21b75003e2" />

### Monthly Revenue & Profit
<img width="1281" height="420" alt="newplot(3)" src="https://github.com/user-attachments/assets/418bf06b-c301-422b-ba50-14889734c701" />

### Customers by RFM Segment
<img width="1281" height="450" alt="newplot(8)" src="https://github.com/user-attachments/assets/66902cad-0c84-4200-b2ca-45e1af2d020e" />

### Channel Revenue Share
<img width="1281" height="450" alt="newplot(7)" src="https://github.com/user-attachments/assets/1002f593-afc3-48cb-9d3d-f8e158535b1c" />

### Revenue by Geography (Country → City)
<img width="1281" height="450" alt="newplot(6)" src="https://github.com/user-attachments/assets/9194c3af-fe88-41cb-87ee-22d3967ab082" />

### Top 15 Products
<img width="632" height="450" alt="newplot(5)" src="https://github.com/user-attachments/assets/c079b4bf-05a2-4a6c-8354-a9b948c15263" />

### Revenue by Category
<img width="632" height="450" alt="newplot(4)" src="https://github.com/user-attachments/assets/6267779a-54ca-455a-854a-3eebc0e6105c" />

---

## Analytical Highlights

- **Total Revenue:** $9.8 M  
- **Total Profit:** $3.0 M (~31% margin)  
- **Active Customers:** 1,613  
- **Top Channel:** Web (44.5%)  
- **Leading Category:** Electronics (~ $2.3 M)  
- **Customer Segmentation:**  
  - 42% New/Cold  
  - 30% Active  
  - 28% Champions  

These insights are based on synthetic two-year transaction data.  

---

## Tech Stack

| Component | Description |
|------------|-------------|
| **Python** | Data processing & analytics |
| **Pandas / NumPy** | Data wrangling & KPI computation |
| **Streamlit** | Web-based dashboard |
| **Plotly** | Interactive visualizations |
| **Statsmodels / Prophet (optional)** | Time series forecasting |
| **Scikit-Learn** | RFM modeling & segmentation |
| **Great Expectations / Pandera** | Future data-quality integration |

---

## Getting Started

### Clone the Repository
```bash
git clone https://github.com/yourusername/data-storytelling-dashboard.git
cd data-storytelling-dashboard
```

### Install Dependencies
```bash
pip install -r requirements.txt
```

### Run the Dashboard
```bash
streamlit run app/app.py
```

The app will open at `http://localhost:8501/`.

### (Optional) Use Your Own Dataset
```bash
export ORDERS_CSV=/path/to/your/orders.csv
# Windows PowerShell
$env:ORDERS_CSV="C:\path\orders.csv"
```

Your dataset must include:  
`order_id`, `order_date`, `customer_id`, `country`, `city`, `channel`, `product_id`, `category`, `subcategory`, `unit_price`, `quantity`, `discount`, `revenue`, `cost`.

---

## Folder Structure
```
data_storytelling_dashboard/
├── data/
│   └── orders.csv              # Synthetic e-commerce dataset
├── app/
│   ├── app.py                  # Streamlit main app
│   └── utils/
│       └── data_utils.py       # Functions for KPIs, filtering, cohort, RFM
├── requirements.txt
└── README.md
```

---

## Possible Extensions

- **Sales Forecasting** (Prophet / ARIMA)  
- **Customer Churn Prediction** using classification models  
- **Marketing ROI Analytics** & A/B testing  
- **Enhanced Geo-maps** using Plotly Choropleths  
- **Automated Insight Narratives** (LLM-based summaries)  
- **Deployment** via Streamlit Cloud / Render / Hugging Face Spaces  

---

## Insights Summary (Example Story)

> “Between Jan 2023 and Oct 2024, overall revenue reached **$9.8 M** with an average margin of **30.9 %**.  
> The **Web** and **Mobile App** channels contributed **75 %** of total sales.  
> Electronics dominated category performance, while the **India** and **Germany** markets showed the highest growth rates.  
> Customer retention remains strong across cohorts, with ~30 % returning after 6 months.”
