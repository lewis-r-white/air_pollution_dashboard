



server_correlation_tab <- function(input, output, session, filtered_timeseries_hourly) {
  
  # DEFINE REACTIVE EXPRESSIONS
  selected_scatter_data <- reactive({
    filtered_scatter <- filtered_timeseries_hourly()
    switch(input$scatter_country,
           "Uganda" = filtered_scatter %>% filter(country == "Uganda"),
           "Kenya" = filtered_scatter %>% filter(country == "Kenya"),
           "Ethiopia" = filtered_scatter %>% filter(country == "Ethiopia"),
           "Ghana" = filtered_scatter %>% filter(country == "Ghana")
    )
  })
  
  # PLOT OUTPUT
  output$scatterPlot <- renderPlot({
    data <- selected_scatter_data()
    
    # Scatterplot
    ggplot(data, aes_string(x = input$x_parameter, y = input$y_parameter)) +
      geom_point(color = sample(brewer.pal(10,"Dark2"), 1)) +
      labs(x = paste(input$x_parameter), y = paste(input$y_parameter), title = paste("Scatterplot -", input$scatter_country)) +
      theme(axis.title = element_text(size = 14, face = "bold"),   # Set axis title size
            axis.text = element_text(size = 12),    # Set axis label size
            plot.title = element_text(size = 16, face = "bold"))   # Set plot title size
      # labs(x = input$x_parameter, y = input$y_parameter, title = paste("Scatterplot -", input$scatter_country)) +
      # theme(axis.title = element_text(size = 14, face = "bold"),   # Set axis title size
      #       axis.text = element_text(size = 12),    # Set axis label size
      #       plot.title = element_text(size = 16, face = "bold"))   # Set plot title size
  })
  
}
  