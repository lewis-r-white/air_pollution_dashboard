


# UGANDA ---------------------------------------------------

# List to store results for each monitor
merged_data_list_uganda <- list()

# Iterate over unique monitor IDs
for (monitor_id in unique(timeseries_hourly_data_uganda_by_monitor$monitor)) {

  # Compute average observations for fleet (not including monitor of interest)
  averages <- timeseries_hourly_data_uganda_by_monitor %>%
    select(monitor, hourly_timestamp, pm1, pm10, pm25) %>% 
    filter(monitor != monitor_id) %>% 
    group_by(hourly_timestamp) %>%
    summarise(avg_obs_pm1 = mean(pm1, na.rm = TRUE),
              avg_obs_pm10 = mean(pm10, na.rm = TRUE),
              avg_obs_pm25 = mean(pm25, na.rm = TRUE))
  
  # Extract observations for the selected monitor
  monitor_obs <- timeseries_hourly_data_uganda_by_monitor %>%
    filter(monitor == monitor_id) %>% 
    select(hourly_timestamp, monitor, pm1, pm10, pm25)
  
  # Merge datasets
  merged_data <- left_join(averages, monitor_obs, by = "hourly_timestamp")
  
  # Add merged data to the list
  merged_data_list_uganda[[monitor_id]] <- merged_data
}

# Combine results from all monitors into a single dataset
final_merged_data_uganda <- do.call(rbind, merged_data_list_uganda) %>%
  pivot_longer(cols = -c(hourly_timestamp, monitor),
               names_to = "variable",
               values_to = "value") %>% 
  mutate(names_from = ifelse(grepl("^avg_obs", variable), "average", "individual")) %>%
  pivot_wider(names_from = names_from,
              values_from = value) %>% 
  mutate(variable = gsub("avg_obs_", "", variable)) %>% 
  group_by(hourly_timestamp, monitor, variable) %>%
  summarise(
    average = first(average[!is.na(average)]),
    individual = first(individual[!is.na(individual)])) %>%
  ungroup()

# KENYA ---------------------------------------------------

# List to store results for each monitor
merged_data_list_kenya <- list()

# Iterate over unique monitor IDs
for (monitor_id in unique(timeseries_hourly_data_kenya_by_monitor$monitor)) {
  
  # Compute average observations for fleet (not including monitor of interest)
  averages <- timeseries_hourly_data_kenya_by_monitor %>%
    select(monitor, hourly_timestamp, pm1, pm10, pm25) %>% 
    filter(monitor != monitor_id) %>% 
    group_by(hourly_timestamp) %>%
    summarise(avg_obs_pm1 = mean(pm1, na.rm = TRUE),
              avg_obs_pm10 = mean(pm10, na.rm = TRUE),
              avg_obs_pm25 = mean(pm25, na.rm = TRUE))
  
  # Extract observations for the selected monitor
  monitor_obs <- timeseries_hourly_data_kenya_by_monitor %>%
    filter(monitor == monitor_id) %>% 
    select(hourly_timestamp,  monitor, pm1, pm10, pm25)
  
  # Merge datasets
  merged_data <- left_join(averages, monitor_obs, by = "hourly_timestamp")
  
  # Add merged data to the list
  merged_data_list_kenya[[monitor_id]] <- merged_data
}

# Combine results from all monitors into a single dataset
final_merged_data_kenya <- do.call(rbind, merged_data_list_kenya) %>%
  pivot_longer(cols = -c(hourly_timestamp, monitor),
               names_to = "variable",
               values_to = "value") %>% 
  mutate(names_from = ifelse(grepl("^avg_obs", variable), "average", "individual")) %>%
  pivot_wider(names_from = names_from,
              values_from = value) %>% 
  mutate(variable = gsub("avg_obs_", "", variable)) %>% 
  group_by(hourly_timestamp, monitor, variable) %>%
  summarise(
    average = first(average[!is.na(average)]),
    individual = first(individual[!is.na(individual)])) %>%
  ungroup()


# ETHIOPIA ---------------------------------------------------

# List to store results for each monitor
merged_data_list_ethiopia <- list()

# Iterate over unique monitor IDs
for (monitor_id in unique(timeseries_hourly_data_ethiopia_by_monitor$monitor)) {
  
  # Compute average observations for fleet (not including monitor of interest)
  averages <- timeseries_hourly_data_ethiopia_by_monitor %>%
    select(monitor, hourly_timestamp, pm1, pm10, pm25) %>% 
    filter(monitor != monitor_id) %>% 
    group_by(hourly_timestamp) %>%
    summarise(avg_obs_pm1 = mean(pm1, na.rm = TRUE),
              avg_obs_pm10 = mean(pm10, na.rm = TRUE),
              avg_obs_pm25 = mean(pm25, na.rm = TRUE))
  
  # Extract observations for the selected monitor
  monitor_obs <- timeseries_hourly_data_ethiopia_by_monitor %>%
    filter(monitor == monitor_id) %>% 
    select(hourly_timestamp,  monitor, pm1, pm10, pm25)
  
  # Merge datasets
  merged_data <- left_join(averages, monitor_obs, by = "hourly_timestamp")
  
  # Add merged data to the list
  merged_data_list_ethiopia[[monitor_id]] <- merged_data
}

# Combine results from all monitors into a single dataset
final_merged_data_ethiopia <- do.call(rbind, merged_data_list_ethiopia) %>%
  pivot_longer(cols = -c(hourly_timestamp, monitor),
               names_to = "variable",
               values_to = "value") %>% 
  mutate(names_from = ifelse(grepl("^avg_obs", variable), "average", "individual")) %>%
  pivot_wider(names_from = names_from,
              values_from = value) %>% 
  mutate(variable = gsub("avg_obs_", "", variable)) %>% 
  group_by(hourly_timestamp, monitor, variable) %>%
  summarise(
    average = first(average[!is.na(average)]),
    individual = first(individual[!is.na(individual)])) %>%
  ungroup()

# GHANA ---------------------------------------------------

# List to store results for each monitor
merged_data_list_ghana <- list()

# Iterate over unique monitor IDs
for (monitor_id in unique(timeseries_hourly_data_ghana_by_monitor$monitor)) {
  
  # Compute average observations for fleet (not including monitor of interest)
  averages <- timeseries_hourly_data_ghana_by_monitor %>%
    select(monitor, hourly_timestamp, pm1, pm10, pm25) %>% 
    filter(monitor != monitor_id) %>% 
    group_by(hourly_timestamp) %>%
    summarise(avg_obs_pm1 = mean(pm1, na.rm = TRUE),
              avg_obs_pm10 = mean(pm10, na.rm = TRUE),
              avg_obs_pm25 = mean(pm25, na.rm = TRUE))
  
  # Extract observations for the selected monitor
  monitor_obs <- timeseries_hourly_data_ghana_by_monitor %>%
    filter(monitor == monitor_id) %>% 
    select(hourly_timestamp,  monitor, pm1, pm10, pm25)
  
  # Merge datasets
  merged_data <- left_join(averages, monitor_obs, by = "hourly_timestamp")
  
  # Add merged data to the list
  merged_data_list_ghana[[monitor_id]] <- merged_data
}

# Combine results from all monitors into a single dataset
final_merged_data_ghana <- do.call(rbind, merged_data_list_ghana) %>%
  pivot_longer(cols = -c(hourly_timestamp, monitor),
               names_to = "variable",
               values_to = "value") %>% 
  mutate(names_from = ifelse(grepl("^avg_obs", variable), "average", "individual")) %>%
  pivot_wider(names_from = names_from,
              values_from = value) %>% 
  mutate(variable = gsub("avg_obs_", "", variable)) %>% 
  group_by(hourly_timestamp, monitor, variable) %>%
  summarise(
    average = first(average[!is.na(average)]),
    individual = first(individual[!is.na(individual)])) %>%
  ungroup()



# MERGE DATA ---------------------------------------------------------


# Combine data: Read data for each country and combine them while adding a 'country' column
ind_avg_monitor_comparison <- bind_rows(
  final_merged_data_uganda %>% mutate(country = "Uganda"),
  final_merged_data_kenya %>% mutate(country = "Kenya"),
  final_merged_data_ethiopia %>% mutate(country = "Ethiopia"),
  final_merged_data_ghana %>% mutate(country = "Ghana")
)

# Set the working directory to the directory where you want to write the CSV file
#setwd("/Users/sanneglastra/Desktop/africa air pollution research/shiny/time-series-app")

# Export merged data to a new CSV file in data file
# write.csv(ind_avg_monitor_comparison, "data/ind_avg_monitor_comparison_202404.csv", row.names = FALSE)




  
  
