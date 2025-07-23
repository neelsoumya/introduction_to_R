1 + 2
h <- 1 + 2

?mean
mean(m)

weight_kg <- 67.6
67.6 * 2.2

weight_kg <- 67.6 * 2

weight_kg <- weight_kg * 2.2
weight_kg <- weight_kg * 2.2

# this is a test script

sqrt(a)
a <- 17
sqrt(a)

b <- "hello"
sqrt(b)

c<- 3
sqrt(b,c)

d<- 4

weight_vector <- c(50, 60, 70)
weight_vector <- c(50, 60, 70, b)
"50"
50 

b <- "hello"/10
b <- "hello" * 3
b <- "hello" / "world"

b <- hello  


heights <- c(2,4,4,17,NA,23)
heights
View(heights)

?mean
mean(heights)
mean(heights, na.rm = TRUE)

###############################
# Introduction to packages
###############################
install.packages("tidyverse")

library(tidyverse)

#################
# download some data
#####################
download.file(url="https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")


##########
# load data
surveys <- read_csv(file = "data_raw/portal_data_joined.csv")
View(surveys)
head(surveys)
summary(surveys)

surveys$hindfoot_length
mean(surveys$hindfoot_length)
mean(surveys$hindfoot_length, na.rm = TRUE)


######################
# Visualization
######################
plot(surveys$hindfoot_length)

# ggplot
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length))
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) + geom_point()

ggplot(data = surveys, mapping = aes(x = plot_type, y = hindfoot_length)) + geom_boxplot()


# deal with missing values
surveys %>% 
  drop_na()

drop_na(data = surveys)

surveys_complete <- drop_na(data = surveys)

# select columns
surveys_complete %>%
  select(species_id, weight)

# filter
surveys_complete %>%
  filter(year >= 1995)

surveys_complete %>%
  filter(year == 1997)

e = 15

yy <- surveys_complete %>%
  select(species_id, weight, hindfoot_length, year, sex)

yy %>%
  filter(year >= 1995)

surveys_complete %>% 
  select(species_id, weight, hindfoot_length, year, sex) %>%
  filter(year >= 1995)


