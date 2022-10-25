# Environment computing - Data Manipulation
##############################################################################

library(dplyr)

df_bats <- read.csv('data/Bats_data.csv')
df_geo <- read.csv('data/Geo_data.csv')
df_weather <- read.csv('data/Weather_vars.csv')

summary(df_geo)
summary(df_weather)

# Combining datasets, no missing values
# left_join 
bats_geo <- left_join(df_bats, df_geo, by='Site')
bats_geo_weather <- left_join(bats_geo, df_weather, 'Date')

dim(bats_geo_weather)
colnames(bats_geo_weather)

# Combining datasets, missing values
Bat_sim <- as.data.frame(cbind(
  Site = c("A", "B", "C", "D", "E"),
  Activity = c(62, 29, 30, 23, 24)
))

Tree_sim <- as.data.frame(cbind(
  Site = c("D", "E", "F", "G", "H"),
  Tree_density = c(525, 390, 477, 778, 817)
))

# Inner-Join
# joins only rows that have obs in both dfs 
inner_df <- inner_join(Bat_sim, Tree_sim, by='Site')

# left X right
# performing a left_join will preserve the obs in the left df in the function
# the missing values in the right df are replaced by NA
left_df <- left_join(Bat_sim, Tree_sim, by='Site')

# performing a right_join will preserve the obs in the right df in the function
# the missing values in the left df are replaced by NA
right_df <- right_join(Bat_sim, Tree_sim, by='Site')

# Preserving all observations
df_all <- full_join(Bat_sim, Tree_sim, by='Site')

# Checking all the observations that have measurements in both dfs (similar to inner join)
df_semi <- semi_join(Bat_sim, Tree_sim, by = "Site")

# Checking the observations that do not have measurements in both dfs
df_anti <- anti_join(Bat_sim, Tree_sim, by = "Site")
