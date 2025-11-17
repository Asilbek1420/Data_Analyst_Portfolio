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

