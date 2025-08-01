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


##########################
# advanced visualization
##########################
ggplot(data = surveys_complete, mapping = aes(x=weight,y=hindfoot_length)) + 
  geom_point()

ggplot(data = surveys_complete, mapping = aes(x=weight, y=hindfoot_length)) + 
  geom_point(alpha = 0.3)

ggplot(data = surveys_complete, mapping = aes(x=weight, y=hindfoot_length)) + 
  geom_point(alpha = 0.3, color = "blue", shape=6)

# colour based on plot_type
ggplot(data = surveys_complete, mapping = aes(x=weight, y=hindfoot_length, colour = plot_type)) + 
  geom_point()

# colour in both aes() and geom_point()
ggplot(data = surveys_complete, mapping = aes(x=weight, y=hindfoot_length, color = plot_type)) + 
  geom_point(color = "green")

ggplot(data = surveys_complete, mapping = aes(x=weight, y=hindfoot_length, color = "blue")) + 
  geom_point(color = "green")



ggplot(surveys_complete, mapping = aes(x = genus, y=weight)) + 
  geom_boxplot()


ggplot(data = surveys_complete, mapping = aes(x=weight,y=hindfoot_length)) + 
  geom_point() + 
  geom_violin()
  
ggplot(data = surveys_complete, mapping = aes(x=weight,y=hindfoot_length)) + 
  geom_violin() + 
  geom_point() 
  

ggplot(data = surveys_complete, mapping = aes(x=weight,y=hindfoot_length)) + 
  geom_point() + 
  geom_smooth()


################
# facet wrap
################
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, color = plot_type)) + 
  geom_point() + 
  facet_wrap(facets = vars(plot_type))


#########################
# add a variable
#########################
surveys_complete$year 
surveys_complete$year > 2000

surveys_complete$after_2000 <- surveys_complete$year > 2000

ggplot(data = surveys_complete, mapping = aes(x=weight,y=hindfoot_length)) + 
  geom_point()

ggplot(data = surveys_complete, mapping = aes(x=weight,y=hindfoot_length, colour = after_2000)) + 
  geom_point()

#star wars theme
#drake package XX
#friday plots present

###########################
# more advanced plots
# colouring by a variable
###########################

library(tidyverse)
surveys_complete %>%
  mutate(is_ox = (species_id == "OX") ) %>%
  ggplot(mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point( aes(colour = "red"))

surveys_complete %>%
  mutate(is_ox = (species_id == "OX") ) %>%
  arrange(is_ox) %>%
  ggplot(mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point( aes(colour = is_ox))

ggsave(filename = "my_first_color_ggplot.png", )


surveys_complete$is_ox <- surveys_complete$species_id == "OX"



# assign ggplot to a variable
p1 <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point()

p1

ggsave(filename = "ggplot.png", plot = p1)

ggsave(filename = "ggplot.jpg", plot = p1)

# themes
p1 + theme_bw()

p1 + theme_classic()

p1 + theme_minimal()

devtools::install_github("MatthewBJane/ThemePark")
library(ThemePark)

p1 + ThemePark::theme_starwars()
p1 + ThemePark::theme_alien()
# Star Wars Themed ggplot2 Theme
# This script provides a complete Star Wars theme for your ggplot visualizations

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(aes(colour = plot_type)) +
  scale_colour_brewer(palette = "Dark2")


p1 <- p1 + labs(title = "My ggplot")

p1

0. one bad visoualization
1. shiny
2. rmarkdown

library(ggplot2)
library(dplyr)


# Simple gganimate example with Gapminder data
# This script creates animated visualizations of life expectancy vs GDP per capita

# ============================================================================
# 1. INSTALL AND LOAD PACKAGES
# ============================================================================

# Install packages if not already installed
if (!require(gapminder)) install.packages("gapminder")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(gganimate)) install.packages("gganimate")
if (!require(dplyr)) install.packages("dplyr")



# Load packages
install.packages("gapminder")
library(gapminder)
library(tidyverse)
#library(ggplot2)
#library(gganimate)
#library(dplyr)
head(gapminder)

# Summary statistics
summary(gapminder)

# ============================================================================
# 3. CREATE SCATTER PLOT
# ============================================================================

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# more advanced (color by continent)

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, 
                                       size = pop, color = continent)) +
  geom_point(alpha = 0.7)



# Basic animated scatter plot
animated_plot <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, 
                                       size = pop, color = continent)) +
  geom_point(alpha = 0.7) +
  scale_size_continuous(range = c(2, 12)) +
  scale_x_log10() +
  labs(title = "Life Expectancy vs GDP per Capita",
       subtitle = "Year: {frame_time}",
       x = "GDP per Capita (log scale)",
       y = "Life Expectancy (years)",
       size = "Population",
       color = "Continent") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 14),
        axis.title = element_text(size = 12),
        legend.title = element_text(size = 12)) +
  transition_time(year) +
  ease_aes("linear")

# Save the animation
print("💾 Saving animation...")
anim_save("gapminder_animation.gif", animated_plot, 
          duration = 10, fps = 10, width = 800, height = 600)

print("✅ Animation saved as 'gapminder_animation.gif'")
