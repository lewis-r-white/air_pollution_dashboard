

server_timeseries_tab <- function(input, output, session, filtered_timeseries_hourly) {
  # DEFINE REACTIVE EXPRESSIONS
  selected_timeseries_data <- reactive({
    filtered_timeseries <- filtered_timeseries_hourly()
    switch(input$timeseries_country,
           "Uganda" = filtered_timeseries %>% filter(country == "Uganda"),
           "Kenya" = filtered_timeseries %>% filter(country == "Kenya"),
           "Ethiopia" = filtered_timeseries %>% filter(country == "Ethiopia"),
           "Ghana" = filtered_timeseries %>% filter(country == "Ghana")
    )
  })
  
  #  TIMESERIES OUTPUT
  output$timeSeriesPlot <- renderPlot({
    data <- selected_timeseries_data()
    selected_parameters <- input$parameters
    
    # Define a color palette (using magma from viridisLite)
    color_palette <- brewer.pal(length(selected_parameters), "Dark2")
    
    # Plotting
    p <- ggplot(data, aes(x = hourly_timestamp)) +
      theme_minimal()
    
    # Add selected parameters to the plot
    for (param in selected_parameters) {
      p <- p + geom_line(aes_string(y = param), color = sample(color_palette, 1), linetype = "solid") +
        labs(y = "Value")
    }
    
    p +
      scale_y_continuous(limits = c(0, NA)) +  # Ensure y-axis starts from 0
      labs(x = "Time", title = paste("Air Pollution Parameters -", input$timeseries_country)) +
      theme(axis.title = element_text(size = 14, face = "bold"),   # Set axis title size
            axis.text = element_text(size = 12),    # Set axis label size
            plot.title = element_text(size = 16, face = "bold")) # Set plot title size 
  })
  
}

