
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

#install.packages("xlsx")
#install.packages("ggplot2")

library(shiny)
library(xlsx) # to read excel files
library(ggplot2) # to plot
library(scales) # to describe values on the plot 2,000,000 instead of 2000000

dataFromExcel <- read.xlsx(file="Szwajcaria Dane.xlsx", sheetIndex=1,header=TRUE)

shinyServer(function(input, output) {
  options(scipen=999)
  df <- dataFromExcel
  
  #######FIRST PLOT#######
  df$Date <- as.Date(as.character(df$Date), format="%Y-%m-%d")
  output$Plot1 <- renderPlot({
    
    #####WIDGET - SLIDER RANGE - OPEN#####
    y1 <- input$Plot_1_2[1] - 2002
    y2 <- (-1) * (2003 - input$Plot_1_2[2])
    df2 <- df[y1:y2, ]
    #####WIDGET - SLIDER RANGE - END#####
    
    #####WIDGET - OPTION - OPEN#####
    InputMod <- input$Plot_1_1
    for(i in 1:6) {
      InputMod[length(InputMod)+1] <- 0
    }
    gl1 <- NULL
    gl2 <- NULL
    gl3 <- NULL
    gl4 <- NULL
    gl5 <- NULL
    gl6 <- NULL
    
    if(InputMod[1] == 1) {
      gl1 <- geom_line(data = df2, aes(x = x, y = y$Swisscom_prepaid, color=" Swisscom_prepaid "), linetype = 2, size = 1.6)
    }
    if(InputMod[1] == 2 || InputMod[2] == 2) {
      gl2 <- geom_line(data = df2, aes(x = x, y = y$Swisscom_postpaid, color=" Swisscom_postpaid "), linetype = 2, size = 1.6)
    }
    if((InputMod[1] == 3 || InputMod[2] == 3) || InputMod[3] == 3) {
      gl3 <- geom_line(data = df2, aes(x = x, y = y$Sunrise_prepaid, color=" Sunrise_prepaid "), linetype = 2, size = 1.6)
    }
    if((((InputMod[1] == 4 || InputMod[2] == 4) || InputMod[3] == 4) || ( InputMod[4] == 4))) {
      gl4 <- geom_line(data = df2, aes(x = x, y = y$Sunrise_postpaid, color=" Sunrise_postpaid "), linetype = 2, size = 1.6)
    }
    if(((InputMod[1] == 5 || InputMod[2] == 5) || (InputMod[3] == 5 || InputMod[4] == 5)) || InputMod[5] == 5) {
      gl5 <- geom_line(data = df2, aes(x = x, y = y$Orange_prepaid, color=" Orange_prepaid "), linetype = 2, size = 1.6)
    }
    if(((((InputMod[1] == 6 || InputMod[2] == 6) || InputMod[3] == 6) || InputMod[4] == 6) || InputMod[5] == 6) || InputMod[6] == 6) {
     gl6 <- geom_line(data = df2, aes(x = x, y = y$Orange_postpaid, color=" Orange_postpaid "), linetype = 2, size = 1.6)
    }
    #####WIDGET - OPTION - END#####

     x <- df2$Date # first column with Date
     y <- df2[ , 2:length(df2)] # (all columns from df without the first one, the first column was x = Date)
     plotGgplot <- ggplot() +
      gl1 + gl2 + gl3 + gl4 + gl5 + gl6 +
      ylab('Number of Subscribers') +
      xlab('Year') +
      # scale_x_continuous(labels = comma, breaks = seq(from=2003,to=2015,by=1)) +
      scale_y_continuous ( labels = comma, breaks = seq(from=0,to=6000000,by=200000)) +
      ggtitle("Subscribers Market Share in Switzerland for Mobile Prepaid and Postpaid market and its' competition in 2010-2015") +
      theme(plot.title=element_text(size=8, face="bold", hjust = 0.5), axis.title=element_text(size=8))
     plotGgplot
  })
  
  #######SECOND PLOT#######
  output$Plot2 <- renderPlot({
    df.totalFor2015 <- data.frame(matrix(apply(df[, 2:length(df)], 2, sum), 1))
    #df.totalFor2015 <- matrix(apply(df[, 2:length(df)], 2, sum), 1)
    colnames(df.totalFor2015) <- names(df[,2:length(df)])
    df.totalFor2015 <- transform(df.totalFor2015, TotalSubsc = apply(df.totalFor2015, 1, sum))
    df.totalFor2015  <- as.data.frame(apply(df.totalFor2015, 2, function(x) x/df.totalFor2015$TotalSubsc))
    df.totalFor2015 <- apply(df.totalFor2015, 2, round, digits=3)
    df.totalFor2015 <- as.data.frame(df.totalFor2015[-nrow(df.totalFor2015),])
    names(df.totalFor2015) <- "TotalFor2015"
    df.totalFor2015 <- cbind(rownames(df.totalFor2015), df.totalFor2015)
    colnames(df.totalFor2015)[1] <- "ServiceProviders"
    x.totalFor2015 <- df.totalFor2015[,1]
    y.totalFor2015 <- df.totalFor2015[,2]
    allSubsc2015MarketSharePie <- ggplot(df.totalFor2015,
                                         aes(x = "", y=TotalFor2015, fill = ServiceProviders)) +
      geom_bar(width=1, stat="identity") +
      coord_polar(theta = "y") +
      scale_x_discrete("") +
      ggtitle("Subscribers Market Share in Switzerland for Mobile Prepaid and Postpaid market and its' competition in 2010-2015") +
      theme(plot.title=element_text(size=8, face="bold",
                                    hjust = 0.5),
            axis.title=element_text(size=8))
    allSubsc2015MarketSharePie
  })
  })

