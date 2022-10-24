# Environment computing - Getting started with R 
##############################################################################

library(tidyverse)
# read data
# strip.white <- removes some common typing error mistakes (very useful)
# na.strings <- ensures empty cells are replaces by NA (important)
# a lot of pre-processing can be done already on the read data stage

snail_feed <- read.csv('data/Snail_feeding.csv', 
                       strip.white = T, 
                       na.strings = "", 
                       stringsAsFactors=FALSE) 

# Check the data before going any further 
str(snail_feed) # check data types
summary(snail_feed) # basic stats about the data

# selecting only useful columns
snail_feed = snail_feed[, 1:7]

# select only the rows that are not entirely NAs
snail_feed <- snail_feed[, colSums(is.na(snail_feed)) != nrow(snail_feed)]
# snail_feed <- drop_na(snail_feed)

# changing data type of the id
# factors helps to categorize the data in a structured way 
# factors are a special type of integer with predefined categories
snail_feed$Snail <-  as.factor(snail_feed$Snail)
class(snail_feed$Snail)

# distance variable was read as character instead of intenger
# if it was read as a factor it would need first to be transformed into character and then into numeric 
class(snail_feed$Distance)
snail_feed$Distance <-  as.numeric(snail_feed$Distance)

# Dealing with the NAs introduced by coercion
# Find which rows were trasnformed into NA
which(is.na(snail_feed$Distance))
snail_feed[682, "Distance"] <- 0.356452 # solve issue by idexing the right value
snail_feed[755, "Distance"] <- 0.42336
which(is.na(snail_feed$Distance))

# verifying typing errors in the Sex variable
unique(snail_feed$Sex)
snail_feed$Sex[which(snail_feed$Sex == 'males' | snail_feed$Sex == 'Male')] <- 'male'
snail_feed$Sex[which(snail_feed$Sex == 'female s')] <- 'female'

snail_feed$Sex <- as.factor(snail_feed$Sex) # transform as factor
levels(snail_feed$Sex)

# look for rows with a depth greater than 2
snail_feed[which(snail_feed$Depth > 2), ]
snail_feed[which(snail_feed$Depth > 2), 'Depth'] <- 1.62

summary(snail_feed)

# write transformed data
write.csv(x = snail_feed, file='outputs/snail_feed_clean.csv')
