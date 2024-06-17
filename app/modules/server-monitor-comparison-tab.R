


server_monitor_comparison_tab <- function(input, output, session, filtered_ind_avg_monitor_comparison) {
  
  # DEFINE REACTIVE EXPRESSIONS
  selected_diagnostic_plot <- reactive({
      filtered_diagnostic <- filtered_ind_avg_monitor_comparison()
      dataset <-  switch(input$comparison_country,
                      "Uganda" = filtered_diagnostic %>% filter(country == "Uganda"),
                      "Kenya" = filtered_diagnostic %>% filter(country == "Kenya"),
                      "Ethiopia" = filtered_diagnostic %>% filter(country == "Ethiopia"),
                      "Ghana" = filtered_diagnostic %>% filter(country == "Ghana")
          )
    filtered_data <- dataset %>%
      filter(variable == input$comparison_parameter)

    return(filtered_data)
  })
  
  # PLOT OUTPUT
  output$monitor_plots <- renderPlot({
    data <- selected_diagnostic_plot() 
    
    monitor_plots <- lapply(unique(data$monitor), function(monitor_id) {
      monitor_data <- data[data$monitor == monitor_id, ]
      ggplot(data = monitor_data, aes(x = average, y = individual)) +
        geom_point() +
        labs(x = paste("Fleet Average -", input$comparison_parameter), y = paste("Individual Monitor -", input$comparison_parameter)) +
        ggtitle(paste("Monitor:", monitor_id)) +
        theme_minimal()
    })
    
    # Set number of columns based on the number of plots
    if(length(monitor_plots) > 15) {
      num_cols <- 4
    } else if(length(monitor_plots) > 10) {
      num_cols <- 3
    } else if(length(monitor_plots) > 1) {
      num_cols <- 2
    } else {
      num_cols <- 1
    }
    
    # If only one plot, set full width; otherwise, set specified number of columns
    if(length(monitor_plots) > 0) {
      gridExtra::grid.arrange(grobs = monitor_plots, ncol = num_cols)
    } else {
      plot(NULL, xlim = c(0, 1), ylim = c(0, 1), axes = FALSE, frame.plot = FALSE)
    }
  })
  
  
}
  