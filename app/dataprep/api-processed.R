

### load packages 
library(QuantAQAPIClient)
library(here) 
library(lubridate) 
library(tictoc)
library(DT)
library(purrr)
library(tidyverse)

### Connect to QuantAQ API (necessary to obtain data)
setup_client() #log in to QuantAQ account and click developer in the left menu to grab API key

### Define start_date and end_date for a particular month
start_date <- as.Date("2024-03-01") # DUE TO TIMEZONES, START DATE NEEDS TO BE 1 DAY BEFORE THE ACTUAL START DATE OF INTEREST
end_date <- as.Date("2024-03-31")

### Source all country data import files
source("dataprep/dataimport/api-processed-uganda.R")
source("dataprep/dataimport/api-processed-kenya.R")
source("dataprep/dataimport/api-processed-ethiopia.R")
source("dataprep/dataimport/api-processed-ghana.R")

### Source all data processing files
source("dataprep/dataprocess/timeseries-data-prep.R")
source("dataprep/dataprocess/timeseries-bymonitor-data-prep.R")
source("dataprep/dataprocess/ind-fleet-monitor-avg-data-prep.R")



# Set the working directory to the directory where you want to write the CSV file
# setwd("/Users/sanneglastra/Desktop/africa air pollution research/shiny/time-series-app")

# export data into csv files for that month
# NOTE: CHANGE THE NAME OF THE CSV FILE BASED ON THE MONTH OF INTEREST. FOR EXAMPLE, IF DOWNLOADING DATA FOR MAY, 
# CHANGE CODE TO 202405 (INSTEAD OF 202403) ON CSV FILE NAME
write.csv(ind_avg_monitor_comparison, "data/ind_avg_monitor_comparison_202403.csv", row.names = FALSE)
write.csv(timeseries_hourly_data_by_monitor, "data/timeseries_hourly_data_by_monitor_202403.csv", row.names = FALSE)
write.csv(timeseries_hourly, "data/timeseries_hourly_202403.csv", row.names = FALSE)



