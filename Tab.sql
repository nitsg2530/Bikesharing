drop table if exists "tripstations";
    CREATE TABLE "tripstations"
    (
        
        station_name varchar, 
        station_id varchar,
        lat DOUBLE PRECISION,
        lng DOUBLE PRECISION
	);
	COPY 
	"tripstations"(station_name,station_id, lat, lng)
    FROM 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\trip_station.csv' DELIMITER ',' CSV HEADER;
	

select count(*) from "tripstations"

drop table if exists "biketrip";
create table "biketrip"
(
	rideable_type varchar,
	started_at TIMESTAMP ,
	ended_at TIMESTAMP ,
	start_station_name varchar, 
	end_station_name varchar,
	start_lat DOUBLE PRECISION,
	start_lng DOUBLE PRECISION,
	end_lat DOUBLE PRECISION,
	end_lng DOUBLE PRECISION,
	member_casual varchar,
	Weekday varchar,
	month varchar, 
	dayofmonth int,
	pickup_date Date,
	pickup_time time,
	ride_duration int,
	ride_distance int
);
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202006-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202007-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202008-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202009-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202010-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202011-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202012-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202101-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202102-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202103-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202104-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
copy 
	"biketrip"(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual, Weekday, month, dayofmonth, pickup_date, pickup_time, ride_duration, ride_distance)
from 'D:\MyDataProjects\Divvy_bikesharing\02_Data\Preprocessed_1\cl_ 202105-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
select distinct(month) from "biketrip" ;
select distinct(start_station_name) from "biketrip"; 

	
	
		select distinct(month) from "biketrip" ;

-- RIDE counts in weekdays
SELECT  weekday as "Weekday", member_casual as "Membership", COUNT(*) as Trips
FROM "biketrip"
GROUP BY weekday, member_casual
order by 
	CASE
          WHEN weekday = 'Monday' THEN 2
          WHEN weekday = 'Tuesday' THEN 3
          WHEN weekday = 'Wednesday' THEN 4
          WHEN weekday = 'Thursday' THEN 5
          WHEN weekday = 'Friday' THEN 6
          WHEN weekday = 'Saturday' THEN 7
		  WHEN weekday = 'Sunday' THEN 8
     END ASC
	 
-- RIDE Duration in weekdays	 
SELECT  weekday as "Weekday", member_casual as "Membership",  CAST(AVG(ABS(ride_duration)) as INTEGER) as "Average trip duration"
FROM "biketrip"
GROUP BY weekday, member_casual
order by 
	CASE
          WHEN weekday = 'Monday' THEN 2
          WHEN weekday = 'Tuesday' THEN 3
          WHEN weekday = 'Wednesday' THEN 4
          WHEN weekday = 'Thursday' THEN 5
          WHEN weekday = 'Friday' THEN 6
          WHEN weekday = 'Saturday' THEN 7
		  WHEN weekday = 'Sunday' THEN 8
     END ASC
	 
-- RIDE Distance in weekdays
SELECT  weekday as "Weekday", member_casual as "Membership", CAST(AVG(ABS(ride_distance)) as INTEGER) as "Average trip distance"
FROM "biketrip"
GROUP BY weekday, member_casual
order by 
	CASE
          WHEN weekday = 'Monday' THEN 2
          WHEN weekday = 'Tuesday' THEN 3
          WHEN weekday = 'Wednesday' THEN 4
          WHEN weekday = 'Thursday' THEN 5
          WHEN weekday = 'Friday' THEN 6
          WHEN weekday = 'Saturday' THEN 7
		  WHEN weekday = 'Sunday' THEN 8
     END ASC