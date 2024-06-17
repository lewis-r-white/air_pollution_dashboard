

# consider turning this into a function and placing it into functions file

# timeseries hourly gas modulair data - uganda
timeseries_hourly_data_uganda <- uganda_df %>%
  filter(monitor=="MOD-00117") %>% 
  mutate(hourly_timestamp = floor_date(local_timestamp, "hour")) %>% 
  group_by(hourly_timestamp) %>%
  summarise_at(c("pm1", "pm10","pm25", "co","no", "no2","o3"), mean, na.rm = TRUE) 

# timeseries hourly gas modulair data - kenya
timeseries_hourly_data_kenya <- kenya_df %>%
  filter(monitor=="MOD-00116") %>% 
  mutate(hourly_timestamp = floor_date(local_timestamp, "hour")) %>% 
  group_by(hourly_timestamp) %>%
  summarise_at(c("pm1", "pm10","pm25", "co","no", "no2","o3"), mean, na.rm = TRUE) 

 # timeseries hourly gas modulair data - ethiopia
timeseries_hourly_data_ethiopia <- ethiopia_df %>%
  filter(monitor=="MOD-00118") %>%
  mutate(hourly_timestamp = floor_date(local_timestamp, "hour")) %>%
  group_by(hourly_timestamp) %>%
  summarise(across(c("pm1", "pm10", "pm25", "no", "no2", "o3"), ~mean(., na.rm = TRUE)))

 # timeseries hourly gas modulair data - ghana
timeseries_hourly_data_ghana <- ghana_df %>%
  filter(monitor %in% c("MOD-00398","MOD-00401","MOD-00400","MOD-00399","MOD-00397")) %>%
  mutate(hourly_timestamp = floor_date(local_timestamp, "hour")) %>%
  group_by(hourly_timestamp) %>%
  summarise_at(c("pm1", "pm10","pm25", "co","no", "no2","o3"), mean, na.rm = TRUE)


# MERGE DATA ---------------------------------------------------------


# Combine data: Read data for each country and combine them while adding a 'country' column
timeseries_hourly <- bind_rows(
  timeseries_hourly_data_uganda %>% mutate(country = "Uganda"),
  timeseries_hourly_data_kenya %>% mutate(country = "Kenya"),
  timeseries_hourly_data_ethiopia %>% mutate(country = "Ethiopia"),
  timeseries_hourly_data_ghana %>% mutate(country = "Ghana")
)

# Set the working directory to the directory where you want to write the CSV file
#setwd("/Users/sanneglastra/Desktop/africa air pollution research/shiny/time-series-app")

# Export merged data to a new CSV file in data file
# write.csv(timeseries_hourly, "data/timeseries_hourly_202404.csv", row.names = FALSE)

