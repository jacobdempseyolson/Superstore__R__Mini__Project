# Importing necessary libraries
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load dataset
df = pd.read_csv('data/sales_data.csv')  # Adjust path to your dataset

# Data Cleaning
# Check for missing values and fill them with 0 for simplicity
print("Missing values:\n", df.isnull().sum())
df.fillna(0, inplace=True)

# Convert 'Date' column to datetime format (if applicable)
if 'Date' in df.columns:
    df['Date'] = pd.to_datetime(df['Date'])
    df['Month'] = df['Date'].dt.month  # Extract month for monthly trend analysis

# Exploratory Data Analysis (EDA)
# Summary statistics
print("\nSummary Statistics:\n", df.describe())

# Sales by Region
if 'Region' in df.columns and 'Sales' in df.columns:
    sales_by_region = df.groupby('Region')['Sales'].sum()
    print("\nTotal Sales by Region:\n", sales_by_region)

# Monthly Sales Trend
if 'Month' in df.columns and 'Sales' in df.columns:
    monthly_sales = df.groupby('Month')['Sales'].sum()
    print("\nMonthly Sales Trend:\n", monthly_sales)

# Data Visualization
# Set the style for seaborn plots
sns.set(style="whitegrid")

# 1. Bar plot for sales by region
if 'Region' in df.columns and 'Sales' in df.columns:
    plt.figure(figsize=(10,6))
    sns.barplot(x=sales_by_region.index, y=sales_by_region.values, palette='viridis')
    plt.title('Total Sales by Region')
    plt.xlabel('Region')
    plt.ylabel('Total Sales')
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.savefig('output/sales_by_region.png')  # Save plot as an image file
    plt.show()

# 2. Line plot for monthly sales trend
if 'Month' in df.columns and 'Sales' in df.columns:
    plt.figure(figsize=(10,6))
    sns.lineplot(x=monthly_sales.index, y=monthly_sales.values, marker='o', color='orange')
    plt.title('Monthly Sales Trend')
    plt.xlabel('Month')
    plt.ylabel('Total Sales')
    plt.tight_layout()
    plt.savefig('output/monthly_sales_trend.png')  # Save plot as an image file
    plt.show()

# Conclusion & Insights
print("\nKey Insights:")
if 'Region' in df.columns and 'Sales' in df.columns:
    max_sales_region = sales_by_region.idxmax()
    print(f" - The region with the highest total sales is: {max_sales_region} with {sales_by_region[max_sales_region]} in sales.")
if 'Month' in df.columns and 'Sales' in df.columns:
    best_sales_month = monthly_sales.idxmax()
    print(f" - The month with the highest sales is: {best_sales_month} with {monthly_sales[best_sales_month]} in sales.")

# Save final cleaned data to a new CSV file
df.to_csv('data/cleaned_sales_data.csv', index=False)
print("\nCleaned data has been saved to 'data/cleaned_sales_data.csv'")
