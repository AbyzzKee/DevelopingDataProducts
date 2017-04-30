library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Seasonal Bread Sales Viewer"),
  sidebarPanel(
    sliderInput('daySlider', 'Date Slider',value = 5, min = 1, max = 10, step = 0.14),
    h4("Date:"),
    textOutput('text1')
  ),
  mainPanel(
    h4("Bread Product Tab"),
    tabsetPanel(type = "tabs",
                tabPanel("GARDENIA CLASSIC", plotOutput('plot1')),
                tabPanel("GARDENIA BONANZA", plotOutput('plot2')),
                tabPanel("ROTI SEDAP", plotOutput('plot3'))
    )
  )
))