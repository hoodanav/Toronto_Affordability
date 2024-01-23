#### Preamble ####
# Purpose: Simulates...
# Author: Navya Hooda 
# Date: 19 January 2024
# Contact: navya.hooda@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
# Any other information needed? 


#### Workspace setup ####
library(tidyverse)
install.packages("janitor")

#### Simulate data ####
simulated_data <-
  tibble(
    # Use 1 through to 25 to represent each division
    "Division" = 1:25,
    # Randomly pick an option, with replacement, 151 times
    "Party" = sample(
      x = c("Liberal", "Labor", "National", "Green", "Other"),
      size = 25,
      replace = TRUE
    )
  )

simulated_data


