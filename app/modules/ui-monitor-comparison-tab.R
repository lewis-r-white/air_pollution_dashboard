

ui_monitor_comparison_tab <- function() {
  
  tabPanel("Monitor Comparison Plots",
           sidebarLayout(
             sidebarPanel(
               width = 3,
               selectInput("comparison_country", "Select Country:",
                           choices = c("Uganda", "Kenya", "Ethiopia", "Ghana"),
                           selected = "Uganda",
                           multiple = FALSE),
               selectInput("comparison_parameter", "Select Pollution Parameter:",
                           choices = c("pm1", "pm10", "pm25"),
                           selected = "pm25",
                           multiple = FALSE),
               br(),
               helpText("Note: Select country and pollution parameter.")
             ),
             mainPanel(
               plotOutput("monitor_plots", height = "1000px")
             )
           )
  )
  
}
  