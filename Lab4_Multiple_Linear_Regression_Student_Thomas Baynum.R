# ============================================================================
# Lab 4: Multiple Linear Regression
# Predicting Sales from Advertising Spending
# ============================================================================

# Student name: Thomas Baynum
# Date: 11/20/2026

# PURPOSE --------------------------------------------------------------------

# Use multiple linear regression to predict Sales from spending on TV, Radio,
# and Newspaper advertising. Interpret the model, evaluate test predictions,
# and examine whether the regression assumptions appear reasonable.


# FILE AND PACKAGE SETUP -----------------------------------------------------

# Place advertising.csv in the same folder as this R script.
# Do not use a personal setwd() path in the submitted script.

# Install ggplot2 only if it is not already installed:
# install.packages("ggplot2")

library(ggplot2)


# PART 1: IMPORT AND INSPECT THE DATA ---------------------------------------

library(ggplot2)

data <- read.csv("advertising.csv")

# Display the structure of the dataset.
# TYPE YOUR CODE BELOW
str(data)


# Display a statistical summary of the dataset.
# TYPE YOUR CODE BELOW
summary(data)


# Count missing values in each column.
# TYPE YOUR CODE BELOW
colSums(is.na(data))


# Answer in comments:
# 1. How many observations and variables are present?
# Answer: 200 observations and 4 variables (TV, Radio, Newspaper, Sales).
#
# 2. Which variable is the dependent variable?
# Answer: Sales.
#
# 3. Which three variables are the independent variables?
# Answer: TV, Radio, and Newspaper (advertising spending on each channel).
#
# 4. Are any values missing?
# Answer: No. colSums(is.na(data)) returns 0 for every column.


# PART 2: EXPLORE THE VARIABLES ---------------------------------------------

# Calculate the correlations among TV, Radio, Newspaper, and Sales.

# TYPE YOUR CODE BELOW
cor_matrix <- cor(data[, c("TV", "Radio", "Newspaper", "Sales")])
round(cor_matrix, 3)


# Create three scatterplots:
# 1. TV versus Sales
# 2. Radio versus Sales
# 3. Newspaper versus Sales
#
# Each plot must include a fitted regression line, a descriptive title,
# and clear axis labels.

# TV VERSUS SALES
# TYPE YOUR CODE BELOW
ggplot(data, aes(x = TV, y = Sales)) +
  geom_point(color = "steelblue", alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "darkred") +
  labs(title = "TV Advertising Spending vs. Sales",
       x = "TV Advertising Budget",
       y = "Sales") +
  theme_minimal()


# RADIO VERSUS SALES
# TYPE YOUR CODE BELOW
ggplot(data, aes(x = Radio, y = Sales)) +
  geom_point(color = "darkgreen", alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "darkred") +
  labs(title = "Radio Advertising Spending vs. Sales",
       x = "Radio Advertising Budget",
       y = "Sales") +
  theme_minimal()


# NEWSPAPER VERSUS SALES
# TYPE YOUR CODE BELOW
ggplot(data, aes(x = Newspaper, y = Sales)) +
  geom_point(color = "darkorange", alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "darkred") +
  labs(title = "Newspaper Advertising Spending vs. Sales",
       x = "Newspaper Advertising Budget",
       y = "Sales") +
  theme_minimal()


# Answer in comments:
# 1. Which advertising variable has the strongest relationship with Sales?
# Answer: TV, with a correlation of about 0.901, a strong positive
#         relationship. Its scatterplot shows a tight upward trend.
#
# 2. Which advertising variable appears to have the weakest relationship?
# Answer: Newspaper, with a correlation of only about 0.158. Its
#         scatterplot is widely scattered with a nearly flat fitted line.
#
# 3. Are any predictor pairs highly correlated with each other?
# Answer: No. The largest predictor-to-predictor correlation is Radio and
#         Newspaper at about 0.354, which is moderate, not high. TV is nearly
#         uncorrelated with Radio (0.055) and Newspaper (0.057), so
#         multicollinearity is not a serious concern.


# PART 3: CREATE TRAINING AND TEST SETS -------------------------------------

# Use set.seed(123).
# Randomly assign approximately 80% of the rows to training_set.
# Assign the remaining rows to test_set.

# TYPE YOUR CODE BELOW
set.seed(123)
train_index  <- sample(seq_len(nrow(data)), size = floor(0.8 * nrow(data)))
training_set <- data[train_index, ]
test_set     <- data[-train_index, ]


# Display the number of rows in each set.
# TYPE YOUR CODE BELOW
nrow(training_set)   # 160
nrow(test_set)       # 40


# Keep all variables in their original units. Do not scale Sales.


# PART 4: FIT THE MULTIPLE REGRESSION MODEL ---------------------------------

# Fit a multiple linear regression model that predicts Sales from:
# TV, Radio, and Newspaper
#
# Train the model using training_set and store it in model.

# TYPE YOUR CODE BELOW
model <- lm(Sales ~ TV + Radio + Newspaper, data = training_set)


# Display the model summary and coefficients.
# TYPE YOUR CODE BELOW
summary(model)
coef(model)


# PART 5: INTERPRET THE MODEL ------------------------------------------------

# Answer in comments:
# 1. Write the complete fitted regression equation.
# Answer: Predicted Sales = 4.6215 + 0.0543(TV) + 0.1058(Radio)
#                           + 0.0016(Newspaper)
#
# 2. Interpret the TV coefficient while holding Radio and Newspaper constant.
# Answer: For each 1-unit increase in TV advertising, predicted Sales
#         increase by about 0.0543 units, holding Radio and Newspaper
#         constant. (Equivalently, about 5.4 more units of Sales per
#         100 more units of TV spending.)
#
# 3. Interpret the Radio coefficient while holding the other predictors
#    constant.
# Answer: For each 1-unit increase in Radio advertising, predicted Sales
#         increase by about 0.1058 units, holding TV and Newspaper constant.
#         Per unit spent, Radio has roughly twice the effect of TV.
#
# 4. Interpret the Newspaper coefficient while holding the other predictors
#    constant.
# Answer: For each 1-unit increase in Newspaper advertising, predicted Sales
#         increase by only about 0.0016 units, holding TV and Radio constant.
#         This effect is essentially zero and is not statistically
#         significant (p = 0.805).
#
# 5. Which predictors are statistically significant at the 0.05 level?
# Answer: TV and Radio (both p < 2e-16). Newspaper is not significant
#         (p = 0.805).
#
# 6. Which predictor has the largest absolute t-value?
# Answer: TV, with t = 35.34 (Radio t = 11.16; Newspaper t = 0.25).
#
# 7. What proportion of Sales variation is explained by the model? Use R-squared.
# Answer: R-squared = 0.9016, so the model explains about 90.2% of the
#         variation in Sales in the training data.
#
# 8. What is the adjusted R-squared? Why is adjusted R-squared useful when a
#    model has multiple predictors?
# Answer: Adjusted R-squared = 0.8997. Plain R-squared always increases (or
#         stays the same) when a predictor is added, even a useless one.
#         Adjusted R-squared penalizes each additional predictor, so it only
#         rises when the new variable improves the model more than would be
#         expected by chance. That makes it the fairer way to compare models
#         with different numbers of predictors.


# PART 6: PREDICT AND EVALUATE THE TEST SET ---------------------------------

# Use model to predict Sales for test_set.
# Store the predictions in test_set$Predicted_Sales.

# TYPE YOUR CODE BELOW
test_set$Predicted_Sales <- predict(model, newdata = test_set)


# Calculate residuals as actual Sales minus Predicted_Sales.
# Store them in test_set$Residual.

# TYPE YOUR CODE BELOW
test_set$Residual <- test_set$Sales - test_set$Predicted_Sales


# Calculate test-set RMSE and store it in rmse.
# TYPE YOUR CODE BELOW
rmse <- sqrt(mean(test_set$Residual^2))


# Calculate test-set MAE and store it in mae.
# TYPE YOUR CODE BELOW
mae <- mean(abs(test_set$Residual))


# Display test_set, rmse, and mae.
# TYPE YOUR CODE BELOW
test_set
rmse
mae

# Optional helper: show the test observation with the largest absolute error.
test_set[which.max(abs(test_set$Residual)), ]


# Answer in comments:
# 1. How many test observations were predicted?
# Answer: 40.
#
# 2. What do RMSE and MAE tell you about prediction error?
# Answer: RMSE = 1.619 and MAE = 1.196 (in Sales units). On average, the
#         model's predictions miss actual Sales by about 1.2 units. RMSE is
#         larger than MAE because squaring gives more weight to the few
#         larger misses. Compared with Sales values that range from about
#         1.6 to 27 (mean about 15.1), these errors are small.
#
# 3. Which test observation has the largest absolute error?
# Answer: Row 151 of the original data (TV = 280.7, Radio = 13.9,
#         Newspaper = 37.0). Actual Sales = 16.1, predicted = 21.38, so the
#         residual is -5.28: the model over-predicted Sales by about 5.3.


# PART 7: ACTUAL VERSUS PREDICTED SALES ------------------------------------

# Create a scatterplot with:
# - Actual Sales on the x-axis
# - Predicted Sales on the y-axis
# - A dashed reference line with slope 1 and intercept 0
# - A descriptive title and clear axis labels

# TYPE YOUR CODE BELOW
ggplot(test_set, aes(x = Sales, y = Predicted_Sales)) +
  geom_point(color = "steelblue", size = 2.5, alpha = 0.8) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Actual vs. Predicted Sales (Test Set)",
       x = "Actual Sales",
       y = "Predicted Sales") +
  theme_minimal()


# Answer in comments:
# 1. What would it mean for a point to fall exactly on the reference line?
# Answer: The predicted Sales value equals the actual Sales value exactly,
#         meaning the model made a perfect prediction (residual = 0) for that
#         observation.
#
# 2. Do predictions appear reasonably close to the reference line?
# Answer: Yes. Most points sit close to the dashed line across the full
#         range of Sales, which matches the low RMSE and MAE. The most
#         visible miss is the point at actual Sales = 16.1, predicted about
#         21.4, which falls well above the line.


# PART 8: RESIDUAL ANALYSIS --------------------------------------------------

# Create a data frame named training_diagnostics containing:
# - Fitted values from model
# - Training residuals from model

# TYPE YOUR CODE BELOW
training_diagnostics <- data.frame(
  Fitted   = fitted(model),
  Residual = residuals(model)
)
head(training_diagnostics)


# Create a residual plot with:
# - Fitted Sales on the x-axis
# - Residual on the y-axis
# - A horizontal dashed line at zero
# - A descriptive title and clear axis labels

# TYPE YOUR CODE BELOW
ggplot(training_diagnostics, aes(x = Fitted, y = Residual)) +
  geom_point(color = "steelblue", alpha = 0.7) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Residuals vs. Fitted Sales (Training Set)",
       x = "Fitted Sales",
       y = "Residual") +
  theme_minimal()


# Answer in comments:
# 1. Are residuals distributed above and below zero?
# Answer: Yes. Residuals fall on both sides of zero, and their mean is
#         essentially 0, with a median of about 0.00.
#
# 2. Do you see a curve, funnel shape, or unusually large residual?
# Answer: There is no strong funnel shape; the spread is roughly similar
#         across fitted values. There is a slight curve: residuals lean
#         negative at the lowest and highest fitted values and positive in
#         the middle (about 15-19), so the model slightly over-predicts at
#         the extremes. There is one unusually large residual of about -7.3
#         at a fitted value near 9. That market had almost no TV spending
#         (TV = 0.7) and actual Sales of only 1.6.
#
# 3. What does the pattern suggest about linearity and constant variance?
# Answer: Constant variance looks reasonably satisfied because there is no
#         clear funnel. Linearity is mostly reasonable, but the slight curve
#         suggests the straight-line model misses some structure. Sales
#         may respond to TV and Radio together (an interaction) or with
#         diminishing returns. The single large residual is a possible
#         outlier worth checking.


# PART 9: COMPARE A REDUCED MODEL -------------------------------------------

# Fit a second model that predicts Sales using only the predictors that were
# statistically significant in the full model. Store it in reduced_model.

# TYPE YOUR CODE BELOW
reduced_model <- lm(Sales ~ TV + Radio, data = training_set)


# Display summary(reduced_model).
# TYPE YOUR CODE BELOW
summary(reduced_model)


# Compare the full and reduced models using adjusted R-squared and test RMSE.
# Calculate reduced-model predictions and store its test RMSE in reduced_rmse.

# TYPE YOUR CODE BELOW
reduced_predictions <- predict(reduced_model, newdata = test_set)
reduced_rmse <- sqrt(mean((test_set$Sales - reduced_predictions)^2))

comparison <- data.frame(
  Model         = c("Full (TV + Radio + Newspaper)", "Reduced (TV + Radio)"),
  Adj_R_Squared = c(summary(model)$adj.r.squared,
                    summary(reduced_model)$adj.r.squared),
  Test_RMSE     = c(rmse, reduced_rmse)
)
comparison


# Answer in comments:
# 1. Which model has the larger adjusted R-squared?
# Answer: The reduced model, with 0.9003 vs. 0.8997 for the full model.
#
# 2. Which model has the smaller test RMSE?
# Answer: The reduced model, with 1.6166 vs. 1.6187 for the full model.
#
# 3. Does removing the nonsignificant predictor improve, harm, or leave model
#    performance approximately unchanged?
# Answer: Performance is approximately unchanged, with a very slight
#         improvement. Both metrics favor the reduced model by a tiny
#         margin, so dropping Newspaper loses nothing. The simpler model is
#         preferred because it is just as accurate and easier to interpret.


# PART 10: CONCLUSION --------------------------------------------------------

# Write one short paragraph in comments that answers:
# 1. Which advertising channels are useful predictors of Sales?
# 2. How well does the model explain Sales variation?
# 3. How well does the model predict Sales in the test set?
# 4. What is one limitation of this analysis?
#
# Conclusion:
# TV and Radio advertising are the useful predictors of Sales. Both are
# highly significant, with TV having the strongest relationship overall and
# Radio having the largest effect per unit spent. Newspaper adds nothing
# once TV and Radio are in the model. The model explains about 90% of the
# variation in Sales (R-squared = 0.90, adjusted R-squared = 0.90) and
# predicts well on unseen data, with a test RMSE of about 1.62 and MAE of
# about 1.20 Sales units. The reduced TV + Radio model performs just as well
# with fewer predictors. One limitation is that the residual plot shows a
# slight curved pattern, so the purely linear model misses some structure,
# likely an interaction between TV and Radio or diminishing returns. In
# addition, the data are observational, with only 200 markets and one
# random split, so the coefficients show association rather than proof
# that spending causes the increase in sales.



# END OF LAB -----------------------------------------------------------------
