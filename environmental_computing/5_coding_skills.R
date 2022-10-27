# Environment computing - Coding Skills
##############################################################################

library(formatR)
library(tidyverse)

#----------For Loop------------------
vec <- vector(length = 10) # how to create an empty vector in R (similar to np.zeros(10) in python)
vec_1 <-  vector(length = 10)

for (i in 1:10) {
  # store the value of the operation in 
  vec[i] = i * 10
  
  if (vec[i] == 20) {vec[i] = 0} # if condition 

}

# Dataframe
df <- data.frame(col1 = vector(), 
                 col2 = vector()) # makes a blank data frame with two columns

for (i in 1:10) {
  col1 <- i^2 # performs first operation
  col2 <- sqrt(i) # performs second operation
  print(col1, col2)
  df <- rbind(df, cbind(col1, col2)) # overwrites 'x2' values including the new row
}

# Testing if I get it
# it is better/ safer to define the variable type from the beginning
df2 <- data.frame(number = integer(length = 10), 
                  num_letter = character(length = 10), 
                  stringsAsFactors = F) 

for (i in 1:10) {
  number <- i 
  char_num <- as.character(i +1)
  
  df2[i,] <- c(number = number, 
               num_letter = char_num) # indexing, similar to the dict in python
}
                 
df2

# The apply family


#---------Functions-------------------
# Notes for life: 
# a good function does ONE thing well
# it's as short as it can be (aim at generic)

algae <- read_csv("data/Algal_traits.csv")

std_error <- function(x, na.rm=FALSE) { # note that functions in R are stored to variable that are also their name
  # calculates the sample std error
  #
  # x: sample vector
  # na.rm: boolean (TRUE or FALSE) indicating if na should or should not be removed
  #
  # return: std error of sample
  
  return(sqrt(var(x, na.rm = na.rm)/sum(!is.na(x)))) # writing return is not necessary
}

std_error(algae$strength, na.rm = TRUE)

?mean

# Functions that returns multiple variables

fit <- lm(algae$height ~ algae$dryweight)

names(fit)
fit$coefficients
