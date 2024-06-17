

ui_fleet_correlation_tab <- function() {
  
  tabPanel("Fleet Correlation Plots",
           sidebarLayout(
             sidebarPanel(
               width = 3, # Adjust width of sidebar panel
               selectInput("fleet_country", "Select Country:",
                           choices = c("Uganda", "Kenya", "Ethiopia", "Ghana"),
                           selected = "Uganda",
                           multiple = FALSE),
               selectInput("x_parameter_fleet", "Select X-axis Parameter:",
                           choices = c("pm1", "pm10", "pm25", "co", "no", "no2", "o3"),
                           selected = "pm1",
                           multiple = FALSE),
               selectInput("y_parameter_fleet", "Select Y-axis Parameter:",
                           choices = c("pm1", "pm10", "pm25", "co", "no", "no2", "o3"),
                           selected = "pm10",
                           multiple = FALSE),
               br(),
               helpText("Note: Select parameters for X and Y axes.")
             ),
             mainPanel(
               plotOutput("fleetCorrelationPlot", height = "1000px")
             )
           )
  )
  
}