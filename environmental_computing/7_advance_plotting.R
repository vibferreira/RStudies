# Environment computing - Graphics - Advanced Plotting 
####################################################

library(dplyr)
library(ggplot2)

# data
data(iris)

str(iris)
# boxplot
# x has to be a factor
plot1 <- ggplot(iris, aes(Species, Petal.Length)) +
  geom_boxplot()

print(plot1)

# Frequency histogram
plot2 <- ggplot(iris, aes(Petal.Length)) +
  geom_histogram()

print(plot2)

# Scatter plot
plot3 <- ggplot(iris, aes(Sepal.Length, Petal.Length, color=Species)) +
  geom_point() +
  theme_classic()

print(plot3)

# Customization 
IrisPlot <- ggplot(iris, aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point()

mytheme <- # change the legend title
  theme(legend.title = element_text(colour = "steelblue", size = rel(2)))

mytheme2 <-
  theme(
    panel.background = element_rect(
      fill = "black", # color the graph background
      colour = "yellow", # color the outer bounds of the graph
      size = 4 # thicknees of the graphs lines
    ),
    legend.key = element_rect(fill = "darkgrey", colour = "yellow"), # background of each of the legend entrances
    legend.background = (element_rect(colour = "yellow", fill = "blue")) # background of the legend entirely
  )


mytheme3 <- theme(
  axis.line = element_line(size = 0, colour = "grey"),
  axis.ticks = element_line(size = 1), # ticks in the graphs 
  panel.background = element_blank() # removing an element from the graph
)

print(IrisPlot + mytheme)
print(IrisPlot + mytheme2)
print(IrisPlot + mytheme3 + 
        labs(title = 'Playing with two line title \n hey jude', 
             y='Petal length (cm)',x='Speal Length (cm)'))


#------------Colors and Shape-----------------

# Base plots 
IrisPlot_Species <- ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) +
  geom_point()

IrisPlot_Sepal <- ggplot(iris, aes(Sepal.Length, Petal.Length, 
                                   color = Sepal.Width)) +
  geom_point(shape=17)

IrisBox <- ggplot(iris, aes(Species, Sepal.Length, fill = Species)) +
  geom_boxplot()

IrisHist <- ggplot(iris, aes(Sepal.Length)) +
  geom_histogram()

# choose color gradient
# green scale
IrisPlot_Sepal + scale_colour_gradient(low =  "darkolivegreen1", high = "darkolivegreen")

# gray scale 
IrisPlot_Species + scale_colour_brewer(palette = "Dark2")


print(IrisPlot_Species + 
        scale_shape_manual(values = c(0, 16, 3)) +
        scale_colour_manual(values = c("chartreuse4", "chocolate", "slateblue4")))

#-------------- Bar plots and error bars ----------------------------

# 1. summarise the data
Iris_summary <- iris %>% # the names of the new data frame and the data frame to be summarised
  group_by(Species) %>% # the grouping variable
  summarise(
    mean_PL = mean(Petal.Length), # calculates the mean of each group
    sd_PL = sd(Petal.Length), # calculates the standard deviation of each group
    n_PL = n(), # calculates the sample size per group
    SE_PL = sd(Petal.Length) / sqrt(n())
  ) # calculates the standard error of each group

# 2. Plot
IrisPlot <- ggplot(Iris_summary, aes(Species, mean_PL)) +
  geom_col() + # bars
  geom_errorbar(aes(ymin = mean_PL - sd_PL, 
                    ymax = mean_PL + sd_PL), width = 0.2) #error arrows

IrisPlot + labs(y = "Petal length (cm) +/- s.d.", 
                x = "Species") + theme_classic()


