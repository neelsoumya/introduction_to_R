
# Installing and loading packages -----------------------------------------

setwd("~/soumya_cam_mac/teaching/intro_to_R/introduction_to_R")
library(tidyverse)

# select which package required based on package name
surveys <- read_csv(file = 'data/portal_data_joined.csv')

class(surveys)
surveys

# tibble is a form of data frame in tidyverse

print(surveys, n=20)
print(surveys, n=20, width = Inf)

#############
# EXERCISE
# print all rows how? 
length(surveys$record_id)
print(surveys, n=length(surveys$record_id), width = Inf)
num_rows = length(surveys$record_id)
print(surveys, n=num_rows, width = Inf)


# visualization -----------------------------------------------------------
# ggplot

#ggplot(data =<DATA>, mapping=aes(<MAPPINGS>)) + <GEOM_FUNCTION>
  
# data
# mapping which variable goes where (column names)
# geometry points, histograms, bar plots
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length )) + 
  geom_point()

# some warnings


# color
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length )) + 
  geom_point(color='blue')

# transparent
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length )) + 
  geom_point(color='blue', alpha = 0.3)


