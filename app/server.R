#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
# Load required libraries
library(shiny)
library(dplyr)
library(lubridate) 
library(tidyverse)
library(RColorBrewer)

# source modules
source("modules/server-timeseries-tab.R")
source("modules/server-correlation-tab.R")
source("modules/server-fleet-correlation-tab.R")
source("modules/server-monitor-comparison-tab.R")
source("modules/server-bar-tab.R")

# Define server logic
server <- function(input, output, session) {
  

# DYNAMIC MONTH ---------------------------------------
  
  # Reactive expression to get the file paths based on the selected month
  csv_file_paths <- reactive({
    month <- input$month
    list(
      ind_avg_monitor_comparison = paste0("data/ind_avg_monitor_comparison_", month, ".csv"),
      timeseries_hourly_data_by_monitor = paste0("data/timeseries_hourly_data_by_monitor_", month, ".csv"),
      timeseries_hourly = paste0("data/timeseries_hourly_", month, ".csv")
    )
  })
  
  # Reactive expression to read the data based on the selected month
  ind_avg_monitor_comparison <- reactive({
    read.csv(csv_file_paths()$ind_avg_monitor_comparison)
  })
  
  timeseries_hourly_data_by_monitor <- reactive({
    read.csv(csv_file_paths()$timeseries_hourly_data_by_monitor) %>% 
      mutate(hourly_timestamp = as.POSIXct(hourly_timestamp, format = "%Y-%m-%d %H:%M:%S"))
  })
  
  timeseries_hourly <- reactive({
    read.csv(csv_file_paths()$timeseries_hourly) %>%
      mutate(hourly_timestamp = as.POSIXct(hourly_timestamp, format = "%Y-%m-%d %H:%M:%S"))
  })
  

  
# DYNAMIC SLIDER DATE RANGE  --------------------------------------------------
  
  # Define min and max date as reactive expressions
  min_date <- reactive({
    min(timeseries_hourly()$hourly_timestamp, na.rm = TRUE)
  })
  
  max_date <- reactive({
    max(timeseries_hourly()$hourly_timestamp, na.rm = TRUE)
  })
  
  # Generate date slider UI dynamically
  output$date_slider <- renderUI({
    sliderInput("date_range", "Select Date Range:",
                min = min_date(), max = max_date(),  # Use min_date and max_date here
                value = c(min_date(), max_date()),  # Use min_date and max_date here
                step = 1,
                timeFormat = "%Y-%m-%d",
                ticks = FALSE)
  })
  
  # Filter the data based on the selected date range
  filtered_timeseries_hourly_data_by_monitor <- reactive({
    timeseries_hourly_data_by_monitor() %>%
      filter(hourly_timestamp >= input$date_range[1] & hourly_timestamp <= input$date_range[2])
  })
  
  filtered_timeseries_hourly <- reactive({
    timeseries_hourly() %>%
      filter(hourly_timestamp >= input$date_range[1] & hourly_timestamp <= input$date_range[2])
  })
  
  filtered_ind_avg_monitor_comparison <- reactive({
    ind_avg_monitor_comparison() %>%
      filter(hourly_timestamp >= input$date_range[1] & hourly_timestamp <= input$date_range[2])
  })
  
# TABS ------------------------------------------------------------
  
  server_timeseries_tab(input, output, session, filtered_timeseries_hourly)
  server_correlation_tab(input, output, session, filtered_timeseries_hourly)
  server_fleet_correlation_tab(input, output, session, filtered_timeseries_hourly_data_by_monitor)
  server_monitor_comparison_tab(input, output, session, filtered_ind_avg_monitor_comparison)
  server_bar_tab(input, output, session, filtered_timeseries_hourly_data_by_monitor)
 
}
  
