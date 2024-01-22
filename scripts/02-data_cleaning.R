#### Preamble ####
# Purpose:  Clean ward info, and ward profile data and combine sets of info as needed
# Author: Navya Hooda
# Data: 19 January 2024
# Contact: navya.hooda@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# 00-download_data.R

#### Workspace setup ####

library(tidyverse)
library(janitor)
library(readxl)
library(dplyr)

### Read excel data ###
raw_ward_data <- read_excel("inputs/data/2023_Ward_Data.xlsx") 

#### Data cleaning ####


# Make the names easier to type
cleaned_ward_data <-
  clean_names(raw_ward_data)

print(cleaned_ward_data)



# Assigning numeric value to cols of cleaned_ward_data

numeric_colnames <- 1:ncol(cleaned_ward_data)

# Assign numeric names to columns
colnames(cleaned_ward_data) <- numeric_colnames
# Assign first col to 'variables' since it differs by row
colnames(cleaned_ward_data)[1] <- "Variables"

# Print the data with numeric column names
head(cleaned_ward_data)
print(cleaned_ward_data)


## Select rows of interest to simplify data of interest

# select row 18 about population per ward 
# select row 1359 about total household income (2020)
#select row 1005 about education level of bachelor's or higher

selected_row_names <- c("18", "1359","1006")
selected_rows <- cleaned_ward_data %>%
  filter(row.names(.) %in% selected_row_names)

print(selected_rows)

# attach the selected row with the columns
selected_data <- selected_rows %>%
  select(Variables, all_of(numeric_colnames))

print(selected_data) 


# rename cols



# transpose 


library(tibble)

# Assuming you have the selected_data tibble
transposed_data <- t(selected_data) %>%
  as_tibble()

# Print or use the transposed_data as needed
print(transposed_data)



# join all rows into one table with the correct wards















