


# source modules
source("modules/ui-timeseries-tab.R")
source("modules/ui-correlation-tab.R")
source("modules/ui-fleet-correlation-tab.R")
source("modules/ui-monitor-comparison-tab.R")
source("modules/ui-bar-tab.R")


# Define UI for application
ui <- fluidPage(
  titlePanel("Air Pollution Dashboard"),
  
  selectInput("month", "Select Month", choices = c("January 2024" = "202401", 
                                                   "February 2024" = "202402", 
                                                   "March 2024" = "202403", 
                                                   "April 2024" = "202404")),
  
  
  # Date slider input for selecting the date range
  uiOutput("date_slider"),  # Define date slider dynamically
  
  
  tags$p("Note: All data is in summarized into hourly format."),
  tags$p("Note: Ghana data is a summary of the 5 modulair gas sensors. Ethiopia does not have CO values."),
  

  navbarPage(
      "",
      ui_timeseries_tab(),
      ui_correlation_tab(),
      ui_fleet_correlation_tab(),
      ui_monitor_comparison_tab(),
      ui_bar_tab()
      
    )
)