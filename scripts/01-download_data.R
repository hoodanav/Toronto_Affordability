#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Navya Hooda
# Date: 19 January, 2024
# Contact: navya.hooda@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None
x# Ward profile from https://open.toronto.ca/dataset/ward-profiles-25-ward-model/


#### Workspace setup #### 

library(tidyverse)
source("scripts/helper_functions.R")

#### Download and write Toronto Ward Profile Data ####


# download ward profile data 
raw_ward_data = download_data_from_opendatatoronto(
  package_id = "6678e1a6-d25f-4dff-b2b7-aa8f042bc2eb",
  resource_id = "16a31e1d-b4d9-4cf0-b5b3-2e3937cb4121"
)


