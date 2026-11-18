# Customer Churn Analysis | Excel,Python, MySQL & Power BI

customer churn analysis project covering data cleaning with **Python (Pandas and NumPy)**, exploratory business queries in **MySQL**, and an interactive **Power BI** report. The purpose is to examine customer churn alongside contracts, subscriptions, payments, services, geography, and customer value.

> **Project integrity:** This README documents the supplied project as-is. It does not claim that the original data, code, SQL, or dashboard were modified or that SQL queries were executed during documentation.
> 
## 📊 Customer Churn Dashboard

![Customer Churn Analysis Dashboard](dashboard.png)

## Project files

| File | Purpose |
|---|---|
| `Churn_Unclean_Project.xlsx` | Original Excel dataset |
| `Churn Dataset Cleaning.ipynb` | Python notebook for cleaning, feature engineering, and MySQL export |
| `Clean_Churn_Data.csv` | Exported cleaned dataset used for the statistics below |
| `Analysis Queries.sql` | Original MySQL business-analysis queries |
| `CUSTOMER CHURN.pbix` | Interactive Power BI report |

*File names above match the supplied uploads. Rename references in the notebook if you rename files locally.*

## Dataset overview

The supplied cleaned CSV contains **492 records and 23 columns**.

| Churn status | Customers |
|---|---:|
| Yes | 116 |
| No | 374 |
| Missing | 2 |
| **Total** | **492** |

- **Churn rate using all rows (as written in the original SQL):** 116 / 492 × 100 = **23.58%**.
- **Churn rate among known churn statuses:** 116 / 490 × 100 = **23.67%**.
- These percentages use different denominators; they are not interchangeable.

**Columns:** `Customer_ID`, `Customer_Name`, `Gender`, `Age`, `State`, `City`, `Tenure_Months`, `Subscription_Type`, `Monthly_Charges`, `Total_Charges`, `Contract_Type`, `Payment_Method`, `Internet_Service`, `Tech_Support`, `Senior_Citizen`, `Dependents`, `Churn`, `Last_Interaction_Date`, `Customer_Value`, `Monthly_Revenue`, `Tenure_Group`, `Senior_Flag`, `Churn_Flag`.

**Data quality note:** Some missing values remain in the exported CSV, including 2 missing `Churn` entries. The notebook fills selected fields but does not fill every missing categorical value.

## Workflow

### 1. Python data cleaning

The original notebook follows these steps:

1. Import Pandas and NumPy; load the unclean Excel workbook.
2. Inspect the data using `head()`, `info()`, `describe()`, and `shape`.
3. Check null values and duplicate rows; drop duplicate rows.
4. Replace placeholder strings (`N/A`, `NULL`, blank strings, and spaces) with missing values.
5. Strip whitespace from text fields and standardize selected text columns to title case, including `Churn`.
6. Strip whitespace from column headers and convert `Age`, `Tenure_Months`, `Monthly_Charges`, and `Total_Charges` to numeric types.
7. Filter ages to **18–100** and remove negative monthly and total charges.
8. Convert `Last_Interaction_Date` to datetime.
9. Fill missing `Tech_Support` with `No`, `Payment_Method` with `Unknown`, and selected numeric fields with their means.
10. Create additional fields:
    - `Customer_Value = Monthly_Charges × Tenure_Months`
    - `Monthly_Revenue = Monthly_Charges`
    - `Tenure_Group`: 0–12, 13–24, 25–48, 49–72 months
    - `Senior_Flag`: `Senior` when age is at least 60, otherwise `Adult`
    - `Churn_Flag`: `Yes` → 1, `No` → 0
11. Fill missing interaction dates with the median date, perform final checks, export to CSV, and write to the MySQL table `churndb.customer_churn` using SQLAlchemy.

**Interpretation note:** `Customer_Value` is a calculated proxy based on monthly charges and tenure, not a predictive customer lifetime value model.

### 2. MySQL analysis

The original `Analysis Queries(1).sql` uses the `churndb` database and `customer_churn` table to explore:

| Analysis | What the original query calculates |
|---|---|
| Total customers | Row count |
| Total churn customers | Count where `Churn = 'Yes'` |
| Payment methods | Customer count by payment method |
| Monthly charges by payment method | Sum of monthly charges by payment method |
| Subscription types | Customer count by subscription type |
| Highest-revenue states | Sum of `Total_Charges` by state, descending |
| Average charges by contract | Average monthly charges by contract type |
| Senior-citizen churn | Churned-customer count grouped by `Senior_Citizen` |
| Top 10 high-value customers | Top customers by calculated `Customer_Value` |
| Customers without tech support | Count filtered to `Tech_Support = 'No'` |
| Churn rate | Churned count divided by **all** rows, multiplied by 100 |
| Average monthly charges | Average of `Monthly_Charges` |
| Contract-type breakdown | **All** customers by contract type |
| Internet-service breakdown | **All** customers by internet service |
| Churn by state | Churned-customer count by state |

**SQL caveats:** The contract-type and internet-service queries are labeled as churn analyses in comments but do not filter for churn. The tech-support query combines `Tech_Support` and `COUNT(*)` without `GROUP BY`; behavior can depend on MySQL SQL mode. The README describes the queries without silently changing them.

### 3. Power BI dashboard

The supplied `.pbix` contains a Power BI report with a KPI card, column and bar charts, donut charts, a line chart, and a slicer, as well as text and shape elements. The dashboard is intended to present customer churn and related segmentation visually.

**Dashboard preview:** Add an exported screenshot of your actual report as `dashboard.png`, then uncomment the line below:

<!-- ![Customer Churn Power BI Dashboard](dashboard.png) -->

## Key findings supported by the supplied data

- The cleaned export has **492 customer records**.
- **116** records have `Churn = Yes`; **374** have `Churn = No`; **2** have missing churn status.
- The overall churn percentage is **23.58% using all records**, matching the denominator used in the original SQL.
- The project includes analyses of customer mix, charges, geography, and churn counts. Specific segment-level conclusions should be drawn from the actual SQL outputs or dashboard, rather than assumed from the query names.

## Tools and technologies

- **Python:** Pandas, NumPy
- **Excel:** Source workbook
- **MySQL:** Database and SQL queries
- **SQLAlchemy + PyMySQL:** Python-to-MySQL export
- **Power BI:** Interactive reporting
- **Jupyter Notebook:** Cleaning workflow

## How to explore the project

1. Open `Churn Dataset Cleaning.ipynb` to review the original cleaning and derived columns.
2. Inspect `Clean_Churn_Data.csv` for the exported dataset.
3. Open `Analysis Queries.sql` in MySQL Workbench. Its queries expect a populated `churndb.customer_churn` table.
4. Open `CUSTOMER CHURN.pbix` in Power BI Desktop to explore the report.

**Security and publishing:** The supplied notebook contains a literal MySQL connection password. **Do not publish the notebook publicly with that credential.** Remove or replace the credential in a *separate public copy* before uploading, while retaining your original file unchanged. Also verify that customer names and other record-level information are synthetic or authorized for public distribution before uploading the CSV or workbook.

## Project objective

Practice a complete analytics workflow: prepare messy customer data, examine churn and revenue-related questions with SQL, and communicate the results through an interactive dashboard.
