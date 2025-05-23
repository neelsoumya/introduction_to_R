
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



# Challenge 1 day 2 -------------------------------------------------------

# https://cambiotraining.github.io/intro-r/03-tidyverse.html#Challenge

# TIP: please do not copy paste code just type it
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_density2d()

# have everyone create a new scriot, write package name on top, etc.


# Use of aes() ------------------------------------------------------------

# ARE there other factors or features of the data

# color is outside aesthetic
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length )) + 
  geom_point(color='blue')

# WRONG
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length, color = sex )) + 
  geom_point(color='blue')

# RIGHT
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length, color = sex )) + 
  geom_point()

# WORKS for categorical variables/factors
#   let us see what happens if we use a numeric variable
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length, color = year )) + 
  geom_point()

# shape
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length, shape = sex )) + 
  geom_point()

# color and size from different features
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length, shape = sex, color = taxa )) + 
  geom_point()

ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length, shape = taxa, color = sex )) + 
  geom_point()



# global and local scoping ------------------------------------------------

ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length, color = sex )) + 
  geom_point(color='blue')

ggplot() + 
  geom_point(data = surveys, mapping = aes( x = weight, y = hindfoot_length, color = sex ))

# not passed to geom_smooth() it is local
#     if passed to ggplot then global
ggplot() + 
  geom_point(data = surveys, mapping = aes( x = weight, y = hindfoot_length, color = sex )) + 
  geom_smooth()



# Exercise draw a boxplot -------------------------------------------------

# https://ggplot2.tidyverse.org/reference/geom_boxplot.html
# https://en.wikipedia.org/wiki/Box_plot#/media/File:Michelsonmorley-boxplot.svg

ggplot(data = surveys, aes(x = weight, y = hindfoot_length)) + 
  geom_boxplot()

ggplot(data = surveys, aes(x = weight)) + 
  geom_boxplot()

ggplot(data = surveys, aes(x=sex)) + 
  geom_boxplot()

ggplot(data = surveys, aes(x=sex)) + 
  geom_histogram()

ggplot(data = surveys, aes(x=sex, y = hindfoot_length)) + 
  geom_boxplot()

# fill by sex
ggplot(data = surveys, aes(x=sex, y = hindfoot_length, fill=sex)) + 
  geom_boxplot()

ggplot(data = surveys, aes(x=plot_type, y = weight, fill=sex)) + 
  geom_boxplot()

ggsave(filename = 'boxplot.png')
# most recent

plot_save = ggplot(data = surveys, aes(x=sex, y = hindfoot_length, fill=sex)) + 
        geom_boxplot()

ggsave(filename = 'boxplot_2.png', plot = plot_save)



# select ------------------------------------------------------------------

# base R
surveys[,c('sex', 'weight', 'hindfoot_length')]

# in tiudyverse
select(surveys, sex, weight, hindfoot_length)

# get column names
colnames(surveys)

# select column nmaes which have id in them
select(surveys, contains('id'))

# sequence
select(surveys, record_id:plot_id)


# filter ------------------------------------------------------------------

filter(surveys, year > 2000)

# some data was filtered out

# WRONG
filter(surveys, taxa = 'Bird')

temp = filter(surveys, taxa == 'Bird')

temp$hindfoot_length

select(temp, hindfoot_length)

# All NAs !
# That is why not plotted in 
ggplot(data = surveys, mapping = aes( x = weight, y = hindfoot_length, shape = sex, color = taxa )) + 
     geom_point()


# remove missing values ---------------------------------------------------

filter(surveys, !is.na(hindfoot_length))

filter(surveys, !is.na(sex))

filter(surveys, !is.na(sex), !is.na(hindfoot_length))

drop_na(surveys, sex, hindfoot_length)

# check all columns
drop_na(surveys)

surveys_complete = tidyr::drop_na(surveys)
surveys_complete



# Pipes -------------------------------------------------------------------

# combine two or more commands
temp = select(surveys, year, taxa, hindfoot_length) 

#############################
#   QUESTION
#############################
# will this command work?
filter(temp, sex =='M')

# pipe
surveys %>% select()

# data is already available so no need to specify in select()

surveys %>% select(year, taxa, hindfoot_length)


surveys %>% 
  select(year, taxa, hindfoot_length) %>%
  filter(taxa == 'Bird')

# WRONG
surveys %>% 
  select(year, taxa, hindfoot_length) %>%
  filter(sex == 'M')


################################
# QUESTION: Will this work?
################################
surveys %>% 
  filter(sex == 'M') %>%
  select(year, taxa, hindfoot_length)



# Challenge pipes ---------------------------------------------------------

# https://cambiotraining.github.io/intro-r/03-tidyverse.html#Challenge_1_-_pipes

# time should be 12 PM. Break at 12:30 PM

# challenge 1
surveys_complete %>%
  filter(year > 1995) %>%
  select(species_id, weight, hindfoot_length, year, sex)

surveys_complete %>%
  filter(year > 1995) %>%
  select(species_id, weight, hindfoot_length, year, sex) %>%
  ggplot( mapping=aes(x=weight,y=hindfoot_length) ) + 
    geom_point()

# challenge 2
temp_var <- surveys_complete %>%
              filter(year > 1995)

ggplot(data = temp_var, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point()
ggplot(mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point(data = surveys_complete) + 
  geom_point(data=temp_var, color='red')


ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point() + 
  geom_point(data=temp_var, color='red')


# After lunch break -------------------------------------------------------

# meet after lunch 12:45 PM to 1:45 PM lunch


surveys_complete %>%
  summarize(mean_weight = mean(weight))

surveys_complete %>%
  count(sex, species)

# create a new variable
surveys_complete %>%
    mutate(weight_kg = weight/100)
# save it to the tibble
surveys_complete <- surveys_complete %>%
                      mutate(weight_kg = weight/100)

# sort
surveys_complete %>%
  arrange(weight)

surveys_complete %>%
  arrange(weight, desc(hindfoot_length))

# use group
surveys_complete %>%
  count(sex)

# challenge 1
# https://cambiotraining.github.io/intro-r/03-tidyverse.html#Challenge28

surveys_complete %>% 
  count(plot_type)

# challenge 2
surveys_complete %>%
  count(sex, species)

surveys_complete %>%
  count(sex, species) %>%
  arrange(species)

surveys_complete %>%
  count(sex, species) %>%
  arrange(species, desc(n))
  

yearly_count <- surveys_complete %>%
                    count(year, genus)

# ggplot
ggplot(data = yearly_count, mapping=aes(x=year, y=n)) + 
  geom_point()

# group by genus
ggplot(data = yearly_count, mapping=aes(x=year, y=n, group=genus)) + 
  geom_point()

ggplot(data = yearly_count, mapping=aes(x=year, y=n, group=genus)) + 
  geom_line()

# color
ggplot(data = yearly_count, mapping=aes(x=year, y=n, color=genus)) + 
  geom_line()


# new mean weight of females
surveys_complete %>%
  filter(sex == 'F')

surveys_complete %>%
  filter(sex == 'F') %>%
  summarise(mean_weight_female = mean(weight))

# now for males
surveys_complete %>%
  filter(sex == 'M') %>%
  summarise(mean_weight_male = mean(weight))


surveys_complete %>%
  group_by(sex)

# mean weight of each gender
surveys_complete %>%
  group_by(sex) %>%
  summarise(mean_wt = mean(weight))



# challenge ---------------------------------------------------------------

# https://cambiotraining.github.io/intro-r/03-tidyverse.html#Challenge33

surveys_complete %>%
  group_by(species)

surveys_complete %>%
  group_by(species) %>%
  summarise(mean_length = mean(hindfoot_length))
  
surveys_complete %>%
  group_by(species) %>%
  summarise(mean_length = mean(hindfoot_length), n=n())

  
# challenge 2
surveys_complete %>%
  group_by(species, year)

surveys_complete %>%
  group_by(species, year) %>%
  summarise(mean_wt = mean(weight))

# facet_wrap()
yearly_count <- surveys_complete %>%
  count(year, genus)

ggplot(data = yearly_count, mapping=aes(x=year, y=n))  +
  geom_line()

ggplot(data = yearly_count, mapping=aes(x=year, y=n, color=genus))  +
  geom_line()

ggplot(data = yearly_count, mapping=aes(x=year, y=n))  +
  geom_line() + 
  facet_wrap(facets = vars(genus))

ggplot(data = yearly_count, mapping=aes(x=year, y=n))  +
  geom_line() + 
  facet_grid(rows = vars(genus))


#ggplot(data = yearly_sex_count, mapping = aes(x=year, y=n)) + 
#  geom_line() + 
#  facet_grid(rows=vars(sex), cols=vars(genus))

# labels
ggplot(data = yearly_count, mapping=aes(x=year, y=n))  +
  geom_line() + 
  labs(title = "title", x = 'year', y = 'n')

# theme
ggplot(data = yearly_count, mapping=aes(x=year, y=n))  +
  geom_line() + 
  labs(title = "title", x = 'year', y = 'n') + 
  theme_bw()


# theme
ggplot(data = yearly_count, mapping=aes(x=year, y=n))  +
  geom_line() + 
  labs(title = "title", x = 'year', y = 'n') + 
  theme_light()

# theme star wars
# challenge
library(devtools)
devtools::install_github('https://github.com/MatthewBJane/ThemePark')
library(ThemePark)
ggplot(data = yearly_count, mapping=aes(x=year, y=n))  +
  geom_line() + 
  labs(title = "title", x = 'year', y = 'n') + 
  theme_starwars()

ggplot(data = yearly_count, mapping=aes(x=year, y=n))  +
  geom_line() + 
  labs(title = "title", x = 'year', y = 'n') + 
  theme_lordoftherings()

ggplot(data = yearly_count, mapping=aes(x=year, y=n))  +
  geom_line() + 
  labs(title = "title", x = 'year', y = 'n') + 
  theme_dune()


# set at top of project
library(ggplot2)
theme_set(theme_bw())


# use chatGPT/google/stackoverflow


# Challenge  --------------------------------------------------------------

surveys_complete %>% 
  group_by(species, year) %>%
  summarise(av_wt = mean(weight))


year_varn_weight <- surveys_complete %>% 
                      group_by(species, year) %>%
                      summarise(av_wt = mean(weight))

ggplot2::ggplot(data = year_varn_weight, mapping = aes(x=year,y=av_wt)) + 
            geom_line()

ggplot2::ggplot(data = year_varn_weight, mapping = aes(x=year,y=av_wt)) + 
  geom_line() + 
  facet_wrap(facets = vars(species))

# add theme

# Challenge EXTRA ---------------------------------------------------------


# NEW CHALLENGE QUESTION
# figure out how to use the xkcd theme
# use Google and use ChatGPT (because why not?!)



# heatmaps EXTRA ----------------------------------------------------------


# something aboiut heatmaps

library(pheatmap)
# TODO: challenge the following mgith crash
# TODO: challenge fix it
pheatmap::pheatmap(surveys_complete[,c('hindfoot_length','weight')])
heatmap()



# save files --------------------------------------------------------------

write_csv(surveys_complete, file = 'surveys_complete.csv')


# wrap up about 4:30 PM

# optional challenege on box plot
# Using the surveys_complete dataset, create a boxplot
# for each year on the x-axis and weight in kg on the y-axis. Filter the dataset so that only recent observations (from 1995 onwards) are used. As before try to do all the operations using pipes, without creating variables.

surveys_complete %>%
  filter(year > 1995) %>%
  mutate(wt_kg = weight/1000)

# error
surveys_complete %>%
  filter(year > 1995) %>%
  mutate(wt_kg = weight/1000) %>%
  ggplot(mapping = aes(x = year, y = wt_kg)) + 
  geom_boxplot()

# error
surveys_complete %>%
  filter(year > 1995) %>%
  mutate(wt_kg = weight/1000) %>%
  mutate(as.factor(year)) %>%
  ggplot(mapping = aes(x = year, y = wt_kg)) + 
  geom_boxplot()


# as.factor 
surveys_complete %>%
  filter(year > 1995) %>%
  mutate(wt_kg = weight/1000) %>%
  mutate(year = as.factor(year)) %>%
  ggplot(mapping = aes(x = year, y = wt_kg)) + 
    geom_boxplot()


# EOL