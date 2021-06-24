#install.packages("tidyverse")
#install.packages("psych")

## Loading required libraries

library("tidyverse")
library("readr")
library("dplyr")
library("ggplot2")
library(psych)
library(lubridate)

#Loading latest 12 month of data only
setwd("D:/MyDataProjects/Divvy_bikesharing")
bikedf_01 <- read_csv("02_Data/DataRaw/202101-divvy-tripdata.csv")
colnames(bikedf_01)
colSums(is.na(bikedf_01)) 


bikedf_02 <- read_csv("02_Data/DataRaw/202102-divvy-tripdata.csv")
colnames(bikedf_02)
chk <- intersect(bikedf_01,bikedf_02)
bikedf_03 <- read_csv("02_Data/DataRaw/202103-divvy-tripdata.csv")
colnames(bikedf_03)

bikedf_04 <- read_csv("02_Data/DataRaw/202104-divvy-tripdata.csv")
colnames(bikedf_04)

bikedf_05 <- read_csv("02_Data/DataRaw/202105-divvy-tripdata.csv")
colnames(bikedf_05)

bikedf_06 <- read_csv("02_Data/DataRaw/202006-divvy-tripdata.csv")
colnames(bikedf_06)

bikedf_07 <- read_csv("02_Data/DataRaw/202007-divvy-tripdata.csv")
colnames(bikedf_07)

bikedf_08 <- read_csv("02_Data/DataRaw/202008-divvy-tripdata.csv")
colnames(bikedf_08)

bikedf_09 <- read_csv("02_Data/DataRaw/202009-divvy-tripdata.csv")
colnames(bikedf_09)

bikedf_10 <- read_csv("02_Data/DataRaw/202010-divvy-tripdata.csv")
colnames(bikedf_10)

bikedf_11 <- read_csv("02_Data/DataRaw/202011-divvy-tripdata.csv")
colnames(bikedf_11)

bikedf_12 <- read_csv("02_Data/DataRaw/202012-divvy-tripdata.csv")
colnames(bikedf_12)

#Merging all data after verifying the schema

bikedf_master <- rbind(bikedf_01, bikedf_02, bikedf_03, 
                       bikedf_04, bikedf_05, bikedf_06,
                       bikedf_07, bikedf_08, bikedf_09, 
                       bikedf_10, bikedf_11, bikedf_12 )

glimpse(bikedf_master)
str(bikedf_master)
summary(bikedf_master)
sum(is.na(bikedf_master))
sum(is.na(bikedf_master$start_station_name))
sum(is.na(bikedf_master$end_station_name))
sum(is.na(bikedf_master$start_station_id))
sum(is.na(bikedf_master$end_station_id))
describe(bikedf_master)




colSums(is.na(bikedf_master)) 


df.1<-data.frame("ride_id",sum(is.na(bikedf_master$ride_id)))
names(df.1)<-c("Filed","Nul; Values")

print( "Start station Name")
sum(is.na(bikedf_master$start_station_name))

print( "Start station ID")
sum(is.na(bikedf_master$start_station_id))

print( "End station Name")
sum(is.na(bikedf_master$end_station_name))

print( "End station ID")
sum(is.na(bikedf_master$end_station_id))

print("End Station lat/ lng")

sum(is.na(bikedf_master$end_lat))
sum(is.na(bikedf_master$end_lng))


bikedf_master.nona <- bikedf_master %>%
  drop_na()


bikedf_clean <- bikedf_master %>%
  drop_na()


# Add week day 
# Add duration of ride
# Month of ride
# Day of the month



bikedf_clean <- bikedf_clean %>% 
mutate(Weekday = weekdays(as.Date(started_at)))

bikedf_clean <- bikedf_clean %>% 
  mutate(dayofmonth = day(as.Date(started_at)))


bikedf_clean <- bikedf_clean %>% 
  mutate(pickup_time = format(started_at, format = "%H:%M:%S"))



int <- interval(bikedf_clean$started_at, bikedf_clean$ended_at)


bikedf_clean <- bikedf_clean %>% 
  mutate(ride_duration = trunc(time_length(int, "minutes")))

rm(bikedf_01)
bikedf_202101 <- read_csv("02_Data/DataRaw/202101-divvy-tripdata.csv")     
df202101_1 <- bikedf_202101 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202101_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202101_2 <- bikedf_202101 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202101_2) <- c('station_name',  'station_id',  'lat', 'lng')


bikedf_202102 <- read_csv("02_Data/DataRaw/202102-divvy-tripdata.csv")     
df202102_1 <- bikedf_202102 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202102_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202102_2 <- bikedf_202102 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202102_2) <- c('station_name',  'station_id',  'lat', 'lng')


bikedf_202103 <- read_csv("02_Data/DataRaw/202103-divvy-tripdata.csv")     
df202103_1 <- bikedf_202103 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202103_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202103_2 <- bikedf_202103 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202103_2) <- c('station_name',  'station_id',  'lat', 'lng')


bikedf_202104 <- read_csv("02_Data/DataRaw/202104-divvy-tripdata.csv")     
df202104_1 <- bikedf_202104 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202104_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202104_2 <- bikedf_202104 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202104_2) <- c('station_name',  'station_id',  'lat', 'lng')


bikedf_202105 <- read_csv("02_Data/DataRaw/202105-divvy-tripdata.csv")     
df202105_1 <- bikedf_202105 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202105_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202105_2 <- bikedf_202105 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202105_2) <- c('station_name',  'station_id',  'lat', 'lng')


bikedf_202006 <- read_csv("02_Data/DataRaw/202006-divvy-tripdata.csv")     
df202006_1 <- bikedf_202006 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202006_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202006_2 <- bikedf_202006 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202006_2) <- c('station_name',  'station_id',  'lat', 'lng')


bikedf_202007 <- read_csv("02_Data/DataRaw/202007-divvy-tripdata.csv")     
df202007_1 <- bikedf_202007 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202007_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202007_2 <- bikedf_202007 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202007_2) <- c('station_name',  'station_id',  'lat', 'lng')


bikedf_202008 <- read_csv("02_Data/DataRaw/202008-divvy-tripdata.csv")     
df202008_1 <- bikedf_202008 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202008_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202008_2 <- bikedf_202008 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202008_2) <- c('station_name',  'station_id',  'lat', 'lng')


bikedf_202009 <- read_csv("02_Data/DataRaw/202009-divvy-tripdata.csv")     
df202009_1 <- bikedf_202009 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202009_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202009_2 <- bikedf_202009 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202009_2) <- c('station_name',  'station_id',  'lat', 'lng')


bikedf_202010 <- read_csv("02_Data/DataRaw/202010-divvy-tripdata.csv")     
df202010_1 <- bikedf_202010 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202010_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202010_2 <- bikedf_202010 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202010_2) <- c('station_name',  'station_id',  'lat', 'lng')


bikedf_202011 <- read_csv("02_Data/DataRaw/202011-divvy-tripdata.csv")     
df202011_1 <- bikedf_202011 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202011_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202011_2 <- bikedf_202011 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202011_2) <- c('station_name',  'station_id',  'lat', 'lng')


bikedf_202012 <- read_csv("02_Data/DataRaw/202012-divvy-tripdata.csv")     
df202012_1 <- bikedf_202012 %>%
  distinct(end_station_name,  end_station_id, .keep_all = TRUE) %>%
  select(end_station_name,  end_station_id,  end_lat, end_lng) %>%
  drop_na()

colnames(df202012_1) <- c('station_name',  'station_id',  'lat', 'lng')

df202012_2 <- bikedf_202012 %>%
  distinct(start_station_name,  start_station_id, .keep_all = TRUE) %>%
  select(start_station_name,  start_station_id,  start_lat, start_lng) %>%
  drop_na()

colnames(df202012_2) <- c('station_name',  'station_id',  'lat', 'lng')

rm(df1)
rm(df2)
rm(df)

df1 <- rbind(df202006_1,df202007_1,df202008_1,df202009_1,df202010_1,df202011_1,
            df202012_1,df202101_1,df202102_1,df202103_1,df202104_1,df202105_1)
df2 <- rbind(df202006_2,df202007_2,df202008_2,df202009_2,df202010_2,df202011_2,
             df202012_2,df202101_2,df202102_2,df202103_2,df202104_2,df202105_2)

df1 <- df1 %>% distinct(station_name,  station_id, .keep_all = TRUE)
df2 <- df2 %>% distinct(station_name,  station_id, .keep_all = TRUE)

df1 <- df1 %>% distinct( station_name, .keep_all = TRUE)
df2 <- df2 %>% distinct( station_name, .keep_all = TRUE)

df <- rbind(df1,df2)

df <- df %>% distinct( station_name, .keep_all = TRUE)

rm(df1)
rm(df2)
df3 <- df
df2 <- df
df1 <- df
df0 <- df
df3$lat<- round(df$lat, 3)
df3$lng<- round(df$lng, 3)

df2$lat<- round(df$lat, 2)
df2$lng<- round(df$lng, 2)

df1$lat<- round(df$lat, 1)
df1$lng<- round(df$lng, 1)

df0$lat<- round(df$lat, 0)
df0$lng<- round(df$lng, 0)

df <- rbind(df, df3, df2, df1, df0)

write_csv(df, "02_Data/Preprocessed_1/trip_station.csv", append=FALSE)
bike202102 <- read_csv("02_Data/DataRaw/202102-divvy-tripdata.csv") 



bikedf_01_1 <- subset(bikedf_01,is.na(start_station_name))

colSums(is.na(bikedf_01)) 
colnames(bikedf_01) <- c('ride_id','rideable_type','started_at',
                         'ended_at','station_name','station_id',
                         'end_station_name','end_station_id','lat', 
                         'lng','end_lat', 'end_lng','member_casual')

new_dataset <- df2 %>% inner_join(bikedf_01_1, by=c("lat","lng"))
colSums(is.na(new_dataset)) 