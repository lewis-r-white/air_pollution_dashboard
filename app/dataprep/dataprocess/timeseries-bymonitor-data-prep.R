

# consider turning this into a function and placing it into functions file

# timeseries hourly gas modulair data by monitor - uganda
timeseries_hourly_data_uganda_by_monitor <- uganda_df %>%
  mutate(hourly_timestamp = floor_date(local_timestamp, "hour")) %>% 
  group_by(monitor, hourly_timestamp) %>%
  summarise(across(c("pm1", "pm10","pm25", "co","no", "no2","o3"), ~mean(., na.rm = TRUE))) %>%
  ungroup()

# timeseries hourly gas modulair data by monitor - kenya
timeseries_hourly_data_kenya_by_monitor <- kenya_df %>%
  mutate(hourly_timestamp = floor_date(local_timestamp, "hour")) %>% 
  group_by(monitor, hourly_timestamp) %>%
  summarise(across(c("pm1", "pm10","pm25", "co","no", "no2","o3"), ~mean(., na.rm = TRUE))) %>%
  ungroup()

# timeseries hourly gas modulair data by monitor - ethiopia
timeseries_hourly_data_ethiopia_by_monitor <- ethiopia_df %>%
  mutate(hourly_timestamp = floor_date(local_timestamp, "hour")) %>% 
  group_by(monitor, hourly_timestamp) %>%
  summarise(across(c("pm1", "pm10","pm25","no", "no2","o3"), ~mean(., na.rm = TRUE))) %>%
  ungroup()

# timeseries hourly gas modulair data by monitor- ghana
timeseries_hourly_data_ghana_by_monitor <- ghana_df %>%
  mutate(hourly_timestamp = floor_date(local_timestamp, "hour")) %>% 
  group_by(monitor, hourly_timestamp) %>%
  summarise(across(c("pm1", "pm10","pm25", "co","no", "no2","o3"), ~mean(., na.rm = TRUE))) %>%
  ungroup() 



# MERGE DATA ---------------------------------------------------------


# Combine data: Read data for each country and combine them while adding a 'country' column
timeseries_hourly_data_by_monitor <- bind_rows(
  timeseries_hourly_data_uganda_by_monitor %>% mutate(country = "Uganda"),
  timeseries_hourly_data_kenya_by_monitor %>% mutate(country = "Kenya"),
  timeseries_hourly_data_ethiopia_by_monitor %>% mutate(country = "Ethiopia"),
  timeseries_hourly_data_ghana_by_monitor %>% mutate(country = "Ghana")
)

# Set the working directory to the directory where you want to write the CSV file
# setwd("/Users/sanneglastra/Desktop/africa air pollution research/shiny/time-series-app")

# Export merged data to a new CSV file in data file
# write.csv(timeseries_hourly_data_by_monitor, "data/timeseries_hourly_data_by_monitor_202404.csv", row.names = FALSE)





