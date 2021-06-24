library("tidyverse")
library("readr")
library("dplyr")
library("ggplot2")
library(psych)
library(lubridate)
library(openxlsx)
library(geosphere)

#Loading latest 12 month of data only

###########CHANGE ME##########
setwd("D:/MyDataProjects/Divvy_bikesharing")

datafolder = "02_Data/DataRaw"
processedfolder = "02_Data/Preprocessed_1"
processedfolder2 = "02_Data/Preprocessed_2"
file_names = list.files(datafolder,pattern = "*.csv")
bikedfs <- list()
cl_bikedfs<- list()
for ( i in seq_along(file_names)){
  bikedfs[[i]] <- read_csv(file.path(datafolder,file_names[i]))

  colnames(bikedfs[[i]])
  colSums(is.na(bikedfs[[i]])) 
  
  cl_bikedfs[[i]] <- drop_na(bikedfs[[i]])
  colSums(is.na(cl_bikedfs[[i]]))
  
  cl_bikedfs[[i]] <- cl_bikedfs[[i]] %>% 
    mutate(Weekday = weekdays(as.Date(started_at)))
  
  cl_bikedfs[[i]] <- cl_bikedfs[[i]] %>% 
    mutate(month = months(as.Date(started_at)))
  
  cl_bikedfs[[i]] <- cl_bikedfs[[i]] %>% 
    mutate(dayofmonth = day(as.Date(started_at)))
  
  cl_bikedfs[[i]] <- cl_bikedfs[[i]] %>% 
    mutate(Pickup_date = as.Date(started_at))
  
  cl_bikedfs[[i]] <- cl_bikedfs[[i]] %>% 
    mutate(pickup_time = format(started_at, format = "%H:%M:%S"))
  
  intv <- interval(cl_bikedfs[[i]]$started_at, cl_bikedfs[[i]]$ended_at)
  
  cl_bikedfs[[i]] <- cl_bikedfs[[i]] %>% 
    mutate(ride_duration = trunc(time_length(intv, "minutes")))
  
  cl_bikedfs[[i]] <- cl_bikedfs[[i]] %>% 
    mutate(ride_distance = as.integer(distHaversine(cl_bikedfs[[i]][,9:10], cl_bikedfs[[i]][,11:12])))
  
  cl_bikedfs[[i]] <- cl_bikedfs[[i]] %>% 
    select(-ride_id, -end_station_id,-start_station_id)
  
  write_csv(cl_bikedfs[[i]], file.path(processedfolder,paste ("cl_",file_names[[i]])), append=FALSE)
  
  #cl_bike_master <- rbind(cl_bike_master,cl_bikedfs[[i]])
  # write.xlsx(
  #   cl_bikedfs[[i]],
  #   file =  file.path(processedfolder,paste (trimws(paste("cl_",file_names[[i]])),".xlsx")),
  #   colNames = TRUE, overwrite =TRUE
  # )
}




   