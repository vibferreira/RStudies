# Environment computing - Coding Skills
##############################################################################

library(formatR)
library(tidyverse)

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
# Lapply 
movies <- c("SPYDERMAN","BATMAN","VERTIGO","CHINATOWN")
movies_lower <-unlist(lapply(movies, tolower))
str(movies_lower)

# another way to do the same thing
df <- data.frame(movies=movies, 
                 score = c(sample(10, size=length(movies))))
df$movies <- tolower(df$movies)

df$score <- lapply(df$score, sqrt) # return a list
df$score <- sapply(df$score, sqrt) # return a vector

str(movies_lower)

# Note we can add any argument to the FUN as an argument of lapply/sapply
CAR <- cars
lapply(CAR, std_error, na.rm=TRUE)  # return a list
sapply(CAR, std_error, na.rm=TRUE) # return a vector

sapply(df$movies, tolower)

#-------Simulating data-----------------------------
library(help = "datasets")
data(iris)
dput(head(iris))


iris_df <- structure(list(Sepal.Length = c(5.1, 4.9, 4.7, 4.6, 5, 5.4), 
               Sepal.Width = c(3.5, 3, 3.2, 3.1, 3.6, 3.9), 
               Petal.Length = c(1.4, 1.3, 1.5, 1.4, 1.7), 
               Petal.Width = c(0.2, 0.2, 0.2, 0.2, 0.4), 
               Species = structure(c(1L, 1L, 1L, 1L, 1L, 1L), 
               levels = c("setosa", "versicolor", "virginica"), 
               class = "factor")), 
               row.names = c(NA, 6L), class = "data.frame")

sessionInfo()
