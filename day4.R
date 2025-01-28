############################
# day 4
############################

# reading files

# tibble

# pipes

# no NAs

# https://cambiotraining.github.io/intro-r/03-tidyverse.html

library(tidyverse)
install.packages('tidyverse')

setwd("~/soumya_cam_mac/teaching/introduction_to_R")

surveys <- read_csv("data/portal_data_joined.csv")

# R Base merriami

surveys$species == "merriami"

surveys[ surveys$species == "merriami" & surveys$year == 1997  ,]

surveys[surveys$species == "merriami",]

surveys[surveys$species == "merriami" & ]

surveys[surveys$species=="albigula" &
          surveys$year==1977, ]


# tidyverse
filter(surveys, species == 'albigula' & year == 1977)


head(surveys)

x <- tidyr::drop_na(surveys, weight, year)


# drop any NAs in any column
surveys_complete <- tidyr::drop_na(surveys)

# challenge
#Challenge 1 - pipes
#Subset the surveys_complete data to keep only the species_id, weight, hindfoot_length, year and sex columns and the animals collected on and after 1995. Then plot a scatter plot of weight (x-axis) against hindfoot_length (y-axis) using this transformed dataset. Do all the above using pipes, without creating any variables.
#Answer 

select(surveys_complete, species_id, weight, hindfoot_length, year, sex)

surveys_complete %>%
  #select columns
  select(species_id, weight, hindfoot_length, year, sex)


surveys_complete %>%
  #select columns
  select(species_id, weight, hindfoot_length, year, sex) %>%
  #filter rows
  filter(year >= 1995) %>%
  
  ggplot(mapping = aes( x=weight, y=hindfoot_length)) + geom_point()
  
  
  #plot transformed data
  ggplot(mapping=aes(x=weight, y=hindfoot_length)) +
  geom_point()


ggplot(data = surveys_complete, mapping = aes(x=weight, y=hindfoot_length) ) + geom_point()
 #Challenge 2 - plotting subset with different colour
#Plot all the animals in the surveys_complete dataset as weight (x-axis) against hindfoot_length (y-axis). Use the dataset created above which contains only the animals that were collected on and after 1995 and highlight these points in red in the plot.

#Answer 
survey_recent <- surveys_complete %>%
  select(species_id, weight, hindfoot_length, year, sex) %>%
  filter(year >= 1995)

ggplot(mapping=aes(x=weight, y=hindfoot_length)) +
  geom_point(data=surveys_complete) +
  geom_point(data=survey_recent, color="red")



# Create new columns ------------------------------------------------------


# create new columns

head(surveys_complete)

surveys_complete %>%
  dplyr::mutate(weight_kg = weight/1000)

surveys_complete %>%
  dplyr::mutate(weight_kg2 = weight * 2)


# Sort data ---------------------------------------------------------------

surveys_complete %>%
  dplyr::arrange(weight)

# ALTERNATE
dplyr::arrange(surveys_complete, weight)

# descending order
dplyr::arrange(surveys_complete, desc(weight))


# sort by multiple things
dplyr::arrange(surveys_complete, weight, desc(hindfoot_length))

#####################
# Summarize data
#####################
surveys_complete %>% 
  dplyr::summarise(mean_weight=mean(weight))

# count how many of each sex
surveys_complete %>%
  count(sex)

# count for each sex for each species
# count how many male for each species
surveys_complete %>%
  count(sex, species)

surveys_complete %>%
  count(sex, species)

################################
# Challenge
################################

# how many animals of each plot_type
surveys_complete %>%
  count(plot_type)

# what is the frequency of each species or each sex
surveys_complete %>%
  count(sex, species)

# sort this by descending order of frequency
# CONCEPT: n is variable which stores frequency
surveys_complete %>%
  count(sex, species) %>%
  arrange(desc(n))


#############################
# Plotting time series data
#############################
geom_line()

surveys_complete %>%
  count(year, genus)

yearly_counts <- surveys_complete %>%
                      count(year, genus)

ggplot(data=yearly_counts, mapping = aes(x=year, y=n)) + 
  geom_line()

# color by genus
ggplot(data=yearly_counts, mapping=aes(x=year, y=n, color="genus")) + 
  geom_line()

# not genus color just say color=genus
ggplot(data = yearly_counts, mapping=aes(x=year, y=n, color=genus)) + 
  geom_line()


####################
# group
####################

# split apply combine

surveys_complete %>%
  group_by(sex) %>%
  summarise(weight)

surveys_complete %>%
  group_by(sex) %>%
  summarise(mean_weight_by_sex = mean(weight))

# sort
surveys_complete %>%
  group_by(sex) %>%
  summarise(mean_weight_by_sex = mean(weight)) %>%
  arrange(desc(mean_weight_by_sex))


# do it for each species

surveys_complete %>%
  group_by(sex, species)

###########################
# Challenge
###########################

surveys_complete %>%
  group_by(sex, species_id) %>%
  summarise(mean_weight_by_sex_species=mean(weight), max_weight = max(weight), hind_max = max(hindfoot_length))

# add number of observations
# WRONG
surveys_complete %>%
  group_by(sex, species_id) %>%
  summarise(mean_weight_by_sex_species=mean(weight), max_weight = max(weight), hind_max = max(hindfoot_length)) %>%
  count(species_id)

# use n()
surveys_complete %>%
  group_by(species_id) %>%
  summarise(
    mean_hindfoot_length = mean(hindfoot_length),
    min_hindfoot_length = min(hindfoot_length),
    max_hindfoot_length = max(hindfoot_length),
    n = n()
  )

surveys_complete %>%
  group_by(year) %>%
  filter(weight == max(weight)) %>%
  select(year, genus, species_id, weight) %>%
  arrange(year)

# use arrange(

##########################
# Facetting
##########################

#facet_wrap()
#facet_grid()

ggplot(data = yearly_counts, mapping = aes(x = year, y=n)) + 
         geom_line() 
  
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) + 
        geom_line() + 
        facet_wrap(facets = vars(genus))

## fix scales
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) + 
  geom_line() + 
  facet_wrap(facets = vars(genus), scales = "free")
# we can no longer compare one graph to another


# compare by sex

surveys_complete %>%
  count(year, sex, genus)

yearly_sex_counts <- count(surveys_complete, year, sex, genus)

ggplot(data = yearly_sex_counts, mapping = aes(x=year, y=n)) + 
  geom_line() +
  facet_wrap(facets = vars(genus))

# color by sex
ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color=sex)) + 
  geom_line() + 
  facet_wrap(facets = vars(genus))



# facet grid
ggplot(data = yearly_sex_counts, mapping = aes(x=year, y = n)) + 
  geom_line() + 
  facet_grid(cols = vars(genus))

# rows and columns
ggplot(data = yearly_sex_counts, mapping = aes(x=year, y=n)) + 
  geom_line() + 
  facet_grid(cols = vars(genus), rows = vars(sex))

################
# CHALLENGE
################
ggplot(data = yearly_sex_counts, mapping = aes(x=year, y=n)) + 
  geom_line() + 
  facet_grid(cols = vars(genus))

ggplot(data = yearly_sex_counts, mapping = aes(x=year, y=n, color=sex)) + 
  geom_line() + 
  facet_grid(cols = vars(genus))

# customization adding labels
ggplot(data = yearly_sex_counts, mapping = aes(x=year, y=n, color=sex)) + 
  geom_line() + 
  facet_grid(cols = vars(genus)) + 
  labs(x = 'Frequency', y='Year of observation')


# Themes
ggplot(data = yearly_sex_counts, mapping = aes(x=year, y=n, color=sex)) + 
  geom_point() + 
  facet_grid(cols = vars(genus)) + 
  labs(x = 'Frequency', y='Year of observation') + 
  theme_dark()


ggplot(data = yearly_sex_counts, mapping = aes(x=year, y=n, color=sex)) + 
  geom_point() + 
  facet_grid(cols = vars(genus)) + 
  labs(x = 'Frequency', y='Year of observation') + 
  theme(axis.text.x = element_text(angle=90))

# fix legends
ggplot(data = yearly_sex_counts, mapping = aes(x=year, y=n, color=sex)) + 
  geom_point() + 
  facet_grid(cols = vars(genus)) + 
  labs(y = 'Frequency', x = 'Year of observation') + 
  theme(axis.text.x = element_text(angle=90)) + 
  scale_color_brewer("Sex", palette = "Set1", labels = c("Female", "Male"))

# theme color brewer
ggplot(data = yearly_sex_counts, mapping = aes(x=year, y=n, color=sex)) + 
  geom_point() + 
  facet_grid(cols = vars(genus)) + 
  labs(y = 'Frequency', x = 'Year of observation') + 
  theme(axis.text.x = element_text(angle=90)) + 
  scale_color_brewer("Sex", palette = "Set1", labels = c("Female", "Male")) + 
  theme_bw()


surveys_complete %>%
  summarise(species, weight)

surveys_complete %>%
  group_by(species) %>%
  summarise(av_weight_species = mean(weight)) 

# group by species and year
surveys_complete %>%
  group_by(species, year) %>%
  summarise(av_weight_species = mean(weight))


var_plot <- surveys_complete %>%
              group_by(species, year) %>%
              summarise(av_weight_species = mean(weight))

ggplot(data = var_plot, mapping = aes(x = year, y = av_weight_species)) + 
  geom_line()

ggplot(data = var_plot, mapping = aes(x = year, y = av_weight_species)) + 
  geom_line() + 
  facet_wrap(facets = vars(species))


#####################
# Export plots
#####################
readr::write_csv(surveys_complete, file = "surveys_complete.csv")

######################
# R Graph Gallery
######################
# useful resource


#########################
# Challenge
#########################
# boxplot each year x axis, wieght in kg

ggplot(data = surveys_complete, mapping = aes(x=year, y=weight)) + 
  geom_boxplot()

ggplot(data = surveys_complete, mapping = aes(x = year, y=weight)) + 
  geom_boxplot() +
  facet_wrap(facets = vars(species))
  

# does not work year is continuous and not factors
# mutate year to factor()
surveys_complete %>%
  mutate(year_factor = as.factor(year)) %>%
  ggplot(mapping = aes(x = year_factor, y=weight)) + 
  geom_boxplot()

