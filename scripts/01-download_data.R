#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Navya Hooda
# Date: 19 January, 2024
# Contact: navya.hooda@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None
# Ward profile from https://open.toronto.ca/dataset/ward-profiles-25-ward-model/
# Ward Name Data from https://open.toronto.ca/dataset/city-wards/ 


#### Workspace setup #### 

library(tidyverse)
source("scripts/helper_functions.R")

#### Download and write Toronto Ward Profile Data ####


# download ward profile data 
raw_ward_data = download_data_from_opendatatoronto(
  package_id = "6678e1a6-d25f-4dff-b2b7-aa8f042bc2eb",
  resource_id = "16a31e1d-b4d9-4cf0-b5b3-2e3937cb4121"
)

# write csv from data
write_csv (
  x = raw_ward_data,
  file = "inputs/data/raw_ward_data.csv"
)


# download ward name data 
raw_ward_name_data = download_data_from_opendatatoronto(
  package_id = "5e7a8234-f805-43ac-820f-03d7c360b588",
  resource_id = "7672dac5-b383-4d7c-90ec-291dc69d37bf"
)


# write csv from data
write_csv (
  x = raw_ward_name_data,
  file = "inputs/data/raw_ward_name_data.csv"
)


