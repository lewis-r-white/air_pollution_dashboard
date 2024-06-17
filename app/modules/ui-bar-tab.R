

ui_bar_tab <- function() {
  
  tabPanel("Data Completeness",
           sidebarLayout(
             sidebarPanel(
               selectInput("completeness_country", "Select Country:",
                           choices = c("Uganda", "Kenya", "Ethiopia", "Ghana"),
                           selected = "Uganda",
                           multiple = FALSE),
               selectInput("parameter", "Select Parameter:",
                           choices = c("pm1", "pm10", "pm25", "co", "no", "no2", "o3")),
               sliderInput("threshold", "Completeness Threshold:",
                           min = 0, max = 100, value = 75)
             ),
             mainPanel(
               plotOutput("bar_chart")
             )
           )
  )
  
}