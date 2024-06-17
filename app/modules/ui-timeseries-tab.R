


ui_timeseries_tab <- function() {
  tabPanel("Time Series Plot",
           sidebarLayout(
             sidebarPanel(
               width = 3, # Adjust width of sidebar panel
               selectInput("timeseries_country", "Select Country:",
                           choices = c("Uganda", "Kenya", "Ethiopia", "Ghana"),
                           selected = "Uganda",
                           multiple = FALSE),
               checkboxGroupInput("parameters", "Select Parameters:",
                                  choices = c("pm1", "pm10", "pm25", "co", "no", "no2", "o3"),
                                  selected = c("pm1", "pm10", "pm25")),
               br(),
               helpText("Note: You can select multiple parameters.")
             ),
             mainPanel(
               plotOutput("timeSeriesPlot")
             )
           )
  )
}