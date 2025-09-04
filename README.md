# 🏎️ BMW Sales Data Analysis & Pipeline

## 📌 Project Overview  
This project analyzes **BMW car sales data (2010–2024)** to uncover insights into sales trends, regional performance, pricing, and revenue.  

The workflow is automated using **Prefect** to ensure reproducibility, and multiple **visualizations** are created to make the insights easy to understand.

It covers:
1. **Data Cleaning** – handling missing values, duplicates, and inconsistent data.  
2. **Exploratory Data Analysis (EDA)** – visualization with Matplotlib, Seaborn, and Plotly.  
3. **Feature Engineering** – creating new variables for deeper insights.  
4. **Hypothesis Testing** – applying statistical methods (Scipy, Statsmodels).  
5. **Pipeline Automation (Optional)** – orchestrating the workflow using Prefect / Airflow.  

## 📂 Dataset  
The dataset contains the following key columns:  

- `Model` → Car model name  
- `Year` → Year of sales  
- `Region` → Geographic region of sales  
- `Color` → Car color  
- `Fuel_Type`, `Transmission`, `Engine_Size_L` → Car specifications  
- `Mileage_KM` → Mileage driven  
- `Price_USD` → Price of the car in USD  
- `Sales_Volume` → Number of cars sold  
- `Revenue of each model` → Total revenue for each model  
- `Price_Bin` → Price categories (`Low`, `Medium`, `High`, `Luxury`)  

---

## 🧹 Data Cleaning & Preprocessing  
1. **Removed duplicates** to ensure unique records.  
2. **Handled missing values** → filled `Price_USD` with median.  
3. **Created new features**:  
   - `Revenue of each model` = `Price_USD × Sales_Volume`  
   - `Price_Bin` → categorized cars into `Low`, `Medium`, `High`, and `Luxury`.  

All steps are automated via a **Prefect pipeline**.

---

## 📊 Analysis & Visualizations  

### 1. **Revenue by Region**
![Revenue by Region](images/revenue_by_region.png)  
Bar chart of total revenue in each region.  
➡️ **Insight**: Shows which regions generate the most revenue.

---

### 2. **Revenue Trend Over Years**
![Revenue Trend](images/revenue_trend.png)  
Line chart showing revenue growth from 2010 to 2024.  
➡️ **Insight**: Reveals upward/downward sales patterns.

---

### 3. **Sales Volume by Region**
![Sales Volume](images/sales_volume.png)  
Bar chart of total cars sold in each region.  
➡️ **Insight**: Identifies the strongest customer bases.

---

### 4. **Number of Cars per Price Category**
![Price Category](images/price_bin.png)  
Countplot showing cars in `Low`, `Medium`, `High`, and `Luxury`.  
➡️ **Insight**: Most BMW models fall into the `High` and `Luxury` segments.

---

### 5. **Revenue vs Price (Bubble Plot)**
![Revenue vs Price](images/revenue_vs_price.png)  
Scatter plot with bubble size = sales volume.  
➡️ **Insight**: Shows which price points generate the most revenue.

---

### 6. **Average Price Trend Over Years**
![Average Price](images/avg_price_trend.png)  
Line chart of average price per year.  
➡️ **Insight**: BMW has steadily increased pricing.

---

### 7. **Distribution of Regions**
![Region Distribution](images/region_pie.png)  
Pie chart of dataset distribution by region.  
➡️ **Insight**: Europe and Asia dominate the dataset.

---

### 8. **Statistical Analysis**
- **T-test**: compared car prices in Europe vs Asia.  
  - Result: Significant difference (p-value < 0.05).  
- **Chi-square test**: tested association between `Price_Bin` and `Region`.  
  - Result: Price categories are not evenly distributed across regions.  

---

### 9. **Boxplot & Heatmap**
![Boxplot](images/boxplot_europe_asia.png)  
![Heatmap](images/heatmap_price_region.png)  
➡️ **Insight**: Confirms differences in price distributions between regions.

---

## ⚙️ Automation with Prefect  

The workflow is automated using **Prefect** tasks and flows:  

- `load_data` → reads the dataset  
- `clean_data` → removes duplicates & fills missing values  
- `analyze_data` → generates descriptive statistics  
- `main_pipeline` → orchestrates the workflow  

Example snippet:  

```python
from prefect import flow, task
import pandas as pd

@task
def load_data(path):
    return pd.read_csv(path)

@task
def clean_data(df):
    df = df.drop_duplicates()
    df['Price_USD'] = df['Price_USD'].fillna(df['Price_USD'].median())
    return df

@task
def analyze_data(df):
    return df.describe()

@flow
def main_pipeline(path="BMW_sales.csv"):
    df = load_data(path)
    df = clean_data(df)
    summary = analyze_data(df)
    print(summary)

