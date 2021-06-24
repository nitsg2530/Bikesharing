install.packages('RPostgreSQL')
library('RPostgreSQL')

install.packages('devtools')

install.packages('remotes')

remotes::install_github("r-dbi/RPostgres")

install.packages('RPostgres')


install.packages("ggplot2")
#devtools::install_github("tidyverse/ggplot2")
library( ggplot2)
#con<-dbConnect(RPostgres::Postgres())

library(DBI)
library(dplyr)

db <- 'postgres'  #provide the name of your db

host_db <- 'localhost' #i.e. # i.e. 'ec2-54-83-201-96.compute-1.amazonaws.com'  

db_port <- '5432'  # or any other port specified by the DBA

db_user <- 'postgres'  

db_password <- '12345'

con <- dbConnect(RPostgres::Postgres(), dbname = db, host=host_db, port=db_port, user=db_user, password=db_password ) 


all_trips <- dbGetQuery(con, 'SELECT * FROM "biketrip"  ')
# aggregate(all_trips$ride_duration ~ all_trips$member_casual, FUN = mean)
# aggregate(all_trips$ride_duration ~ all_trips$member_casual, FUN = median)
# aggregate(all_trips$ride_duration ~ all_trips$member_casual, FUN = max)
# aggregate(all_trips$ride_duration ~ all_trips$member_casual, FUN = min)
# 
# aggregate(all_trips$ride_duration ~ all_trips$member_casual + all_trips$weekday, FUN = mean)
# 
# all_trips$weekday <- ordered(all_trips$weekday, levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday","Sunday"))

counts <- aggregate(all_trips$ride_duration ~ all_trips$member_casual + all_trips$weekday, FUN = mean)


ggplot(all_trips, aes(x=weekday , y=as.integer(abs(ride_duration)), group =member_casual, colour = member_casual)) + 
  geom_jitter()+
  ylab("Pickup duration")+
  labs(title = "Bike pickup duration pattern on weekdays", subtitle = "Casual vs Member", 
       caption = "Data collected from Divvy")


dm <- dbGetQuery(con, 'SELECT  weekday as "Weekday", member_casual as "Membership", COUNT(*) as Trips,  
CAST((COUNT(*) / CAST( SUM(count(*)) over (partition by Weekday) as float))*100 as INTEGER ) as trip_percent

FROM "biketrip" GROUP BY "weekday", "member_casual" ')



dm$Weekday <- ordered(dm$Weekday, levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday","Sunday" ))

dm %>%
arrange(Membership, Weekday) %>% 
ggplot( aes(x= Weekday, y=as.integer(trips), group =Membership, colour = Membership)) + 
  geom_point() +
  geom_line() +
  labs(title = "Number of rides on a Weekdays", subtitle = "Casual vs Member", 
       caption = "Data collected from Divvy")

dm %>%
  arrange(Membership, Weekday) %>% 
ggplot(aes(x= Weekday, y=as.integer(trip_percent), group =Membership, colour = Membership)) + 
  geom_point() +
  geom_line() +
  labs(title = "Percentage share of rides on a Weekdays", subtitle = "Casual vs Member", 
       caption = "Data collected from Divvy")



dm2 <- dbGetQuery(con, 'SELECT  weekday as "Weekday", member_casual as "Membership", CAST(AVG(ABS(ride_duration)) as INTEGER) as "duration"
FROM "biketrip" GROUP BY "weekday", "member_casual" ')
dm2$Weekday <- ordered(dm2$Weekday, levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday","Sunday" ))

dm2 %>%
  arrange(Membership, Weekday) %>% 
  ggplot(aes(x= Weekday, y=duration, group =Membership, colour = Membership)) + 
    geom_point() +
    geom_line() +
    labs(title = "Duration rides on a Weekdays", subtitle = "Casual vs Member", 
       caption = "Data collected from Divvy")


dm3 <- dbGetQuery(con, 'SELECT  weekday as "Weekday", member_casual as "Membership", CAST(AVG(ABS(ride_distance)) as INTEGER) as "Distance"
FROM "biketrip" GROUP BY "weekday", "member_casual" ')
dm3$Weekday <- ordered(dm3$Weekday, levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday","Sunday" ))

dm3 %>%
  arrange(Membership, Weekday) %>% 

ggplot( aes(x= Weekday, y=Distance, group =Membership, colour = Membership)) + 
  geom_point() +
  geom_line() +
  labs(title = "Distance between pickup and drop off bike stations", subtitle = "Casual vs Member", 
       caption = "Data collected from Divvy")

dm4 <- dbGetQuery(con, 'SELECT  dayofmonth, member_casual as "Membership", COUNT(*) as Trips
FROM "biketrip" GROUP BY dayofmonth, "member_casual" ')

dm4 %>%
ggplot(aes(x= dayofmonth, y=as.integer(trips), group =Membership, colour = Membership)) + 
  geom_point() +
  geom_line() +
  labs(title = "Bike pickup pattern on day of month", subtitle = "Casual vs Member", 
       caption = "Data collected from Divvy")


dm5 <- dbGetQuery(con, 'SELECT  rideable_type, member_casual as "Membership", COUNT(*) as Trips
FROM "biketrip" GROUP BY rideable_type, "member_casual" ')

dm5 %>%
ggplot( aes(x= rideable_type, y=as.integer(trips), group =Membership, colour = Membership)) + 
  geom_point() +
  geom_line() +
  labs(title = "Bike pickup pattern on type of bikes taken", subtitle = "Casual vs Member", 
       caption = "Data collected from Divvy")



dm6 <- dbGetQuery(con, 'SELECT  * FROM "biketrip" ')


dm6 %>% 
  ggplot(mapping = aes(x = pickup_date, fill = member_casual))+
  geom_bar()+
  facet_grid(~member_casual)+
  labs(title = "A time series for the number of rides for 12 months", subtitle = "Casual vs Member", 
       caption = "Data collected from Divvy")
dm6 %>% 
  ggplot(mapping = aes(x = pickup_time,  fill = member_casual))+
  geom_bar()+
  facet_grid(~member_casual)+
  labs(title = "A time series for the number of rides for 24 hrs", subtitle = "Casual vs Member", 
       caption = "Data collected from Divvy")


