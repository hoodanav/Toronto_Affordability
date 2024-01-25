#### Preamble ####
# Purpose: Tests cleaned data and data validation
# Author: Navya Hooda
# Date: 19 January 2024
# Contact: navya.hooda@mail.utoronto.ca
# License: MIT


#### Workspace setup ####

library(tidyverse)
library(dplyr)

# Testing reference from https://dplyr.tidyverse.org/reference/n_distinct.html 

#### Test the data ####

# data from 00-simulate_data to test

source("scripts/00-simulate_data.R")
source("scripts/02-data_cleaning.R")


# check there are 25 rows one for each ward
total_rows = nrow(transposed_data)
total_rows == 25

# check there are 6 cols 
total_cols = ncol(transposed_data)
total_cols == 7


# check ward name is unique 
ward_is_unique <- n_distinct(summarized_ward_data$ward_name)
print(num_unique)
ward_is_unique |> max() == 25

# check in the simulated that there are 4 columns
num_col = ncol(simulated_data)
num_col == 4


# check the income in simulated data follows max/min restrictions
simulated_data$Income |> max() < 400000
simulated_data$Income |> min() >= 1

print(simulated_data$Income)
