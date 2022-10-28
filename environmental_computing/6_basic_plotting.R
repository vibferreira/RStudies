# Environment computing - Graphics - Basic Plotting 
####################################################

library(dplyr)

#-----------One Continuous variables-----------------

fish_df <- read.csv('data/Estuary_fish.csv')
head(fish_df)

# check for NA
fish_df[which(is.na(fish_df)),]

# Plot simple histogram
hist(fish_df$Length, 
     breaks=10, 
     col = 'thistle3',
     xlab='Length (cm)',
     main='Histogram of fish length',
     )

# Boxplot
boxplot(fish_df$Length, 
        horizontal = T, 
        xlab='Length (cm)',
        main='Boxplot of fish length (cm)', 
        ylim=c(0,30), 
        col="yellow4")

# Assess the range of possible colors
colors()

#-----------Two Continuous variables------------------

plant_height_df <- read.csv('data/Plant_height.csv')
head(plant_height_df)
str(plant_height_df)

# Scatterplot 
plot(data=plant_height_df, 
     loght ~ temp, # loght in function of temp
     xlab = 'Temperature (°C)', 
     ylab = 'log(Height (m))', 
     main='Plant height vs Temperature', 
     xlim=c(-12,30), 
     pch=19, 
     col="violetred")

# Best fit line (linear model)
abline(lm(loght ~ temp, data = plant_height_df))

?pch

#------One Continuous and one categorical variable---------
# Boxplots
praws_df = read.csv('data/Prawns_MR.csv')
str(praws_df)

boxplot(Metabolic_rate ~ Species, 
        data = praws_df,
        ylab = 'Metabollic rate',
        names = c("Penaeus monodon", "Fenneropenaeus merguiensis"))

# Bar plots with error bars 
# Error bars are std deviation, std error, 95% confidence interval

praws_summarised <- praws_df %>% 
  group_by(Species) %>% 
  summarise(mean=mean(Metabolic_rate),
            sd = sd(Metabolic_rate), 
            lower=mean(Metabolic_rate) - sd(Metabolic_rate), 
            upper=mean(Metabolic_rate) + sd(Metabolic_rate))

# base of the plot
prawn_plot <- barplot(praws_summarised$mean,
                      names.arg = praws_summarised$Species,
                      ylab = "Metabolic rate", xlab = "Species", ylim = c(0, 1),
                     
)
?barplot

# error bar 
arrows(prawn_plot, 
       praws_summarised$lower, 
       prawn_plot, 
       praws_summarised$upper, 
       angle = 90, code = 3)

?arrows

praws_summarised
