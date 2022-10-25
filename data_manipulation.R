# Environment computing - Data Manipulation 
##############################################################################

library(tidyverse)

# read data
df <- read.csv('data/Herbivore_specialisation.csv', 
               strip.white = T, 
               na.strings = "", 
               stringsAsFactors=FALSE)
str(df)
summary(df)

# add a new variable name 
# without any package
# df$LogMass <- log(df$Mass)

# with dplyr
df <- mutate(df, LogMass = log(Mass), # log of the mass
             Ampithoe = rowSums(df[,6:8]), # sum of ampithoe
             )

df <- rename(df, Biomass = Mass)

# unite two character variables 
df <-unite(df, Habitat_DayNight, c(Habitat, DayNight), sep = "_", remove = FALSE)
head(df)

# separating columns 
df <-separate(df, Habitat, c('Genus', 'Species'), sep = "_", remove = FALSE)
head(df)

# try with the pipe


# Sub-setting 
df[1:10,] # lines 1 to 10
head(df[,1:5]) # cols 1 to 5

# Subsetting when it does not forms a sequence 
df[c(1, 10:20), c(1,3:5)]

# subseting based on a filter
df <- filter(df, Biomass > 5)

# random sampling from the dataset
sampled = sample_frac(df, size = 0.5, replace = FALSE)

# top highest rows
ex <- top_n(df, 10, Biomass)

# find col index 
df[, grep('^Habitat$', colnames(df)): 10] # using grep and regular expressions
df[, which(names(df)=='Habitat')] # using which

df <- distinct(df)

# Subset using the col names
df_subset1 <- select(df, Genus) # one col
df_subset2 <- select(df, Genus, LogMass, Ampithoe) # specific cols
df_subset3 <- select(df, Biomass: Ampithoe) # sequence of cols

# Subseting colums that starts or ends with a determined value
df_subset4 <- select(df, starts_with('Am'))
df_subset5 <- select(df, ends_with('ass'))

df_subset6 <- select(df, matches('^Amp')) # with regular expression
df_subset7 <- select(df, matches('ass$')) # with regular expression

df_subset8 <- select(df, contains('Night')) # contain a sequence of characters

# exclude colums
df_subset9 <- select(df, -LogMass, -Ampithoe)

# ?dplyr

# Summarising Data 
summarise(df, Biomass_test = mean(Biomass))
mean(df$Biomass)

# Summary group of rows -> group_by # careful with NA 
df_summarised <- df %>% 
  group_by(Species) %>% 
  summarise(
    mean.Biomass = mean(Biomass, na.rm=TRUE), # mean
    min.Biomass = min(Biomass, na.rm=TRUE), # minimum
    max.Biomass = max(Biomass, na.rm=TRUE), # maximum
    med.Biomass = median(Biomass, na.rm=TRUE), # median
    sd.Biomass = sd(Biomass, na.rm=TRUE)) %>% # standard deviation
  arrange(desc(mean.Biomass)) # rearrange the order of the rows

ggplot(df) +
  geom_boxplot(mapping = aes(Biomass, Species, fill = DayNight)) +

