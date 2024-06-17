



# -------------------------------- UGANDA ------------------------------------------------------------

### create lists of devices by country 
uganda_devices <- c("MOD-PM-00844", "MOD-PM-00847", "MOD-PM-00831", "MOD-PM-00846", "MOD-PM-00832",
                    "MOD-PM-00845", "MOD-PM-00828", "MOD-PM-00826", "MOD-PM-00838", "MOD-00117",
                    "MOD-PM-00836")

# set the timezone for east africa
Sys.setenv(TZ = 'Africa/Kampala') #EAT for kenya, uganda, ethiopia 

country = "Uganda" #for adding country row to final table

# List of device serial numbers
device_list <- uganda_devices

# Initialize an empty list to store results for each device
result_combined <- list()

# Loop through each device in the device list
for (device in device_list) {
  # Function to get data by date, handling errors
  get_data_safe <- possibly(get_data_by_date, otherwise = NULL)
  
  # Use map to get data for each date, handling errors
  result_list <- map(seq(start_date, end_date, by = "days"), function(date) {
    formatted_date <- format(date, "%Y-%m-%d")
    get_data_safe(sn = device, date = formatted_date)
  })
  
  # Filter out NULL elements (empty lists)
  result_list <- purrr::discard(result_list, ~ is.null(.x) || length(.x) == 0)
  
  if (!is_empty(result_list)) {
    # Combine the list of data frames into a single data frame
    result_df <- do.call(bind_rows, lapply(result_list, as.data.frame)) %>%
      mutate(monitor = device) %>%
      select(monitor, everything()) %>%
      mutate(timestamp = as.POSIXct(timestamp)) %>% 
      mutate(timestamp = format(timestamp, "%Y-%m-%d %H:%M")) %>% 
      mutate(timestamp = lubridate::ymd_hm(timestamp)) %>%
      mutate(local_timestamp = timestamp + hours(3)) #time stamp is in GMT, so adding 3 hours to match EAT. 
    
    minutely_df <- data.frame(timestamp = seq.POSIXt(
      as.POSIXct(start_date, tz = "UTC"),
      as.POSIXct(end_date + 1, tz = "UTC"),
      by = "min"
    )) %>%
      mutate(local_timestamp = timestamp + hours(3))
    
    result_df_full <- full_join(result_df, minutely_df) %>% 
      arrange(timestamp) %>%
      mutate(date = as.Date(local_timestamp)) %>%  
      mutate(hour = hour(ymd_hms(local_timestamp))) %>%
      mutate(monitor = device) %>%
      select(monitor, timestamp, local_timestamp, date, hour, everything()) 
    
    # Store the result for the current device in the combined list
    result_combined[[device]] <- result_df_full
  } else {
    # If there's no data for this device, create an empty dataframe
    minutely_df_empty <- data.frame(timestamp = seq.POSIXt(
      as.POSIXct(start_date, tz = "UTC"),
      as.POSIXct(end_date + 1, tz = "UTC"),
      by = "min"
    )) %>%
      mutate(local_timestamp = timestamp + hours(3))
    
    minutely_df_empty <- minutely_df_empty %>% mutate(date = as.Date(local_timestamp)) %>%  
      mutate(hour = hour(ymd_hms(local_timestamp))) %>%
      mutate(monitor = device) %>%
      select(monitor, timestamp, local_timestamp, date, hour) 
    
    result_combined[[device]] <- minutely_df_empty
  }
}

# Combine data for all devices into a single data frame
final_result_df <- bind_rows(result_combined)

# Store data into specific dataset for uganda
uganda_df <- final_result_df

