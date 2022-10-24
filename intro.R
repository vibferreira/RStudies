# R for data science 
library(tidyverse)
mpg # built-in dataframe variable from tidyverse
head(mpg)
?mpg

# displ = engine size ; hwy = fuel efficiency
# An aesthetic is a visual property of the VARIABLES in the plot.
# Aesthetics do not refer how something looks, but to which VARIABLE is MAPPED ONTO IT.

ggplot(data = mpg) + 
  # geom_point adds a layer of points ; mapping/ aes = specify which variables to match
  geom_point(mapping = aes(x = displ, y = hwy))

# color placement
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = 'blue')) # here the color is interpreted as a categorical variable with one value 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# Map a continuous variable to color, 
# size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cty, y = hwy, alpha=year, color=year))

# the stroke parameter
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point(shape = 21, colour = "black", fill = "white", size = 5, stroke = 5)

# What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)?
ggplot(mpg) +
  geom_point(aes(cty, hwy, color= displ > 5))

# Facets 
ggplot(data = mpg) +
  geom_point(mapping = aes(x=cty, y=hwy, alpha=displ > 5), size=3) +
  facet_wrap(~ class, nrow=2) # the ~ follows the variable name from each we will split the data

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

unique(mpg$drv)

# Exercises
# The empty plots means that no car meets both the conditions at the same time
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl)) +
  facet_grid(drv ~ cyl)

# What plots does the following code make? What does . do?
# placing a . after the ~ maps facets in rows and placing it before the ~ makes facets columns 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# What are the advantages to using faceting instead of the colour aesthetic? 
# Better visualization on the trends of each class
# What are the disadvantages? 
# If the variable has two many options, it gets to clumsy and it may be harder to compare the trend between classes in different plots
# How might the balance change if you had a larger dataset?
# A larger dataset means more data points which could have a weaker vis 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow= 2)

# Geometric objects 
