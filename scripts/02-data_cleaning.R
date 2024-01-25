#### Preamble ####
# Purpose:  Clean ward info, and ward profile data and combine sets of info as needed
# Author: Navya Hooda
# Data: 19 January 2024
# Contact: navya.hooda@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# 00-download_data.R

# Parts of this code were written with the guidance of ChatGPT, if it was not the reference has been noted

#### Workspace setup ####

library(tidyverse)
library(janitor)
library(readxl)
library(dplyr)
library(tidyr)



#### Read in raw data ####

raw_ward_data = 
  read_csv(
    file = "inputs/data/raw_ward_data.csv",
    show_col_types = FALSE
  )

# read ward name data
raw_ward_name_data = 
  read_csv(
    file = "inputs/data/raw_ward_name_data.csv",
    show_col_types = FALSE
  )



#### Data cleaning ####

## Ward Profile data ##

# make the names in data snake case
cleaned_ward_data = clean_names(raw_ward_data)


print(cleaned_ward_data)

# select the rows of interest

# row 18 is the total population
# row 1383 is the avg household income 2020 
# row 1392 is the no. of tenant households spending above 30% on rent
# row 1396 is the no. of house owners spending above 30% on rent
# row 1006 is the # of people with a bachelor's or higher education
# row 133 si the average household size by persons
# Numeric indices of columns to select
columns_to_select <- 1:26  
row_numbers_to_select <- c(1383, 1396, 1392, 1006) 

# select the specified rows by slice
cleaned_ward_data_subset <- cleaned_ward_data %>%
  slice(row_numbers_to_select) %>%
  select(columns_to_select) %>%
  
# remove old long name columns
  select(-city_of_toronto_profiles) %>%
  rowid_to_column("Row_ID")


# Print the modified subset
print(cleaned_ward_data_subset)

# Rename rows
new_row_names <- c(" Avg Income", "< 30% on House", "< 30% on Rent",  "Bachelor's or higher")
cleaned_ward_data_subset$Row_ID <- new_row_names



# Print the final subset with row names
print(cleaned_ward_data_subset) 


# transpose the data for cleaner usage


transposed_data <- cleaned_ward_data_subset %>%
  pivot_longer(cols = starts_with("x"), names_to = "Ward", values_to = "Value") %>%
  pivot_wider(names_from = Row_ID, values_from = Value)

# make ward names numeric 
transposed_data <- transposed_data %>%
  mutate(Ward = row_number())


# Print the transposed data
print(transposed_data) 



## Ward Name Data ## 

# referencing code from https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html

cleaned_ward_name_data = 
  raw_ward_name_data |>
  clean_names() |>
  select(
    area_short_code,
    area_name
  ) |>
  rename(
    ward_code = area_short_code,
    ward_name = area_name
  ) |>
  mutate(
    ward_code = as.numeric(ward_code)
  )
cleaned_ward_name_data =
  cleaned_ward_name_data |>
  add_row(ward_code = 00, ward_name = NA)
print(cleaned_ward_name_data)


# Summarizing all the data, adding ward name to the ward codes

# Perform left join
result_data <- transposed_data %>%
  left_join(cleaned_ward_name_data, by = c("Ward" = "ward_code"))
result_data <- result_data %>%
  select(Ward, ward_name, everything())


# Fix rows to account for 'Toronto' total row at start 
result_data <- result_data %>%
  mutate(
    Ward = if_else(row_number() == 1, NA_real_, Ward),
    ward_name = if_else(row_number() == 1, "Toronto", ward_name)
  )

# print the total summarized result of data 
print(result_data)


#### Write cleaned dataset to file ####

write_csv(
  x = transposed_data,
  file = "inputs/data/cleaned_ward_data.csv"
)

write_csv(
  x = result_data,
  file = "inputs/data/summarized_ward_data.csv"
)



