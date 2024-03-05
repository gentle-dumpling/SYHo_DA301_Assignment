## LSE Data Analytics Online Career Accelerator 

# DA301:  Advanced Analytics for Organisational Impact

###############################################################################

# Assignment template

## Scenario
## You are a data analyst working for Turtle Games, a game manufacturer and 
## retailer. They manufacture and sell their own products, along with sourcing
## and selling products manufactured by other companies. Their product range 
## includes books, board games, video games and toys. They have a global 
## customer base and have a business objective of improving overall sales 
##performance by utilising customer trends. 

## In particular, Turtle Games wants to understand:
## - how customers accumulate loyalty points (Week 1)
## - how useful are remuneration and spending scores data (Week 2)
## - can social data (e.g. customer reviews) be used in marketing 
##     campaigns (Week 3)
## - what is the impact on sales per product (Week 4)
## - the reliability of the data (e.g. normal distribution, Skewness, Kurtosis)
##     (Week 5)
## - if there is any possible relationship(s) in sales between North America,
##     Europe, and global sales (Week 6).

################################################################################

# Week 4 assignment: EDA using R

## The sales department of Turtle games prefers R to Python. As you can perform
## data analysis in R, you will explore and prepare the data set for analysis by
## utilising basic statistics and plots. Note that you will use this data set 
## in future modules as well and it is, therefore, strongly encouraged to first
## clean the data as per provided guidelines and then save a copy of the clean 
## data for future use.

# Instructions
# 1. Load and explore the data.
##  - Remove redundant columns (Ranking, Year, Genre, Publisher) by creating 
##      a subset of the data frame.
##  - Create a summary of the new data frame.
# 2. Create plots to review and determine insights into data set.
##  - Create scatterplots, histograms and boxplots to gain insights into
##      the Sales data.
##  - Note your observations and diagrams that could be used to provide
##      insights to the business.
# 3. Include your insights and observations.

###############################################################################

# 1. Load and explore the data

# Install and import Tidyverse.
library('tidyverse')

# Import the data set.
sales <- read.csv('turtle_sales.csv', header = TRUE)

# Print the data frame.
head(sales)

# Create a new data frame from a subset of the sales data frame.
# Remove unnecessary columns. 
sales2 <- select(sales, -Ranking,-Year, -Genre, -Publisher)

# Check the new data frame.
head(sales2)

# View the data frame.
view(sales2)

# View the descriptive statistics.
# Use the as.tibble() function.
as_tibble(sales2)

# Use the glimpse() function.
glimpse(sales2)

# Use the summary() function.
summary(sales2)

################################################################################

# 2. Review plots to determine insights into the data set.

# Import the ggplot2 library.
library(ggplot2)

# Examine a Global Sales through a visualisation.
qplot(Global_Sales, data=sales2)

## 2a) Scatterplots
# Create scatterplots.
#Scatterplot of Product vs Global Sales
ggplot(sales2, aes(x=Product, y=Global_Sales)) + 
  geom_point() +
  labs(x = "Product", y = "Global Sales (in millions)", title = "Global Sales vs. Product") +
  theme_minimal()

#Scatterplot of PLatform vs Global Sales
ggplot(sales2, aes(x=Platform, y=Global_Sales)) + 
  geom_point() +
  labs(x = "Platform", y = "Global Sales (in millions)", title = "Global Sales vs. Platform") +
  theme_minimal() 



## 2b) Histograms
# Create histograms.
# Histogram of global sales
ggplot(sales2, aes(x=Global_Sales)) + 
  geom_histogram(fill = "blue", color = "black")  + 
  labs(x = "Global_Sales(in millions)", y = "Frequency", title = "Global Sales") +
  theme_minimal()


# Histogram of EU sales
ggplot(sales2, aes(x=EU_Sales)) + 
  geom_histogram(fill = "lightblue", color = "black")  + 
  labs(x = "EU_Sales(in millions)", y = "Frequency", title = "EU Sales") +
  theme_minimal()

# Histogram of NA sales
ggplot(sales2, aes(x=NA_Sales)) + 
  geom_histogram(fill = "navy", color = "black")  + 
  labs(x = "NA_Sales(in millions)", y = "Frequency", title = "NA Sales") +
  theme_minimal()


## 2c) Boxplots
# Create boxplots.
# Boxplot of Global Sales by PLatform
ggplot(sales2, aes(x = Platform, y = Global_Sales)) +
  geom_boxplot(fill = "blue", color = "black", alpha = 0.7) +
  labs(x = "Platform", y = "Global Sales (in millions)", title = "Boxplot of Global Sales by Platform") +
  theme_minimal()

# Boxplot of EU Sales by platform
ggplot(sales2, aes(x = Platform, y = EU_Sales)) +
  geom_boxplot(fill = "lightblue", color = "black", alpha = 0.7) +
  labs(x = "Platform", y = "EU Sales (in millions)", title = "Boxplot of EU Sales by Platform") +
  theme_minimal()

# Boxplot of NA Sales by platform
ggplot(sales2, aes(x = Platform, y = NA_Sales)) +
  geom_boxplot(fill = "navy", color = "black", alpha = 0.7) +
  labs(x = "Platform", y = "NA Sales (in millions)", title = "Boxplot of NA Sales by Platform") +
  theme_minimal()

###############################################################################

# 3. Observations and insights

## Based on initial analysis, we can see that there are certain products that sell much better than others. 
## We also observe a positive correlation between global sales, EU sales and NA sales as they have the same general shape.
## We also observed that products launched certain platforms perform significantly better than others.
## However there is variation based on region.



###############################################################################
###############################################################################


# Week 5 assignment: Cleaning and maniulating data using R

## Utilising R, you will explore, prepare and explain the normality of the data
## set based on plots, Skewness, Kurtosis, and a Shapiro-Wilk test. Note that
## you will use this data set in future modules as well and it is, therefore, 
## strongly encouraged to first clean the data as per provided guidelines and 
## then save a copy of the clean data for future use.

## Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 4 assignment. 
##  - View the data frame to sense-check the data set.
##  - Determine the `min`, `max` and `mean` values of all the sales data.
##  - Create a summary of the data frame.
# 2. Determine the impact on sales per product_id.
##  - Use the group_by and aggregate functions to sum the values grouped by
##      product.
##  - Create a summary of the new data frame.
# 3. Create plots to review and determine insights into the data set.
##  - Create scatterplots, histograms, and boxplots to gain insights into 
##     the Sales data.
##  - Note your observations and diagrams that could be used to provide 
##     insights to the business.
# 4. Determine the normality of the data set.
##  - Create and explore Q-Q plots for all sales data.
##  - Perform a Shapiro-Wilk test on all the sales data.
##  - Determine the Skewness and Kurtosis of all the sales data.
##  - Determine if there is any correlation between the sales data columns.
# 5. Create plots to gain insights into the sales data.
##  - Compare all the sales data (columns) for any correlation(s).
##  - Add a trend line to the plots for ease of interpretation.
# 6. Include your insights and observations.

################################################################################

# 1. Load and explore the data

# View data frame created in Week 4.
view(sales2)

# Check output: Determine the min, max, and mean values.

# Global Sales
mean(sales2$Global_Sales)
min(sales2$Global_Sales)
max(sales2$Global_Sales)

# EU Sales
mean(sales2$EU_Sales)
min(sales2$EU_Sales)
max(sales2$EU_Sales)

# NA Sales
mean(sales2$NA_Sales)
min(sales2$NA_Sales)

max(sales2$NA_Sales)

# View the descriptive statistics.
summary(sales2)

# global sales
summary(sales2$Global_Sales)

# EU sales
summary(sales2$EU_Sales)

# NA sales
summary(sales2$NA_Sales)

###############################################################################

# 2. Determine the impact on sales per product_id.

## 2a) Use the group_by and aggregate functions.
# Group data based on Product and determine the sum per Product.
global_sales_product <- sales2 %>%
  group_by(Product) %>%
  summarize(total_sales_global = sum(Global_Sales))

# View the data frame.
print(global_sales_product)

# Explore the data frame.
summary(global_sales_product)


## 2b) Determine which plot is the best to compare game sales.

# install.packages("ggplot2")
library(ggplot2)

# Create scatterplots.
ggplot(global_sales_product, aes(x = Product, y = total_sales_global)) +
  geom_point() +
  labs(x = "Product", y = "Total Sales (Global)", title = "Scatterplot of Total Sales (Global) per Product") +
  theme_minimal() 

# Create scatterplots (Product hue)
ggplot(global_sales_product, aes(x = as.factor(Product), y = total_sales_global, color = as.factor(Product))) +
  geom_point() +
  labs(x = "Product", y = "Total Sales (Global)", title = "Scatterplot of Total Sales (Global) per Product") +
  theme_minimal() +
  guides(color = FALSE)


# Create histograms.
ggplot(global_sales_product, aes(x = total_sales_global)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black", alpha = 0.7) +
  coord_flip() +
  labs(x = "Product", y = "Total Sales (Global)", title = "Histogram of Total Sales (Global) per Product") +
  theme_minimal()

# Create boxplots.
ggplot(global_sales_product, aes(x = as.factor(Product), y = total_sales_global)) +
  geom_boxplot(fill = "blue", color = "black", alpha = 0.7) +
  labs(x = "Product", y = "Total Sales(Global)", title = "Boxplot of Total Sales(Global) per Product") +
  theme_minimal()

###############################################################################


# 3. Determine the normality of the data set.

## 3a) Create Q-Q Plots
# Create Q-Q Plots.

# Global Sales
qqnorm(sales2$Global_Sales)

# Add a reference line:
qqline(sales2$Global_Sales, col='red')

# EU Sales
qqnorm(sales2$EU_Sales)

# Add a reference line:
qqline(sales2$EU_Sales, col='red')

# NA Sales
qqnorm(sales2$NA_Sales)

# Add a reference line:
qqline(sales2$NA_Sales, col='red')




## 3b) Perform Shapiro-Wilk test
# Install and import Moments.
library(moments)

# Perform Shapiro-Wilk test.
# Global sales
shapiro.test((sales2$Global_Sales))

# Our p-value is <0.05,so the data is not normally distributed.

# EU sales
shapiro.test((sales2$EU_Sales))

# Our p-value is <0.05,so the data is not normally distributed.

# NA sales
shapiro.test((sales2$NA_Sales))

# Our p-value is <0.05,so the data is not normally distributed.

## 3c) Determine Skewness and Kurtosis
# Skewness and Kurtosis.

# Global Sales
skewness(sales2$Global_Sales)

kurtosis(sales2$Global_Sales)

#indicates skewed to the right,  with heavy tails

# EU Sales
skewness(sales2$EU_Sales)

kurtosis(sales2$EU_Sales)

#indicates skewed to the right,  with heavy tails

# NA Sales
skewness(sales2$NA_Sales)

kurtosis(sales2$NA_Sales)

#indicates skewed to the right,  with heavy tails


## 3d) Determine correlation
# Determine correlation.

# Check correlation between global sales and EU sales using Pearson's correlation.
cor(sales2$EU_Sales, sales2$Global_Sales)

# Our correlation coefficient of 0.8775575 suggests a significant positive correlation.

# Check correlation between global sales and NA sales using Pearson's correlation.
cor(sales2$Global_Sales, sales2$NA_Sales)

# Our correlation coefficient of  0.9349455 suggests a significant positive correlation.

# Check correlation between EU sales and NA sales using Pearson's correlation.
cor(sales2$EU_Sales, sales2$NA_Sales)

# Our correlation coefficient of 0.7055236 suggests a significant positive correlation.

###############################################################################

# 4. Plot the data
# Create plots to gain insights into data.
# Choose the type of plot you think best suits the data set and what you want 
# to investigate. Explain your answer in your report.

# Convert to long format
sales2_long <- pivot_longer(sales2, cols = c("Global_Sales", "EU_Sales", "NA_Sales"), names_to = "variable", values_to = "values")

# Product Sales Distribution Stacked Bar Chart
ggplot(sales2_long, aes(x = Product, y = values, fill = variable)) +
  geom_bar(stat = "identity") +
  labs(title = "Product Sales Distribution",
       x = "Product",
       y = "Sales (by millions GBP)") +
  scale_fill_manual(values = c("Global_Sales" = "blue", "EU_Sales" = "green", "NA_Sales" = "red")) +
  theme_minimal()

# Product Sales Distribution Scatterplot
# Assuming sales2_long is the long-format data frame
ggplot(sales2_long, aes(x = Product, y = values, color = variable)) +
  geom_point(position = position_dodge(width = 0.8)) +
  labs(title = "Product Sales Distribution",
       x = "Product",
       y = "Sales (by millions GBP)") +
  scale_color_manual(values = c("Global_Sales" = "blue", "EU_Sales" = "green", "NA_Sales" = "red")) +
  theme_minimal()

# Add a trend line to the scatterplot
ggplot(sales2_long, aes(x = Product, y = values, color = variable)) +
  geom_point(position = position_dodge(width = 0.8)) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Product Sales Distribution with Trend Line",
       x = "Product",
       y = "Sales (by millions GBP)") +
  scale_color_manual(values = c("Global_Sales" = "blue", "EU_Sales" = "green", "NA_Sales" = "red")) +
  theme_minimal()

############################################################

# 5. Observations and insights

## From the data, we can see that there is naturally a positive correlation between global sales, EU sales and NA sales. 
## We can also see from the trendline in the Product Sales Distribution scatterplot that there is a general downward trend of sales to higher product IDs.
## We would want to explore further what is the trait for products with higher ID numbers, e.g. are they newer products, more expensive etc. to identify what could be the main factor influencing this trend.
## We can also see from the scatterplot and stacked barplot that certain products are more popular in certain regions.
## We would want to make note of that in order to optimise sales and marketing of the products.


###############################################################################
###############################################################################

# Week 6 assignment: Making recommendations to the business using R

## The sales department wants to better understand if there is any relationship
## between North America, Europe, and global sales. Therefore, you need to
## investigate any possible relationship(s) in the sales data by creating a 
## simple and multiple linear regression model. Based on the models and your
## previous analysis (Weeks 1-5), you will then provide recommendations to 
## Turtle Games based on:
##   - Do you have confidence in the models based on goodness of fit and
##        accuracy of predictions?
##   - What would your suggestions and recommendations be to the business?
##   - If needed, how would you improve the model(s)?
##   - Explain your answers.

# Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 5 assignment. 
# 2. Create a simple linear regression model.
##  - Determine the correlation between the sales columns.
##  - View the output.
##  - Create plots to view the linear regression.
# 3. Create a multiple linear regression model
##  - Select only the numeric columns.
##  - Determine the correlation between the sales columns.
##  - View the output.
# 4. Predict global sales based on provided values. Compare your prediction to
#      the observed value(s).
##  - NA_Sales_sum of 34.02 and EU_Sales_sum of 23.80.
##  - NA_Sales_sum of 3.93 and EU_Sales_sum of 1.56.
##  - NA_Sales_sum of 2.73 and EU_Sales_sum of 0.65.
##  - NA_Sales_sum of 2.26 and EU_Sales_sum of 0.97.
##  - NA_Sales_sum of 22.08 and EU_Sales_sum of 0.52.
# 5. Include your insights and observations.

###############################################################################

# 1. Load and explore the data
# Load the tidyverse library.
library(tidyverse)
library(ggplot2)
library(dplyr)

# View data frame created in Week 5.
view(sales2)

# Determine a summary of the data frame.
summary(sales2)

###############################################################################

# 2. Create a simple linear regression model
## 2a) Determine the correlation between columns
# Create a linear regression model on the original data.

# Ensure that your data frame contains numeric columns for sales
sales2 <- sales2 %>%
  mutate_at(vars(Global_Sales, EU_Sales, NA_Sales), as.numeric)

# Create a simple linear regression model for Global Sales vs. EU Sales
model_geu<- lm(Global_Sales ~ EU_Sales, data = sales2)

# Print the summary of the regression model
summary(model_geu)

# Create a simple linear regression model for Global Sales vs. NA Sales
model_gna <- lm(Global_Sales ~ NA_Sales, data = sales2)

# Print the summary of the regression model
summary(model_gna)

# Create a simple linear regression model for EU Sales vs. NA Sales
model_euna <- lm(EU_Sales ~ NA_Sales, data = sales2)

# Print the summary of the regression model
summary(model_euna)


## 2b) Create a plot (simple linear regression)
# Basic visualisation of Global sales & EU sales
ggplot(sales2, aes(x = EU_Sales, y = Global_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Linear Regression: Global Sales vs. EU Sales",
       x = "EU Sales",
       y = "Global Sales") +
  theme_minimal()

# Basic visualisation of Global sales & NA sales
ggplot(sales2, aes(x = NA_Sales, y = Global_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Linear Regression: Global Sales vs. NA Sales",
       x = "NA Sales",
       y = "Global Sales") +
  theme_minimal()

# Basic visualisation of EU sales & NA sales
ggplot(sales2, aes(x = NA_Sales, y = EU_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Linear Regression: EU Sales vs. NA Sales",
       x = "NA Sales",
       y = "EU Sales") +
  theme_minimal()

###############################################################################

# 3. Create a multiple linear regression model
# Select only numeric columns from the original data frame.
# Ensure that your data frame contains numeric columns for sales
sales_num <- sales2 %>%
  select_if(is.numeric)

# Check the dataframe
head(sales_num)

# Multiple linear regression model.
# Calculate correlation matrix
sales_columns <- sapply(sales_num, is.numeric)
cor_matrix <- cor(sales_num[, sales_columns])

# Print the correlation matrix
print(cor_matrix)

# Fit a multiple linear regression model
# Create a new object and 
# specify the lm function and the variables.
model <- lm(Global_Sales ~ NA_Sales + EU_Sales, data = sales_num)

# Print the summary statistics.
summary(model)


###############################################################################

# 4. Predictions based on given values
# Compare with observed values for a number of records.
# Predict global sales based on provided values. Compare your prediction to the observed value(s).
# NA_Sales_sum of 34.02 and EU_Sales_sum of 23.80.
# NA_Sales_sum of 3.93 and EU_Sales_sum of 1.56.
# NA_Sales_sum of 2.73 and EU_Sales_sum of 0.65.
# NA_Sales_sum of 2.26 and EU_Sales_sum of 0.97.
# NA_Sales_sum of 22.08 and EU_Sales_sum of 0.52.


# Assuming 'model' is the multiple linear regression model to be used
# Predict global sales using the model
predicted_global <- predict(model, newdata = sales_num)

# Combine observed and predicted values
results <- data.frame(NA_Sales_sum = sales_num$NA_Sales,
                      EU_Sales_sum = sales_num$EU_Sales,
                      Observed_Global_Sales = sales_num$Global_Sales,
                      Predicted_Global_Sales = predicted_global)

# Print the results
print(results)


# Create a new data frame with the provided EU sales and NA sales values
euna_sales <- data.frame(NA_Sales = c(34.02, 3.93, 2.73, 2.26, 22.08),
                         EU_Sales = c(23.80, 1.56, 0.65, 0.97, 0.52))

# Predict global sales using the model and specific values
predicted_global_sales <- predict(model, newdata = euna_sales)

# Combine specific values with predicted global sales
results_euna <- cbind(euna_sales, Predicted_Global_Sales = predicted_global_sales)

# Print the result
print(results_euna)

# Compare the predicted vs observed global sales values
# Show only specified EU_Sales values
eu_filter <- c(23.80, 1.56, 0.65, 0.97, 0.52)

# Using subset()
filtered_results <- subset(results, EU_Sales_sum %in% eu_filter)

# Print the filtered results
print(filtered_results)

###############################################################################

# 5. Observations and insights
# Your observations and insights here...
## The multiple linear regression model appears to capture the correlation between Global sales and EU and NA Sales.
## Generally, the predicted values suggest a relatively accurate predictive model.
## However there is variation in the differences between observed and predicted values, i.e. some predictions have a larger difference.
## This could be due to other factors not considered in the model (e.g. seasonality)
## We have generally good confidence in the model to predicted sales based on the variables used
## Our recommendation would be to consider using additional models to predict futures sales based on other factors.
## As an example, sales based on a time series can be useful to view any seasonal trends and assist in optimising product supply and marketing during peak periods.


###############################################################################
###############################################################################




