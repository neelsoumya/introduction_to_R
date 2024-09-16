# basic -------------------------------------------------------------------

# find info
?sum

x  = 1.3

# concept of function
round(x = x)

3 + 5
x = 3
y = 5
x + y
z = x + y

# clear workspace


# day1 after coffee break variable types -------------------------------------------------


p = 'hello'

q = TRUE

weight = 50,60,70 # this wont work
# combine values c for concatenate
weight = c(50,60,70)

weight = c('rat', 50, 60)
# mixed all char


length(weight)
length('weight')

# find class
class(weight)

# concatenate
c(weight, 130)


# Challenge question vector -----------------------------------------------
sum(c(weight, 130))

sum(c(30,'hello'))


# Indexing ----------------------------------------------------------------

# memory structure

height = c(30,40,50)
height[3]
height[4]

height[c(3,2)]

# exercise: change order of numbers
# 1. hard code solution
height[c(3,2,1)]

# 2. use length() to solve this
height[c(length(...))]

# 3. using sequence
height[c(3:1)]

# same with characters
animals_vector = c('dog', 'cat', 'mouse')


# conditional subsetting --------------------------------------------------

height_filtered = height[height < 40]

height_filtered = height[height < 40 & height > 10]


# CONCEPT different from = NOTE
animals_vector[animals_vector == 'cat']

# in operator
animals_vector %in% c('rat', 'cthulhu')

animals_newvector = c('rat','dog','mouse', 'goat')

animals_newvector %in% c('rat', 'mouse')

animals_newvector %in% c('rat', 'mouse', 'kerberos')


# missing data ------------------------------------------------------------

height_missing = c(10, 20, NA, 45)

is.na(height_missing)

# quiz
# remove missing
!is.na(height_missing)
height_missing[c(TRUE, TRUE, FALSE, TRUE)]
height_missing[!is.na(height_missing)]

mean(height_missing)

# why height_missing not overwritten
# how to fix?
#   need to assign back

mean(height_missing, na.rm = TRUE)


complete.cases(height_missing)

height_fixed = height_missing[complete.cases(height_missing)]
height_fixed

#na.omit()


# After lunch day 1\ ------------------------------------------------------

# 1 hour lunch


# Starting with data ------------------------------------------------------
setwd("~/soumya_cam_mac/teaching/introduction_to_R")

download.file(url="https://ndownloader.figshare.com/files/2292169",
              destfile = "data/portal_data_joined.csv")

xy = 'rat'
# just like a variable
surveys <- read.csv("data/portal_data_joined.csv")

View(surveys)

str(surveys)
head(surveys)
summary(surveys)


# cleaning data -----------------------------------------------------------

surveys_wrong <- read.csv("data/portal_data_joined.csv", header = FALSE)

str(surveys_wrong)

# clean data

# concat columns
surveys[c(3,4)]

surveys[c(3,4,5),1]
surveys[1:6, 3]



# name indexing -----------------------------------------------------------

surveys[1:6,"species"]

# use $ 
surveys$species_id
surveys$species[1:5]


# logical indexing --------------------------------------------------------

surveys[surveys$species == 'albigula',]

surveys[surveys$species == 'albigula' & surveys$weight>10,]

surveys$taxa
table(surveys$taxa)


# exercise ----------------------------------------------------------------


############################################3
# get me maximum hindfoot lenggh pf rabbit
############################################
surveys$hindfoot_length
cleaned_hindfootlength = surveys$hindfoot_length[complete.cases(surveys$hindfoot_length)]
max(cleaned_hindfootlength)
#max(complete.cases(surveys$hindfoot_length))




# Factors -----------------------------------------------------------------
#categorical values
#problem for ML models

way to deal with categorical variables

meal = c('breakfast', 'lunch', 'dinner')

table(surveys$taxa)
4 categories

summary(surveys$taxa)
factor(surveys$taxa)

surveys$taxa = factor(surveys$taxa)

summary(surveys$taxa)

as.numeric()
summary(surveys)


# basic plotting ----------------------------------------------------------

plot(surveys$sex)

surveys$sex = as.factor(surveys$sex)

plot(surveys$sex)

surveys$sex = factor(surveys$sex, levels = c('M', 'F', '') )

plot(surveys$sex)
