

ui_correlation_tab <- function() {
  tabPanel("Correlation Plot",
           sidebarLayout(
             sidebarPanel(
               width = 3, # Adjust width of sidebar panel
               selectInput("scatter_country", "Select Country:",
                           choices = c("Uganda", "Kenya", "Ethiopia", "Ghana"),
                           selected = "Uganda",
                           multiple = FALSE),
               selectInput("x_parameter", "Select X-axis Parameter:",
                           choices = c("pm1", "pm10", "pm25", "co", "no", "no2", "o3"),
                           selected = "pm1",
                           multiple = FALSE),
               selectInput("y_parameter", "Select Y-axis Parameter:",
                           choices = c("pm1", "pm10", "pm25", "co", "no", "no2", "o3"),
                           selected = "pm10",
                           multiple = FALSE),
               br(),
               helpText("Note: Select parameters for X and Y axes.")
             ),
             mainPanel(
               plotOutput("scatterPlot")
             )
           )
  )
}

