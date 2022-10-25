# Environment computing - Data Manipulation
##############################################################################

library(tidyr)
# load data
df_fish <- read.csv('data/ReefFish.csv')
View(df_fish)

# reshaping from long to wide format 
# key refers to the the obs to be transformed into columns
# value refers to the value to be filled 
# fill refers to what to fill in the lack of observations

wide_df <- spread(data=df_fish, key=Species, value=Abundance, fill=0)


# reshaping from long to wide format 
# key refers to the the obs to be transformed into columns
# value refers to the value to be filled 
# columns to be changed (by name or index)
long_df <- gather(wide_df, Species, Abundance, 4:6)

# reshape2 


