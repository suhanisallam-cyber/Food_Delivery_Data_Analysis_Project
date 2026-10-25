import pandas as pd

# Load the food delivery dataset
df = pd.read_csv("food_delivery_analysis.csv")

# Check dataset size
print("Dataset shape:", df.shape)

# Display first 5 rows
print(df.head())

# Check column names
print(df.columns.tolist())

# Check missing values
print(df.isnull().sum())

# Check duplicate records
print("Duplicate rows:", df.duplicated().sum())

# Check missing values
print("\nMissing values before cleaning:")
print(df.isnull().sum())

# Remove duplicate records
df = df.drop_duplicates()

# Remove extra spaces from column names
df.columns = df.columns.str.strip()

# Clean extra spaces from text columns
for col in df.select_dtypes(include="object").columns:
    df[col] = df[col].str.strip()

# Check dataset after cleaning
print("\nDataset shape after cleaning:", df.shape)

print("\nMissing values after cleaning:")
print(df.isnull().sum())

# Clean the time_taken_min column
df["time_taken_min"] = pd.to_numeric(
    df["time_taken_min"], errors="coerce"
)

# Replace invalid or negative delivery times with missing values
df.loc[df["time_taken_min"] <= 0, "time_taken_min"] = pd.NA

# Check missing values
print("Missing delivery times:", df["time_taken_min"].isna().sum())

# Check minimum and maximum delivery time
print("Minimum time:", df["time_taken_min"].min())
print("Maximum time:", df["time_taken_min"].max())

# Save cleaned dataset
df.to_csv("food_delivery_cleaned.csv", index=False)

print("\nCleaned dataset saved successfully!")