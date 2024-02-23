# Automobile Data Analysis

## Description

This project involves comprehensive analysis of automobile data to predict various factors such as price and symboling (insurance risk rating) using machine learning models. The analysis includes data cleaning, exploratory data analysis (EDA), principal component analysis (PCA), correlation analysis, and predictive modeling using random forests.

## Installation

This project requires R and several R packages. Install the necessary packages using the following R commands:

```R
install.packages("readr")
install.packages("knitr")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("ggfortify")
install.packages("randomForest")
install.packages("reshape2")
```

## Dataset

Analysis is conducted on a dataset encompassing 205 automobiles with 26 unique columns, focusing on their specifications and insurance risk ratings. Preprocessing involved cleansing missing values, data type adjustments, and categorizing variables as factors.

## Usage

- **Data Preprocessing**: Cleanse the dataset by removing missing values and transforming relevant columns to numeric or factor types.
- **Exploratory Data Analysis (EDA)**: Utilize `ggplot2` for visual analysis, understanding variable distributions and their impact on safety ratings.
- **Principal Component Analysis (PCA)**: Apply PCA to reduce dimensions and highlight significant variables.
- **Random Forest Classification**: Predict safety ratings based on automobile features.
- **K-Means Clustering**: Group automobiles to uncover patterns related to safety and car features.

## Results and Conclusions

The project uncovers that larger cars, as indicated by dimensions like wheelbase and curb weight, are generally safer. Price, surprisingly, does not strongly correlate with safety ratings, suggesting that size and specific features play a more crucial role in determining automobile safety.
