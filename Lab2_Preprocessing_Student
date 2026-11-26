# ============================================================================
# Lab 2: Data Preprocessing and Categorical Encoding
# ============================================================================

# Student name: Thomas Baynum
# Date: 09/30/2026

# PURPOSE --------------------------------------------------------------------

# Prepare a small dataset for later machine-learning activities by:
# - Identifying missing and categorical data
# - Replacing missing numerical values
# - Comparing label encoding and one-hot encoding
# - Scaling numerical variables
# - Creating training and test sets


# FILE AND PACKAGE SETUP -----------------------------------------------------

# Place Data.csv in the same folder as this R script.
# Do not use a personal setwd() path in the submitted script.

# Install caret only if it is not already installed:
# install.packages("caret")

library(caret)
library(tibble)


# PART 1: IMPORT AND INSPECT THE DATA ---------------------------------------

data <- read.csv("Data.csv", stringsAsFactors = FALSE)

# Display the dataset.
# TYPE YOUR CODE BELOW
print(data)

# Display the structure and summary of the dataset.
# TYPE YOUR CODE BELOW
str(data)
summary(data)

# Count missing values in each column.
# TYPE YOUR CODE BELOW
colSums(is.na(data))

# Display the unique values in Country and Purchased.
# TYPE YOUR CODE BELOW
unique(data$Country,data$Purchased)

# Answer in comments:
# 1. How many rows and columns are present?
# Answer:10rows and 4 columns 
print(data)
#
# 2. Which columns contain missing values?
# Answer:
# Age and Salary
# 3. Which variables are numerical?
# Answer:
# Age and Salary
# 4. Which variables are categorical?
# Answer:
# Country and Purchased

# PART 2: REPLACE MISSING NUMERICAL VALUES ---------------------------------

# Create a copy of the original dataset named cleaned_data.

# TYPE YOUR CODE BELOW
cleaned_data <- data

# Calculate the mean of Age while ignoring missing values.
# Store it in mean_age.
# TYPE YOUR CODE BELOW
mean(data$Age, na.rm = TRUE)
mean_age <- mean(data$Age, na.rm = TRUE)

# Replace missing Age values in cleaned_data with mean_age.

# TYPE YOUR CODE BELOW
cleaned_data$Age[is.na(cleaned_data$Age)] <- mean_age

# Calculate the mean of Salary while ignoring missing values.
# Store it in mean_salary.

# TYPE YOUR CODE BELOW
mean(data$Salary, na.rm = TRUE)
mean_salary <- mean(data$Salary, na.rm = TRUE)

# Replace missing Salary values in cleaned_data with mean_salary.

# TYPE YOUR CODE BELOW
cleaned_data$Salary[is.na(cleaned_data$Salary)] <- mean_salary

# Confirm that the numerical missing values have been replaced.

# TYPE YOUR CODE BELOW
colSums(is.na(cleaned_data))
print(cleaned_data)

# Answer in comments:
# 1. What value replaced the missing Age?
# Answer: 
# Japan's NA Age Value

# 2. What value replaced the missing Salary?
# Answer:
# Germany's NA Salary
# 3. Why should the mean be calculated with na.rm = TRUE?
# Answer:
# na.rm is removing the NA values from that column, if we didn't remove the 
# value the mean would return as na because it tries to calculate based on all
# values in that column.

# PART 3: LABEL ENCODING -----------------------------------------------------

# Create a copy of cleaned_data named label_data.

# TYPE YOUR CODE BELOW
label_data <- cleaned_data
print(cleaned_data)
# Label encode Country as:
# USA = 1, Japan = 2, Germany = 3

# TYPE YOUR CODE BELOW
label_data$Country <- factor(label_data$Country,
                      levels = c('USA', 'Japan', 'Germany'),
                      labels = c(1, 2, 3))

# Label encode Purchased as:
# No = 0, Yes = 1

# TYPE YOUR CODE BELOW
label_data$Purchased <- factor(label_data$Purchased,
                               levels = c("No", "Yes"),
                               labels = c(0, 1))

# Display label_data and its structure.

# TYPE YOUR CODE BELOW
print(label_data)
str(label_data)

# Answer in comments:
# 1. Does Country have a natural order?
# Answer: 
# No, country does not have a natural ranking or order because USA, Japan, and
# Germany are categories without ranking.
# 2. Why can label encoding Country cause a model to make an incorrect
#    assumption about the categories?
# Answer: 
# Label encoding assigns numbers to countries and makes assumptions that the 
#countries have a meaningful order or numerical relationship
# 3. Why is encoding Purchased as 0 and 1 reasonable for a binary outcome?
# Answer: Yes, because it can help make it easier for machine learning models to
# identify and predict whether purchases occurred


# PART 4: ONE-HOT ENCODING --------------------------------------------------

# Create a new copy of cleaned_data named onehot_data.

# TYPE YOUR CODE BELOW
onehot_data <- cleaned_data

# Encode Purchased as a factor with No = 0 and Yes = 1.

# TYPE YOUR CODE BELOW
onehot_data$Purchased = factor(onehot_data$Purchased,
                        levels = c('No', 'Yes'),
                        labels = c(0, 1))

# Use caret::dummyVars() to create one binary column for each Country value.
# Store the dummy-variable instructions in dummy_vars.

# TYPE YOUR CODE BELOW
dummy_vars <- dummyVars("~ Country", data = onehot_data)

# Apply dummy_vars to onehot_data.
# Convert the result to a data frame named encoded_country.

# TYPE YOUR CODE BELOW
encoded_country <- data.frame(
  predict(dummy_vars, newdata = onehot_data)
)
print(encoded_country)

# Add encoded_country to onehot_data, then remove the original Country column.

# TYPE YOUR CODE BELOW
onehot_data <- cbind(onehot_data, encoded_country)
onehot_data$Country <- NULL
# Display onehot_data and its structure.

# TYPE YOUR CODE BELOW

print(onehot_data)
str(onehot_data)

# Answer in comments:
# 1. What new Country columns were created?
# Answer:CountryGermany CountryJapan CountryUSA CountryGermany CountryJapan CountryUSA
#
# 2. What values can appear in each one-hot column?
# Answer: 0 or 1
#
# 3. Why is one-hot encoding more appropriate than label encoding for Country?
# Answer:It creates seperate binary columns for each country which prevents
# models from assuming that one country is greater or ranked higher than the
# other.


# PART 5: SCALE THE NUMERICAL VARIABLES ------------------------------------

# Standardize Age and Salary in onehot_data using scale().
# Do not scale Purchased or the Country indicator columns.

# TYPE YOUR CODE BELOW

onehot_data$Age <- scale(onehot_data$Age)
onehot_data$Salary <- scale(onehot_data$Salary)
# Confirm the mean and standard deviation of the scaled Age variable.

# TYPE YOUR CODE BELOW
mean(onehot_data$Age)
sd(onehot_data$Age)


# Confirm the mean and standard deviation of the scaled Salary variable.

# TYPE YOUR CODE BELOW


# Answer in comments:
# 1. After standardization, what should the mean be approximately?
# Answer: 0
#
# 2. After standardization, what should the standard deviation be approximately?
# Answer: 1
#
# 3. Why can scaling be important for distance-based methods and neural
#    networks?
# Answer: Scaling puts numerical values on a similar scale so that no variable
# dominates just because it has larger values. With distance based methods, this
# makes distance calculations faierer. For neural networks, scaling helps improve
# training speed and stability.


# PART 6: CREATE TRAINING AND TEST SETS ------------------------------------

# Set the random seed to 123.

# TYPE YOUR CODE BELOW
set.seed(123)

# Use caret::createDataPartition() to create an approximately 80% training
# split based on Purchased. Store the row indexes in split_index.

# TYPE YOUR CODE BELOW
split_index <- caret::createDataPartition(onehot_data$Purchased, p = 0.80, list = FALSE)

# Create training_set and test_set from onehot_data.

# TYPE YOUR CODE BELOW
training_set <- onehot_data[split_index, ]
test_set <- onehot_data[-split_index, ]

# Display both sets and their dimensions.

# TYPE YOUR CODE BELOW
print(training_set)
print(test_set)

# Compare the Purchased class counts in training_set and test_set.

# TYPE YOUR CODE BELOW

table(training_set$Purchased)
table(test_set$Purchased)

# Answer in comments:
# 1. How many observations are in the training set?
# Answer: 8
#
# 2. How many observations are in the test set?
# Answer: 2
#
# 3. Why is set.seed(123) used before the random split?
# Answer:It makes the random split reproducibnle so that the same results can be
#obtained each time the code runs.

# 4. Why is Purchased supplied to createDataPartition()?
# Answer: Purchased is the target variable, using it he;lps maintain similar
# proportions of each class when we use binary 0 and 1s in both the training and
# test sets


# PART 7: COMPARE THE ENCODING METHODS -------------------------------------

# Answer in comments:
# 1. How many columns are in the original data?
# Answer: 4
print(data)
# 2. How many columns are in label_data?
# Answer: 4
print(label_data)
# 3. How many columns are in onehot_data?
# Answer: 6
print(onehot_data)
# 4. Which encoding method would you choose for Country in a machine-learning
#    model? Explain.
# Answer: I would choose onehot encoding because country is a categorical
# variable with no naturlal order. One-hot encoding creates separate binary 
# columns for each country, preventing the model from assuming that one country 
# is greater than another.
#
# 5. What is one disadvantage of one-hot encoding when a variable has hundreds
#    of categories?
# Answer: It creates addiational columns, increasing memory usage and 
# computational cost, which can slow down model training.


# PART 8: CONCLUSION ---------------------------------------------------------

# Write one short paragraph in comments explaining:
# - What problems were found in the original dataset
# - How the missing values were handled
# - Why Country and Purchased were encoded differently
# - Why Age and Salary were scaled
# - Why the data was divided into training and test sets
#
# Conclusion:
# In our lab I found that NA values were identified in the Age and Salary
# columns. I replace those values withg the mean of each column so the data
# could be used for machine learning. Country was onehot encoded because
# country names are categorical and do not have a natural order, then Purchased
# was encoded to binary outcomes of 0 and 1 since their weere only 2 possible 
# outcomes. I scaled Age and Salary so that their different numerical ranges
# would not affect the machine learning model. I then divided the dataset into
# training and test sets so the model could be trained on one portion of the 
# data and tested on another to see how well it performs. 


# END OF LAB -----------------------------------------------------------------
