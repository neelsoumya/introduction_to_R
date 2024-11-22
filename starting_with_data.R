# Starting with data

#download.file(url="https://ndownloader.figshare.com/files/2292169",
#              destfile = "data/portal_data_joined.csv")


# check directory exists

# setwd()
# check present working directory

##########################
# read and load data
##########################

# comment/document your code

surveys <- read.csv("data/portal_data_joined.csv")

head(surveys)

# View your data
View(surveys)

# structure of your data
str(surveys)

#######################
# Inspect your data
#######################
# as a data scientist, you are spending 80% of your time doing this

dim(surveys)
nrow(surveys)
ncol(surveys)

# show your data
head(surveys)
head(surveys, n = 100)

tail(surveys)

# names of rows and columns
colnames(surveys)
rownames(surveys)

# summary of your data
str(surveys)
summary(surveys)


########################################
# Indexing 
#   CONCEPT: row and column in matrix
########################################
surveys[1,2]

surveys[1,200]

surveys[210000,1]

surveys[30,]

# name indexing
surveys$year

surveys[,"year"]

surveys[,"year1"]

surveys[1:3, c("year", "species")]
  
surveys[surveys$species == "merriami",]

surveys[surveys$species == "merriami"]

surveys$species == "merriami"

###########################
# EXERCISE
###########################

# how many rows

# can you select the first 100 rows

# can you select the last 10 rows



surveys[surveys$species == "merriami",]

var1 = surveys[surveys$species == "merriami",]

dim(var1)

head(var1)

tail(var1, n=10)

# BREAK!


##########################
# quick visualization
##########################
View(surveys)

hist(surveys$hindfoot_length)

plot(surveys$hindfoot_length, surveys$year)

plot(surveys$year, surveys$hindfoot_length)

#############
# CHALLENGE
#############

use boxplot() function

hindfoot length vs species

use any tools!
  
  
  
  
  








boxplot(surveys$hindfoot_length)

boxplot(surveys$hindfoot_length ~ surveys$species)

# https://r-graph-gallery.com/23-add-colors-to-specific-groups-of-a-boxplot.html



#################################
# CHALLENGE
#   discuss with your friends
#################################



Challenge
Create a data.frame (surveys_200) containing only the data in row 200 of the surveys dataset.

Notice how nrow() gave you the number of rows in a data.frame?
  
  Use that number to pull out just that last row in the data frame.
Compare that with what you see as the last row using tail() to make sure it’s meeting expectations.
Pull out that last row using nrow() instead of the row number.
Create a new data frame (surveys_last) from that last row.
Use nrow() to extract the row that is in the middle of the data frame. Store the content of this row in an object named surveys_middle.

Combine nrow() with the - notation above to reproduce the behavior of head(surveys), keeping just the first through 6th rows of the surveys dataset.


## 1.
surveys_200 <- surveys[200, ]
## 2.
# Saving `n_rows` to improve readability and reduce duplication
n_rows <- nrow(surveys)
surveys_last <- surveys[n_rows, ]
## 3.
surveys_middle <- surveys[n_rows / 2, ]

#######################################################
# QUESTION: what would happen if this is not integer?
########################################################

## 4.
surveys_head <- surveys[-(7:n_rows), ]


# BREAK?

#############
# Factors
#############

# can encode Male as 1 and Female as 0?
#     what problems
#  what if M and F encoded


surveys$sex

surveys$sex <- factor(surveys$sex)

surveys$sex

summary(surveys$sex)

# GREAT FUNCTION to get counts of each!
table(surveys$species)
table(surveys$sex)

summary(surveys$species)
summary(surveys$sex)


# levels
# Once created, factors can only contain a pre-defined set of values
# , known as levels. Factors are stored as integers associated with 
# labels and they can be ordered or unordered. While factors look (and often behave) like character vectors, they are actually treated as integer vectors by R. 
# So you need to be very careful when treating them as strings.

sex <- factor(c("Male","Female"))
sex

sex_reordered <- factor(c("Male","Female"), levels = c("Male","Female")) 
sex_reordered

# maybe important in how you want to plot

##########################
# CHALLENGE
##########################
# 1. Change the columns taxa and genus in the surveys data frame into a factor.

surveys$taxa <- factor(surveys$taxa)

summary(surveys$taxa)

table(surveys$taxa)

levels(surveys$taxa)

# Quick plot
boxplot(surveys$hindfoot_length ~ surveys$taxa)

# How to reorder in plot?

##########################
# Challenge:
# how to reorder them?
##########################


#########################
# CHALLENGE
#########################

# why Rabbit have no hindfoot? How would you check?













surveys[surveys$taxa == "Rabbit",]



#####################
# OPTIONAL
#   renaming factors
#####################

plot(sex)
plot(surveys$sex)

levels(surveys$sex)

levels(surveys$sex)[1]

levels(surveys$sex)[1] <- "unknown"

plot(surveys$sex)

#####################
# CHALLENGE
#   reorder
#####################

######################
# CHALLENGE
# Rename “F” and “M” to “female” and “male” respectively.
# Now that we have renamed the factor level to “undetermined”, can you recreate the barplot such that “undetermined” is last (after “male”)?
######################

levels(surveys$sex)
levels(surveys$sex)[1]
levels(surveys$sex)[2] <- "Female"
levels(surveys$sex)[3] <- "Male"

surveys$sex <- factor(surveys$sex, levels = c("Female", "Male", "unknown") )

plot(surveys$sex)


# delete workspace

# delete plots

# save plots

# END!

# QUESTIONS?


