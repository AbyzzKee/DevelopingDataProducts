library(shiny)
library(forecast)
library(ggplot2)
library(plotly)

bread <- read.csv("bread.csv")

# Aggregate Sales Data by Date
dailySales <- aggregate(list(count=bread$count), list(recpt_dt = as.Date(bread$recpt_dt), item_id = factor(bread$item_id)), sum)

# Separate data by product
GARDENIA_CLASSIC <- data.frame(count = dailySales[dailySales$item_id==23,   "count"])
GARDENIA_BONANZA <- data.frame(count = dailySales[dailySales$item_id==24,   "count"])
ROTI_SEDAP       <- data.frame(count = dailySales[dailySales$item_id==8331, "count"])

# Time Series by week
ts_GARDENIA_CLASSIC <- ts(GARDENIA_CLASSIC, frequency=7)
ts_GARDENIA_BONANZA <- ts(GARDENIA_BONANZA, frequency=7)
ts_ROTI_SEDAP       <- ts(ROTI_SEDAP, frequency=7)

# Weekdays
breadDate <- dailySales[dailySales$item_id==8331, "recpt_dt"]
breadWeek <- data.frame(weekdays=weekdays(breadDate))
breadWeek$num <- as.numeric(factor(breadWeek$weekdays, c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")))

dimnames(ts_GARDENIA_CLASSIC)[1] <- list(breadWeek$weekdays)
dimnames(ts_GARDENIA_BONANZA)[1] <- list(breadWeek$weekdays)
dimnames(ts_ROTI_SEDAP)[1]       <- list(breadWeek$weekdays)

# library(forecast)
trend_GARDENIA_CLASSIC <- decompose(ts_GARDENIA_CLASSIC)
trend_GARDENIA_BONANZA <- decompose(ts_GARDENIA_BONANZA)
trend_ROTI_SEDAP       <- decompose(ts_ROTI_SEDAP)

processIndex <- function(value) {
  index <- round((value-1)*7)
  if(index < 1) index <- 1
  if(index > 62) index <- 62
  index
}
  
shinyServer(
  function(input, output) {
    output$text1 <- renderText({
      index <- processIndex(input$daySlider)
      paste0(breadDate[index], " (", breadWeek$weekdays[index], ")")
      })
    output$plot1 <- renderPlot({
      index <- processIndex(input$daySlider)
      plot(trend_GARDENIA_CLASSIC,xlab="Weeks", ylab="Bread Sold")
      abline ( v = 1+index/7, col = "magenta", lwd = 2 )
    })
    output$plot2 <- renderPlot({
      index <- processIndex(input$daySlider)
      plot(trend_GARDENIA_BONANZA,xlab="Weeks", ylab="Bread Sold")
      abline ( v = 1+index/7, col = "magenta", lwd = 2 )
    })
    output$plot3 <- renderPlot({
      index <- processIndex(input$daySlider)
      plot(trend_ROTI_SEDAP,xlab="Weeks", ylab="Bread Sold")
      abline ( v = 1+index/7, col = "magenta", lwd = 2 )
    })
  }
)
