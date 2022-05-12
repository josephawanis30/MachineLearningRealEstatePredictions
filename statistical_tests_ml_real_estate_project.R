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

prop_filter <- prop_df[,c('Price', 'zip', 'sqft', 'year_built', 'Bedrooms', 'Bathrooms')]
prop_filter$zip <- factor(prop_filter$zip)
# prop_filter2$Bedrooms <- factor(prop_filter2$Bedrooms)
# prop_filter2$Bathrooms <- factor(prop_filter2$Bathrooms)

# calculated cols
# house age
prop_filter$age <- 2022 - prop_filter$year_built
# price per sq foot
prop_filter$ppsf <- round(prop_filter$Price / prop_filter$sqft, 2)

head(prop_filter)

## eda
price_summary <- prop_df %>% summarize(Mean=mean(Price), Median=median(Price), Variance=var(Price), SD=sd(Price))
price_summary

scttr <- ggplot(prop_df, aes(x=sqft, y=Price)) + geom_point() + geom_smooth(method=lm)
scttr

boxplot(prop_filter$Bedrooms)

prop_filter[which(prop_filter$Bedrooms > 6),]

# bp <- ggplot(prop_filter2, aes(x=Bedrooms)) + geom_boxplot()
# bp + facet_grid(. ~ zip)
## would have to bin bedrooms and zip

prop_df %>% count(Bedrooms)

## statistical test types
# one-sample test (1 independent, 1 dependent) - not appropriate
# two-sample test (1 independent, 1 dependent), dichotomous - not appropriate
# anova (1+ categorical independent, 1 continuous dependent) - this could work
# simple linear regression - no
# multiple linear regression - yes, if we remove categorical values like zip codes
# chi-squared (1 categorical, 1+ categorical) - 'is there a difference in categorical frequencies between groups?)

## statistical tests
ggplot(prop_filter, aes(x=Price)) + geom_density() # visualize distribution using density plot
shapiro.test(prop_filter$Price) # pvalue much less than 0.05, so NOT normal distribution
# note: strong right skew

# anova - considering all features are actually categorical even though they're numbers (sqft is exception)
summary(aov(Price ~ zip, data=prop_filter))
summary(aov(Price ~ zip + sqft, data = prop_filter))
summary(aov(Price ~ zip + sqft + year_built + Bedrooms + Bathrooms, data = prop_filter))

# multiple linear regression
# using only numerical values - that is, not year_built or zip
summary(lm(Price ~ sqft + Bedrooms + Bathrooms, data = prop_filter))
summary(lm(Price ~ sqft + Bedrooms + Bathrooms + age, data = prop_filter))
summary(lm(Price ~ sqft + Bedrooms + Bathrooms + age + ppsf, data = prop_filter)) # is ppsf redundant?

summary(lm(Price ~ sqft + Bedrooms + Bathrooms + age + zip, data = prop_filter))
