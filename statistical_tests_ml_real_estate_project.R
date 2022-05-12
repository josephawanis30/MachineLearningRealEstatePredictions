## Machine Learning Real Estate Predictions
## Statistical Tests

# load libraries
library(dplyr)
library(tidyverse)
library(ggplot2)
library(stats)

# import and read data
base_table <- read.csv(file='combined_data_clean.csv', check.names = F, stringsAsFactors = F)
head(base_table)

# adjust cols
prop_df <- subset(base_table, select = -c(id, Address, mls))
prop_df <- prop_df %>% rename(year_built = `Year Built`)
prop_df <- prop_df %>% rename(sqft = `Approx SQFT`)
head(prop_df)

## statistical test types
# one-sample test (1 independent, 1 dependent) - not appropriate
# two-sample test (1 independent, 1 dependent), dichotomouse - not appropriate
# anova (1+ categorical independent, 1 continuous dependent) - this could work
# simple linear regression - no
# multiple linear regression - yes, if we remove categorical values like zip codes
# chi-squared (1 categorical, 1+ categorical) - 'is there a difference in categorical frequencies between groups?)

## eda
summary(prop_df$Price)
sd(prop_df$Price)



## statistical tests
ggplot(prop_df, aes(x=Price)) + geom_density() # visualize distribution using density plot
shapiro.test(prop_df$Price) # pvalue much less than 0.05, so NOT normal distribution
# strong right skew

# anova - considering all are actually categorical even though they're numbers (sqft is exception)
prop_filter <- prop_df[,c('Price', 'zip', 'sqft')]
prop_filter$zip <- factor(prop_filter$zip)

prop_filter2 <- prop_df[,c('Price', 'zip', 'sqft', 'year_built', 'Bedrooms', 'Bathrooms')]
prop_filter2$Bedrooms <- factor(prop_filter2$Bedrooms)
prop_filter2$Bathrooms <- factor(prop_filter2$Bathrooms)

summary(aov(Price ~ zip, data=prop_filter))
summary(aov(Price ~ zip + sqft, data = prop_filter))
summary(aov(Price ~ zip + sqft + year_built + Bedrooms + Bathrooms, data = prop_filter2))

# multiple linear regression
# using only numerical values - that is, not year_built or zip
summary(lm(Price ~ sqft + Bedrooms + Bathrooms, data = prop_df))
