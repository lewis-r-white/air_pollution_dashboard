


server_bar_tab <- function(input, output, session, filtered_timeseries_hourly_data_by_monitor) {
  
  # DEFINE REACTIVE EXPRESSIONS
  selected_completeness_data <- reactive({
    filtered_bar_data <- filtered_timeseries_hourly_data_by_monitor()
    switch(input$completeness_country,
           "Uganda" = filtered_bar_data %>% filter(country == "Uganda"),
           "Kenya" = filtered_bar_data %>% filter(country == "Kenya"),
           "Ethiopia" = filtered_bar_data %>% filter(country == "Ethiopia"),
           "Ghana" = filtered_bar_data %>% filter(country == "Ghana")
    )
  })
  
  output$bar_chart <- renderPlot({
    # Filter data for the selected parameter and last 7 days
    parameter_data <- selected_completeness_data()
    
    # Calculate the range for the last 7 days
    last_7_days_start <- input$date_range[1]
    last_7_days_end <- input$date_range[2]
    
    # Generate sequence of hourly timestamps for the last 7 days
    hourly_timestamps <- seq(from = last_7_days_start, to = last_7_days_end, by = "hour")
    
    # Calculate completeness for each monitor
    completeness <- parameter_data %>%
      group_by(monitor) %>%
      summarise(
        total_expected_points = length(hourly_timestamps),
        actual_points = total_expected_points - sum(is.na(.data[[input$parameter]])),
        completeness = actual_points / total_expected_points * 100
      )
    
    # Create bar chart
    ggplot(data = completeness, aes(x = monitor, y = completeness)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      geom_hline(yintercept = input$threshold, linetype = "dashed", color = "red") +
      labs(title = paste("Completeness for", input$parameter, "in", input$completeness_country),
           x = "Monitor", y = "Completeness (%)") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })

  
}
  