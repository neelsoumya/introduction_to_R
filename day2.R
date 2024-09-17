
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


# add a line with a smoother
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length )) + 
  geom_point() +
  geom_smooth()

####################################################
# CONCEPT: adding functionalities layer by layer
#   + is not addition
#    it is adding functionality
####################################################

# change order of layering
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length )) + 
  geom_smooth() + 
  geom_point()

# points on top of line so you cannot see line


# Concept of layering -----------------------------------------------------


#################################
# CONCEPT: + sign adds layers
#     occlusion/obstruction
#################################


# xkcd package

# save plot in variable

basic_plot_surveys <- ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length ))
basic_plot_surveys # basic plot but no plot shown no geom given point? barplot?
basic_plot_surveys <- basic_plot_surveys + geom_point()
basic_plot_surveys

basic_plot_surveys <- basic_plot_surveys + geom_smooth()
basic_plot_surveys

# error - will not work
basic_plot_surveys <- basic_plot_surveys - geom_smooth()  

