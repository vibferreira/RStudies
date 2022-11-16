# Environment computing - Graphics - PCA and Clustering
####################################################
library(dplyr)
Leaf_shape <- read.csv(file = "data/Leafshape.csv", header = TRUE)

head(Leaf_shape)

species <- Leaf_shape$Species
pca_data <- select(Leaf_shape, -Species) #select only the variables to run pca

# pca
Leaf_PCA <- princomp(pca_data, cor = FALSE)
Leaf_PCA$sdev

# plot
plot(Leaf_PCA$scores, pch = 16, col = as.factor(species))
legend(0, 0.4, c("Species A", "Species B"), pch = 16, col = c("black", "red"))

# How much variance is explained by each component? 
# PC1 explains 90% of the variation between the two species with PC2 2 explaining a further 6.6%
summary(Leaf_PCA)
screeplot(Leaf_PCA, type = "lines")

# How are the original variables related to the principal components?
# PC1 is positively correlated with the two width variables.
loadings(Leaf_PCA) # correlations between the principal components and the original variables!!!
biplot(Leaf_PCA)

#---------------------------Cluster-----------------------------------------


