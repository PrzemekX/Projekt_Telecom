
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(xlsx) # to read excel files
library(ggplot2) # to plot
library(scales) # to describe values on the plot 2,000,000 instead of 2000000

dataFromExcel <- read.xlsx(file="Szwajcaria Dane.xlsx", sheetIndex=1,header=TRUE)

shinyServer(function(input, output) {
  #options(scipen=999)
  #dataFromExcel <- read.xlsx(file="Szwajcaria Dane.xlsx", sheetIndex=1,header=TRUE)
  df <- dataFromExcel
  
    # options(scipen=999)
    # dataFromExcel <- read.xlsx(file="Szwajcaria Dane.xlsx", sheetIndex=1,header=TRUE)
    # df <- dataFromExcel
  output$distPlot <- renderPlot({
    # x    <- faithful[, 2]  # Old Faithful Geyser data
    # bins <- seq(min(x), max(x), length.out = 50)
    # 
    # # draw the histogram with the specified number of bins
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
     df$Date <- as.Date(as.character(df$Date), format="%Y-%m-%d")
     x <- df$Date # first column with Date
     y <- df[ , 2:length(df)] # (all columns from df without the first one, the first column was x = Date)
     plotGgplot <- ggplot() +
      geom_line(data = df, aes(x = x, y = y$Swisscom_prepaid, color=" Swisscom_prepaid "), linetype = 2, size = 1.6) +
      geom_line(data = df, aes(x = x, y = y$Swisscom_postpaid, color=" Swisscom_postpaid "), linetype = 2, size = 1.6) +
      geom_line(data = df, aes(x = x, y = y$Sunrise_prepaid, color=" Sunrise_prepaid "), linetype = 2, size = 1.6) +
      geom_line(data = df, aes(x = x, y = y$Sunrise_postpaid, color=" Sunrise_postpaid "), linetype = 2, size = 1.6) +
      geom_line(data = df, aes(x = x, y = y$Orange_prepaid, color=" Orange_prepaid "), linetype = 2, size = 1.6) +
      geom_line(data = df, aes(x = x, y = y$Orange_postpaid, color=" Orange_postpaid "), linetype = 2, size = 1.6) +
      ylab('Number of Subscribers') +
      xlab('Year') +
      # scale_x_continuous(labels = comma) +
      scale_y_continuous ( labels = comma, breaks = seq(from=0,to=3000000,by=200000)) +
      ggtitle("Subscribers in ?Country A? for ?MainPrivider? and its' competition in 2010-2015") +
      theme(plot.title=element_text(size=8, face="bold",
                                    hjust = 0.5),
            axis.title=element_text(size=8))
     plotGgplot
  })
  })

  #output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2]
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')

