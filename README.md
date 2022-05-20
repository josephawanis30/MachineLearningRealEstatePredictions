## MachineLearningRealEstatePredictions

<p align="center">
  <img src="https://user-images.githubusercontent.com/94503395/167318946-0efc193c-5f84-4cc3-aab7-82d16fdf4e5c.png"/>
</p>

“**Group 2: Jean Paul, Cory, Manitha, Joe**”
The team has been in communication with each other on almost daily bases through available channels.  All 4 team members present, and spending an average time of 1.30 - 2.15hrs.

*	We meet at 6 pm on Tue’s & Thurs before **Office hours** for an hour, also on Sat’s when available for least 1hr.
*	We use the **Slack channel**.
*	We shared our **GitHub profiles** with each other, we perform Pull/Push from our branches on almost daily bases and update our branches regularly.
*	We also use **Zoom** as another form of communication (Thank you Cory!).  We Zoom Twice a week for a min. period of 1.3hrs all together (when possible!!).  

Team’s GitHub profiles:
* **Jean Paul**:  ntorenduwayo
* **Cory**:	corypeacock
* **Manitha**:  manithamanoj
* **Joe**:  josephawanis30

## Overview
According to the May 6, 2022, Cromford Report,[^1] the housing market in Central Phoenix is just beginning to pick up again after a very slow year for Real Estate sales. Despite the slow year, the median sale price currently sits at $425,000, up 27.6% from May 5, 2021, with a monthly volume of 9,500 sales. This very active market warrants investigation.  

There are, of course, numerous features that factor into the listing price for any realty listing. On one end of the spectrum, large data-driven companies like Zillow are able to utilize their algorithms to price homes very accurately. According to Zillow’s website,[^2] their nationwide median error rate for an on-market home “Zestimate” is 1.9%. On the other end of the spectrum, independent realtors utilize a mix of experiential intuition and “comps” - hyper local comparable house listings. According to Brian Houle, a local Phoenix Realtor, finding six to ten homes within a two-mile radius with a similar square footage and similar housing condition / quality is a good starting place for finding accurate pricing. What independent Realtors have internalized as intuition, data-driven Realtors have made explicit in their algorithms, the features of which are typically not publicly available.  

The primary purpose of this analysis is to create a machine learning model that can predict housing prices for single-family detached homes in the central Phoenix area utilizing features that are publicly available.  


## Data Sourcing
The preliminary data set was sourced from the FlexMLS Realty portal available to Real Estate Agents and their clients. The search for data points was conducted on May 6 and 7, 2022. All houses currently for sale as of May 6th, or sold within the 14 days prior to May 7, within a radius of 10 miles from Indian Steel Park in Central Phoenix, with an asking price of $1,300,000 or less were included in the search. The search resulted in more than 2,300 houses for sale or recently sold. Given that the average sale price percentage compared to listed sale price is 101.83%,[^3] there is little need to differentiate between houses listed for sale and those sold.

The features of each data point include:
* ID
* Price (Asking Price / Sale Price)
* Address
* Zip
* Status (Active, Under Contract, etc.)
* Subdivision
* Year built
* Bedrooms
* Bathrooms
* Approximate Square Footage

Additional data was retrieved from the Arizona Department of Education,[^4] in order to provide an education score for each house listed in the dataset above. For each zip code in the dataset, the best scoring elementary school in the zip code’s school district was attached. The presupposition of this choice is that homebuyers in Arizona, having the option of school choice, will be influenced positively or negatively by the best school in the general proximity of the house under consideration.  

For each zip code, a crime score was also added by retrieving data from the crime statistics open data section of Phoenix.gov.[^5] Individual crime reports were grouped by zip code and the sum of crimes by zip code was divided by all crime reports in the dataset in order to give a crime score for each zip code. Where a zip code was not represented in the city of Phoenix crime dataset, due to the jurisdiction of another city, the median crime score was used.

## Exploratory Data Analysis

#### This section still in process  
Please see the EDA.ipynb file in the Exploratory_Data_Analysis folder of this repository.
(bullet points for now, to be filled in with pngs and text)  
* Density plot - price
* Quartile / Mean / Mode table - price
* Correlation matrix
* Correlogram
* 3D plot [sqft x bathrooms x price]
* Density plot - sqft
* Quartile / Mean / Mode table - sqft
* Density plot - bedrooms
* Quartile / Mean / Mode table - bedrooms
* Density plot - bathrooms (unnecessary?)
* Quartile / Mean / Mode table - bathrooms (unnecessary?)

Early attempts at models included a multiple linear regressor and a neural network. Due to the particularities of the dataset, neither proved particularly useful models on first pass. The results were weak enough that the originally suggested model of a Random Forest Regressor was chosen as the correct model for the project.  

## Process
The preliminary dataset will be used as testing data. We are planning to scrape data from Zillow using Splinter and BeautifulSoup.The Machine learning model we are using is Multiple Linear regression model. At this point no SQL database needed. But in the presentation stage planning to use database if needed.

This analysis will use a Jupyter Notebook, using Python 3.7.11, as the primary method for processing and analyzing the datasets for this project.

The primary file is: RandomForestRegressor.ipynb. An outline of the work flow is as follows:  
1. Import Dependencies
1. Import Data
   1. Combined data
   1. Education data
   1. Crime data
1. Data Cleaning
   1. Renaming columns
   1. Dropping columns
   1. Combining tables via joins
1. Finding Best Parameters
   1. Using RandomizedSearchCV
1. Database - SQLite
   1. Send to SQLite DB
   1. Retrieve from SQLite DB
1. Random Forest Model Creation
   1. Split into train/test
   1. Fit & Evaluate
   1. Predictions
   1. Decision tree (from Best Model.ipynb)
1. Export necessary information for storyboard / dashboard

## Database
SQlite is the database we are planning to use.

## Machine Learning
Multiple Linear Regression

## Results
Lorem ipsum

## Summary
Lorem ipsum  

---
Footnotes:  
[^1]: The Cromford Report, accessed 6 May 2022.  
[^2]: https://www.zillow.com/z/zestimate/ , accessed 19 May 2022.  
[^3]: The Cromford Report, accessed 6 May 2022.  
[^4]: https://azsbe.az.gov/f-school-letter-grades , accessed 7 May 2022.  
[^5]: https://www.phoenix.gov/police/resources-information/crime-stats-maps , accessed 14 May 2022.  
