# Retail Sales Analysis — SQL + Excel

End-to-end analysis of 3,464 retail transactions (1,850 orders) across U.S. regions, using **SQL** for data extraction/aggregation and **Excel** for dashboard visualization. The project identifies a discount threshold beyond which the business loses money, and delivers data-backed pricing recommendations.

## 📊 Project Overview

| | |
|---|---|
| **Dataset** | 3,464 line items, 1,850 orders, 2023–2025 |
| **Tools** | SQL (SQLite), Microsoft Excel |
| **Categories** | Furniture, Office Supplies, Technology |
| **Regions** | Central, East, South, West |

## 🔍 Key Finding

Profit margin erodes steadily as discount increases:

| Discount Band | Profit Margin |
|---|---|
| 0% (No Discount) | 14.57% |
| 1–15% | 9.80% |
| 16–30% | 4.69% |
| 31%+ | **-3.80%** |

**436 transactions (12.6%) were sold at a loss, totaling –$30,478.90** — averaging a 25.5% discount, nearly double the portfolio average.

## 🛠️ What's in This Repo

- `analysis_queries.sql` — 10 SQL queries covering regional performance, top products, customer segments, discount-margin impact, and loss analysis
- `superstore_sales.csv` — the dataset used
- `Retail_Sales_Analysis_Dashboard.xlsx` — interactive Excel dashboard with 5 sheets, live formulas (SUMIFS, SUMPRODUCT), conditional-formatting heatmap, and charts
- `Retail_Sales_Analysis_Report.docx` — full written report with methodology, query results, findings, and recommendations

## ✅ Recommendations

- Cap discounts at 20–25% on Technology hardware
- Review Furniture pricing — margin is under 5%, roughly a third of Office Supplies' margin
- Investigate loss-making transactions for patterns by rep, customer, or time period
- Prioritize Home Office segment — highest profit per dollar of sales

## 👤 Author

**Mohammed Tabras Khan**
