#### Preamble ####
# Purpose: Simulates...
# Author: Navya Hooda 
# Date: 19 January 2024
# Contact: navya.hooda@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 


#### Workspace setup ####
library(tidyverse)
install.packages("janitor")


# Defining columns from data to simulate

# Ward Name 
ward_name = c("Toronto Core", "Etobicoke North", "Etobicoke South", "Parkdale-High Park")


# Population
population = c(1:2761285)


# Employment Status
E_status = c("Self Employed", "Employed", "Unemployed", "Retired")

# Income
Income = c(1:400000)

## Creating simulated data 

set.seed(311) 

#### Simulate data ####
simulated_data <- tibble(population = sample(x = population, size =4, replace =  TRUE),
                         ward_name = sample(x = ward_name, size = 4, replace = TRUE),
                         Income = sample(x = Income, size = 4, replace = TRUE), 
                         E_status = sample(x = E_status, size = 4, replace = TRUE))

# show simulated data 
simulated_data

# Summaries of ward statistics by population 

ward_by_population <- 
  simulated_data %>%
  group_by(population) %>%
  summarise(
    total_population = sum(population),
    average_population = mean(population),
    max_population = max(population),
    min_population = min(population)
  )


#Bar plot for wards by population 
ggplot(ward_by_population, aes(x = ward_name, y = population)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  labs(title = "ward by population",
       x = "Ward Name",
       y = "Population") +
  theme_minimal()
ward_by_population
