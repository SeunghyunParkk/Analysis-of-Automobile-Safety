# **Analysis of Automobile Safety: Random Forest Classification & Clustering**

## **Overview**
This project explores **automobile safety** by analyzing car specifications and their **insurance risk ratings** using **Random Forest Classification** and **K-Means Clustering**. The study investigates common beliefs such as:
- Do **larger cars** tend to be safer?
- Do **luxury cars** have better safety ratings?

Using a dataset of **205 automobiles** with **26 features**, the project aims to uncover insights into car safety and the factors influencing it.

## **Dataset**
The dataset includes detailed automobile specifications and **symboling** values, which serve as **insurance risk ratings**:
- **Symboling Scale**: +3 (high risk) to -3 (low risk)
- **Features**: Car brand, model, engine specifications, body type, fuel type, dimensions, weight, and more.

## **Data Preprocessing**
### **Handling Missing Values**
- The dataset contained **‘?’ values** (59 instances), which were treated as missing data.
- The **‘normalized.losses’** column was dropped due to a high proportion of missing values.
- Rows with missing values in other columns were removed.

### **Data Type Adjustments**
- Some **numeric features** were incorrectly categorized as **strings** and were converted to numerical types.
- **Categorical variables** (`make`, `fuel type`, `body style`, etc.) were encoded as factors for classification.
- The **‘symboling’** variable, originally numerical, was transformed into a categorical feature for classification.

## **Exploratory Data Analysis**
### **Key Findings**
- **Volvo cars** had lower **symboling values**, indicating higher safety.
- A **negative correlation** was observed between **wheelbase length** and **symboling**, suggesting that **bigger cars are safer**.
- **Luxury cars (e.g., Porsche, Alfa Romeo)** did not necessarily have better safety ratings.

### **Principal Component Analysis (PCA) & Correlation**
- Features such as **wheelbase, length, width, curb weight, and engine size** were strongly correlated.
- **Larger cars** tend to be **heavier**, **more powerful**, but also **less fuel-efficient**.
- **Compression ratio and peak RPM** were inversely related to **symboling**, indicating that **high-performance cars might not always be safer**.

## **Model Selection & Methodology**
### **Predictor Selection**
- To avoid **multicollinearity**, highly correlated features such as **length, width, engine size, and fuel efficiency** were excluded.
- The **Random Forest model** was used to identify key safety predictors.
- **Feature importance** was assessed using **Mean Decrease Accuracy** and **Mean Decrease Gini**.

### **Why Random Forest Classification?**
- Handles **both numerical and categorical** variables.
- Manages **high-dimensional data** effectively.
- Reduces **overfitting** and improves **prediction accuracy**.

### **K-Means Clustering for Additional Insights**
- Used to explore relationships between:
  - **Wheelbase & Symboling**
  - **Price & Symboling**
- Helped visualize patterns in **car size and safety**.

## **Results**
### **Random Forest Model Performance**
- The **Out-of-Bag (OOB) error** was **11.85%**.
- The model achieved **79.3% accuracy** on the test dataset.
- Key safety predictors:  
  - **Make, Wheelbase, height, curb weight, number of doors, horsepower, body style, and bore size**.
- **Larger cars** were more likely to be safer, but **luxury status did not guarantee better safety ratings**.

### **Clustering Analysis**
#### **Cluster Analysis on Wheelbase**
| Cluster | Avg. Wheelbase | Avg. Symboling |
|---------|--------------|--------------|
| 1       | 94.69       | 1.20         |
| 2       | 101.48      | 0.53         |
| 3       | 110.94      | -0.30        |

- **Smaller cars** had **higher risk ratings**, supporting the hypothesis that **larger cars tend to be safer**.

#### **Cluster Analysis on Price**
| Cluster | Avg. Price | Avg. Symboling |
|---------|-----------|--------------|
| 1       | $8,311   | 0.87         |
| 2       | $17,048  | 0.70         |
| 3       | $34,997  | 0.63         |

- **Higher price did not strongly correlate with lower risk**, challenging the assumption that **luxury cars are safer**.

## **Conclusion**
- **Car size (wheelbase, height, curb weight)** is a strong predictor of **safety**.
- **Luxury cars do not necessarily have better safety ratings**.
- **Random Forest Classification** effectively predicted car safety with **79.3% accuracy**.
- **K-Means Clustering** confirmed that **larger cars tend to have lower risk ratings**.

This study provides **data-driven insights** into automobile safety, challenging common assumptions about luxury cars and reinforcing the importance of **vehicle size** in safety considerations.
