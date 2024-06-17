

server_fleet_correlation_tab <- function(input, output, session, filtered_timeseries_hourly_data_by_monitor) {
  
  # DEFINE REACTIVE EXPRESSIONS
  selected_fleet_data <- reactive({
    filtered_fleet <- filtered_timeseries_hourly_data_by_monitor()
    switch(input$fleet_country,
           "Uganda" = filtered_fleet %>% filter(country == "Uganda"),
           "Kenya" = filtered_fleet %>% filter(country == "Kenya"),
           "Ethiopia" = filtered_fleet %>% filter(country == "Ethiopia"),
           "Ghana" = filtered_fleet %>% filter(country == "Ghana")
    )
  })
  
  # PLOT OUTPUT
  output$fleetCorrelationPlot <- renderPlot({
    data <- selected_fleet_data()
    selected_params <- c(input$x_parameter_fleet, input$y_parameter_fleet)
    
    # Check if any of the selected parameters include "co", "no", "no2", or "o3"
    if (any(selected_params %in% c("co", "no", "no2", "o3"))) {
      # If yes, filter out monitors with "-PM-" in their names
      data <- data[!grepl("-PM-", data$monitor), ]
    }
    
    # Define a function to create correlation plots
    correlation_plots <- lapply(unique(data$monitor), function(monitor_id) {
      monitor_data <- data[data$monitor == monitor_id, ]
      ggplot(data = monitor_data, aes_string(x = input$x_parameter_fleet, y = input$y_parameter_fleet)) +
        geom_point() +
        labs(title = paste("Monitor:", monitor_id),
             x = input$x_parameter_fleet, y = input$y_parameter_fleet) +
        theme_minimal()
    })
    
    # Set number of columns based on the number of plots
    if(length(correlation_plots) > 15) {
      num_cols <- 4
    } else if(length(correlation_plots) > 10) {
      num_cols <- 3
    } else if(length(correlation_plots) > 1) {
      num_cols <- 2
    } else {
      num_cols <- 1
    }
    
    # If only one plot, set full width; otherwise, set specified number of columns
    gridExtra::grid.arrange(grobs = correlation_plots, ncol = num_cols)
  })
  
}