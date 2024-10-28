# https://cambiotraining.github.io/intro-r/03-tidyverse.html

library(tidyverse)

# R Base
surveys[surveys$species=="albigula" &
          surveys$year==1977, ]


# tidyverse
filter(surveys, species == 'albigula' & year == 1977)

setwd("~/soumya_cam_mac/teaching/introduction_to_R")

surveys <- read_csv("data/portal_data_joined.csv")

head(surveys)
# tibble is dataframe with knobs on

str(surveys)
# get types

print(surveys, n=15)


###########################
# Visualization
###########################

# https://cambiotraining.github.io/intro-r/03-tidyverse.html

ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>()

# first ggplot
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length))
# need geom, it did axes

# error
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length) + 
  geom_point()
    )


ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) + 
         geom_point()
       

ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) + 
          geom_point(alpha = 0.3)


# plotting with colour
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) + 
          geom_point(alpha = 0.3, color = "tomato")


surveys_ggplot = ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length))

surveys_ggplot + geom_point(alpha = 0.3)

# smooth
surveys_ggplot + geom_smooth()

surveys_ggplot + geom_point() + geom_smooth()

# NOTE:
# CONCEPT: Anything you put in the ggplot() function can be seen by any geom layers that you add (i.e., these are universal plot settings).
# You can also specify mappings for a given geom independently of the mappings defined globally in the ggplot() function.
# The + sign used to add new layers must be placed at the end of the line containing the previous layer. If, instead, the + sign is added at the beginning of the line containing the new layer, >ggplot2 will not add the new layer and will return an error message.

# layers on top of layers
#     this will obscure
surveys_ggplot + geom_smooth() + geom_point()



##################################
# Challenge question
##################################
# Scatter plots can be useful exploratory tools for small datasets. 
# For data sets with large numbers of observations, such as the surveys 
# data set, overplotting of points can be a limitation of scatter plots. 
# We have already seen how we can visualise data better when we have 
# overplotting with the geom_smooth plot. Another way for handling 
# overplotting is to display the density of the data through contours. 
# As this challenge’s task create a script called plot_density2d.R which 
# loads the file data/portal_data_joined.csv into the variable surveys. 
# It then uses this dataset to plot the weight on the x-axis and hindfoot_length on the y-axis in a geom_density2d plot.

surveys_ggplot + 
  geom_density2d()

# getting help
?geom_density2d


# save plot
plot_saved = surveys_ggplot + geom_density_2d() 
ggplot2::ggsave(filename = "saved_plot.png", plot = plot_saved)



###########################
# Data munging
###########################
# transforming data
# dplyr

# select columns
dplyr::select(surveys, species_id, weight)

# all columns except
dplyr::select(surveys, ~species_id)

# filtering rows
dplyr::filter(surveys, year>1989)

dplyr::filter(surveys, year>1989 & sex == 'F')

# missing values a problem
!is.na(surveys$weight)

dplyr::filter(surveys, !is.na(weight))

dplyr::filter(surveys, !is.na(weight) & !is.na(year))

# no NAs
tidyr::drop_na(surveys, weight, year)

# drop any NAs in any column
surveys_complete <- tidyr::drop_na(surveys)

# now plot
# no warnings since no missing values
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + 
        geom_point()


#####################
# Pipes
#####################

# challenge
#Challenge 1 - pipes
#Subset the surveys_complete data to keep only the species_id, weight, hindfoot_length, year and sex columns and the animals collected on and after 1995. Then plot a scatter plot of weight (x-axis) against hindfoot_length (y-axis) using this transformed dataset. Do all the above using pipes, without creating any variables.
#Answer 
surveys_complete %>%
  #select columns
  select(species_id, weight, hindfoot_length, year, sex) %>%
  #filter rows
  filter(year >= 1995) %>%
  #plot transformed data
  ggplot(mapping=aes(x=weight, y=hindfoot_length)) +
  geom_point()


#Challenge 2 - plotting subset with different colour
#Plot all the animals in the surveys_complete dataset as weight (x-axis) against hindfoot_length (y-axis). Use the dataset created above which contains only the animals that were collected on and after 1995 and highlight these points in red in the plot.

#Answer 
survey_recent <- surveys_complete %>%
  select(species_id, weight, hindfoot_length, year, sex) %>%
  filter(year >= 1995)

ggplot(mapping=aes(x=weight, y=hindfoot_length)) +
  geom_point(data=surveys_complete) +
  geom_point(data=survey_recent, color="red")


# time series

# facetting

