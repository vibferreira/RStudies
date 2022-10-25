# Environment computing - Data Manipulation
##############################################################################

library(dplyr)

df_bats <- read.csv('data/Bats_data.csv')
df_geo <- read.csv('data/Geo_data.csv')
df_weather <- read.csv('data/Weather_vars.csv')

summary(df_geo)
summary(df_weather)

# Combining datasets 



