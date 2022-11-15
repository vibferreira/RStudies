# Environment computing - Graphics - Multidimensional Scalling
####################################################

library(dplyr)
library(ggplot2)
library(vegan)

# data
data(iris)

Herbivores <- read.csv(file = "data/Herbivore_specialisation.csv", 
                       header = TRUE)

head(Herbivores,2)
str(Herbivores)

Herb_community <- Herbivores[5:11] # only the abundance values per sample
head(Herb_community)

#----------------MDS PLOT-------------------------

# 1. Dissimilarity matrix with your chosen metric that measures 
# the similarity between every pair of samples
# 2. Creating an ordination plot from that dissimilarity matrix

Herb_community.mds <- metaMDS(comm = Herb_community, # df with variables to be compared
                              distance = "bray", #type of dissimilarity measure 
                              trace = FALSE, # ignore in-progress outputs
                              autotransform = FALSE) # do not automatically transform the data

plot(Herb_community.mds$points)

mds_result <- data.frame(Herb_community.mds$points)

# refer to which habitat or colection time it refers to
mds_result$Habitat <- Herbivores$Habitat
mds_result$DayNight <- Herbivores$DayNight

# The graph shows how similar each point is from each other
# e.g. samples from the same habitat are more likely to be similar to each other than to other habitat
# IMPORTANT: not a statistics test, just a visualization strategy to seek patterns 
ggplot(mds_result, aes(MDS1, MDS2, color = Habitat)) +
  geom_point() +
  theme_bw()

# Stress 
# Corresponds with the actual multivariate distance between the samples. 
# Lower stress values indicate greater conformity and therefore are desirable. 

print(Herb_community.mds$stress)

?adonis
