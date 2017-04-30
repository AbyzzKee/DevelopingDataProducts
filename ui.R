library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Seasonal Bread Sales Viewer"),
  sidebarPanel(
    sliderInput('daySlider', 'Date Slider (Slide to select date)',value = 5, min = 1, max = 10, step = 0.14),
    h4("Date:"),
    textOutput('text1'),
    br(),
    h4("Documentation:"),
    a("Click to show Documentation Slide", 
      href="https://AbyzzKee.github.io/DevelopingDataProducts/Lesson9_W4_Assignment.html")
  ),
  mainPanel(
    h4("Bread Product Tab"),
    h5("Click on tab to select different product"),
    tabsetPanel(type = "tabs",
                tabPanel("GARDENIA CLASSIC", plotOutput('plot1')),
                tabPanel("GARDENIA BONANZA", plotOutput('plot2')),
                tabPanel("ROTI SEDAP", plotOutput('plot3'))
    )
  )
))