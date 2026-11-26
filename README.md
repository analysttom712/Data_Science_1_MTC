# Data Science Labs

Coursework for an applied data science course using R. The repository currently contains four lab scripts, progressing from R fundamentals and data preparation to simple and multiple linear regression.

## Labs

| Lab | Topic | What it covers |
|-----|-------|----------------|
| 1 | Getting started with R | Variables and data types, arithmetic, functions, vectors, importing CSV files, creating data-frame columns, and summary statistics using sales and student-grade data. |
| 2 | Data preprocessing and categorical encoding | Inspecting data, imputing missing numeric values with column means, comparing label and one-hot encoding, scaling numeric features, and creating a reproducible training/test split with `caret`. |
| 3 | Simple linear regression | Predicting salary from years of experience; exploring the relationship, fitting and interpreting `lm()`, evaluating test predictions with RMSE and MAE, and examining residuals. |
| 4 | Multiple linear regression | Predicting sales from TV, radio, and newspaper advertising; exploring correlations, fitting and evaluating a multiple regression model, analyzing residuals, and comparing full and reduced models. |

## Requirements

Install the packages used by the labs:

```r
install.packages(c("caret", "tibble", "ggplot2"))
```

Lab 1 uses base R. Lab 2 loads `caret` and `tibble`; Labs 3 and 4 use `ggplot2` for visualizations.

## Running a lab

Open the lab's R script in RStudio and run it from its containing folder. The scripts use relative file paths, so put the required CSV file alongside the script before running it:

| Lab | Required data files |
|-----|---------------------|
| 1 | `sales_data.csv`, `student_grades.csv` |
| 2 | `Data.csv` |
| 3 | `Salary_dataset.csv` |
| 4 | `advertising.csv` |

These course datasets are not included in the repository. Obtain them from the course materials. The scripts do not require a separate `data/` directory.

## Repository contents

The repository contains the four lab R scripts, this README, and `.gitignore`. There is no final project or rendered report in the current repository contents.

## Author

**Tom** — [@analysttom712](https://github.com/analysttom712)

---

*This repository contains coursework. Current students should follow their course's academic integrity policy.*
