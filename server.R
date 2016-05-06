
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
dataFromExcelPr <- read.xlsx(file="Szwajcaria Dane Procent.xlsx", sheetIndex=1,header=TRUE)

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
      gl2 <- geom_line(data = df2, aes(x = x, y = y$Swisscom_postpaid, color=" Swisscom_postpaid "), linetype = 1, size = 1.6)
    }
    if((InputMod[1] == 3 || InputMod[2] == 3) || InputMod[3] == 3) {
      gl3 <- geom_line(data = df2, aes(x = x, y = y$Sunrise_prepaid, color=" Sunrise_prepaid "), linetype = 2, size = 1.6)
    }
    if((((InputMod[1] == 4 || InputMod[2] == 4) || InputMod[3] == 4) || ( InputMod[4] == 4))) {
      gl4 <- geom_line(data = df2, aes(x = x, y = y$Sunrise_postpaid, color=" Sunrise_postpaid "), linetype = 1, size = 1.6)
    }
    if(((InputMod[1] == 5 || InputMod[2] == 5) || (InputMod[3] == 5 || InputMod[4] == 5)) || InputMod[5] == 5) {
      gl5 <- geom_line(data = df2, aes(x = x, y = y$Orange_prepaid, color=" Orange_prepaid "), linetype = 2, size = 1.6)
    }
    if(((((InputMod[1] == 6 || InputMod[2] == 6) || InputMod[3] == 6) || InputMod[4] == 6) || InputMod[5] == 6) || InputMod[6] == 6) {
     gl6 <- geom_line(data = df2, aes(x = x, y = y$Orange_postpaid, color=" Orange_postpaid "), linetype = 1, size = 1.6)
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
      ggtitle("Subscribers Market Share in Switzerland for Mobile Prepaid and Postpaid market and its' competition in 2003-2015") +
      theme(plot.title=element_text(size=8, face="bold", hjust = 0.5), axis.title=element_text(size=8))
     plotGgplot
  })
  
  #######SECOND PLOT#######
  output$Plot2 <- renderPlot({
    
    #####WIDGET - OPTION - OPEN#####
    df3 <- df
    InputMod2 <- input$Plot_2_1
    for(i in 1:16) {
      InputMod2[length(InputMod2)+1] <- 0
    }

    if(InputMod2[1] != 1) {
      df3$Swisscom_prepaid <- NULL
    }
    if(!(!(InputMod2[1] != 2) || !(InputMod2[2] != 2))) {
      df3$Swisscom_postpaid <- NULL
    }
    if(!((!(InputMod2[1] != 3) || !(InputMod2[2] != 3)) || !(InputMod2[3] != 3))) {
      df3$Sunrise_prepaid <- NULL
    }
    if(!( ((!(InputMod2[1] != 4) || !(InputMod2[2] != 4)) || !(InputMod2[3] != 4)) || !(InputMod2[4] != 4))) {
      df3$Sunrise_postpaid <- NULL
    }
    if(!( (((!(InputMod2[1] != 5) || !(InputMod2[2] != 5)) || !(InputMod2[3] != 5)) || !(InputMod2[4] != 5)) || !(InputMod2[5] != 5))) {
      df3$Orange_prepaid <- NULL
    }
    if(!( ((((!(InputMod2[1] != 6) || !(InputMod2[2] != 6)) || !(InputMod2[3] != 6)) || !(InputMod2[4] != 6)) || !(InputMod2[5] != 6)) || !(InputMod2[6] != 6))) {
      df3$Orange_postpaid <- NULL
    }
    ###7 Population
    if(!( (((((!(InputMod2[1] != 7) || !(InputMod2[2] != 7)) || !(InputMod2[3] != 7)) || !(InputMod2[4] != 7)) || !(InputMod2[5] != 7)) || !(InputMod2[6] != 7)) || !(InputMod2[7] != 7))) {
      df3$Population <- NULL
    }
    ###8 Female population
    if(!( ((((((!(InputMod2[1] != 8) || !(InputMod2[2] != 8)) || !(InputMod2[3] != 8)) || !(InputMod2[4] != 8)) || !(InputMod2[5] != 8)) || !(InputMod2[6] != 8)) || !(InputMod2[7] != 8)) || !(InputMod2[8] != 8))) {
      df3$F.pop <- NULL
    }
    ###9 Male population
    if(!( (((((((!(InputMod2[1] != 9) || !(InputMod2[2] != 9)) || !(InputMod2[3] != 9)) || !(InputMod2[4] != 9)) || !(InputMod2[5] != 9)) || !(InputMod2[6] != 9)) || !(InputMod2[7] != 9)) || !(InputMod2[8] != 9)) || !(InputMod2[9] != 9))) {
      df3$M.pop <- NULL
    }
    if(!( ((((((((!(InputMod2[1] != 10) || !(InputMod2[2] != 10)) || !(InputMod2[3] != 10)) || !(InputMod2[4] != 10)) || !(InputMod2[5] != 10)) || !(InputMod2[6] != 10)) || !(InputMod2[7] != 10)) || !(InputMod2[8] != 10)) || !(InputMod2[9] != 10)) || !(InputMod2[10] != 10))) {
      df3$Total <- NULL
    }
    #####WIDGET - OPTION - END#####
    InputMod2 <- input$Plot_2_2
    for(i in 1:13) {
      InputMod2[length(InputMod2)+1] <- 0
    }
    k <- 0
    
    if(InputMod2[1] == 1) {
      k <- 1
    }
    if(InputMod2[2] == 2) {
      k <- 2
    }
    if(InputMod2[3] == 3) {
      k <- 3
    }
    if(InputMod2[4] == 4) {
      k <- 4
    }
    if(InputMod2[5] == 5) {
      k <- 5
    }
    if(InputMod2[6] == 6) {
      k <- 6
    }
    if(InputMod2[7] == 7) {
      k <- 7
    }
    if(InputMod2[8] == 8) {
      k <- 8
    }
    if(InputMod2[9] == 9) {
      k <- 9
    }
    if(InputMod2[10] == 10) {
      k <- 10
    }
    if(InputMod2[11] == 11) {
      k <- 11
    }
    if(InputMod2[12] == 12) {
      k <- 12
    }
    if(InputMod2[13] == 13) {
      k <- 13
    }
    
    df3.totalFor2015 <- data.frame(matrix(apply(df3[k, 2:length(df3)], 2, sum), 1))
    #df.totalFor2015 <- matrix(apply(df[, 2:length(df)], 2, sum), 1)
    colnames(df3.totalFor2015) <- names(df3[k,2:length(df3)])
    df3.totalFor2015 <- transform(df3.totalFor2015, TotalSubsc = apply(df3.totalFor2015, 1, sum))
    df3.totalFor2015  <- as.data.frame(apply(df3.totalFor2015, 2, function(x) x/df3.totalFor2015$TotalSubsc))
    df3.totalFor2015 <- apply(df3.totalFor2015, 2, round, digits=3)
    df3.totalFor2015 <- as.data.frame(df3.totalFor2015[-nrow(df3.totalFor2015),])
    names(df3.totalFor2015) <- "TotalFor2015"
    df3.totalFor2015 <- cbind(rownames(df3.totalFor2015), df3.totalFor2015)
    colnames(df3.totalFor2015)[1] <- "ServiceProviders"
    x.totalFor2015 <- df3.totalFor2015[,1]
    y.totalFor2015 <- df3.totalFor2015[,2]
    allSubsc2015MarketSharePie <- ggplot(df3.totalFor2015, aes(x = "", y=TotalFor2015, fill = ServiceProviders)) +
      geom_bar(width=1, stat="identity") +
      coord_polar(theta = "y") +
      scale_x_discrete("") +
      ggtitle("Subscribers Market Share in Switzerland for Mobile Prepaid and Postpaid market and its' competition in 2003-2015") +
      theme(plot.title=element_text(size=8, face="bold", hjust = 0.5), axis.title=element_text(size=8))
    allSubsc2015MarketSharePie
  })
  
  output$Plot3 <- renderPlot({
    df <- dataFromExcelPr
    df$Date <- as.Date(as.character(df$Date), format="%Y-%m-%d") 
      x <- df$Date # first column with Date
      y <- df[ , 2:length(df)] # (all columns from df without the first one, the first column was x = Date)
      plotGgplot2 <- ggplot() +
        geom_line(data = df, aes(x = x, y = y$Pr_Swisscom_prepaid, color=" Swisscom_prepaid "), linetype = 2, size = 1.6) +
        geom_line(data = df, aes(x = x, y = y$Pr_Swisscom_postpaid, color=" Swisscom_postpaid "), linetype = 1, size = 1.6) +
        geom_line(data = df, aes(x = x, y = y$Pr_Sunrise_prepaid, color=" Sunrise_prepaid "), linetype = 2, size = 1.6) +
        geom_line(data = df, aes(x = x, y = y$Pr_Sunrise_postpaid, color=" Sunrise_postpaid "), linetype = 1, size = 1.6) +
        geom_line(data = df, aes(x = x, y = y$Pr_Orange_prepaid, color=" Orange_prepaid "), linetype = 2, size = 1.6) +
        geom_line(data = df, aes(x = x, y = y$Pr_Orange_postpaid, color=" Orange_postpaid "), linetype = 1, size = 1.6) +
        ylab('Number of Subscribers') +
        xlab('Year') +
        scale_y_continuous ( labels = comma, breaks = seq(from=0,to=100,by=10)) +
        ggtitle("Subscribers Market Share in Switzerland for Mobile Prepaid and Postpaid market and its' competition in 2003-2015") +
        theme(plot.title=element_text(size=8, face="bold", hjust = 0.5), axis.title=element_text(size=8))
      plotGgplot2
  })
  output$Plot4 <- renderPlot({
    df$Date <- as.Date(as.character(df$Date), format="%Y-%m-%d")
    
    # standardize scale => scale function
    
    df.stand <- as.data.frame(cbind(df[,1], scale(df[,2:ncol(df)])))
    colnames(df.stand)[1] <- "Date"
    df.stand$Date <- as.Date(df.stand$Date, origin="1970-01-01")
    class(df.stand$Date)
    x.stand <- df.stand[,1]
    y.stand <- df.stand[,2:length(df.stand)]
    df$Total <- NULL
    df$Population<- NULL
    df$F.pop<- NULL
    df$M.pop<- NULL
    
    x <- x.stand
    y <- y.stand
    plotGgplot <- ggplot() +
      geom_line(data = df, aes(x = x, y = y$Swisscom_prepaid, color=" Swisscom_prepaid "), linetype = 2, size = 1.6) +
      geom_line(data = df, aes(x = x, y = y$Swisscom_postpaid, color=" Swisscom_postpaid "), linetype = 1, size = 1.6) +
      geom_line(data = df, aes(x = x, y = y$Sunrise_prepaid, color=" Sunrise_prepaid "), linetype = 2, size = 1.6) +
      geom_line(data = df, aes(x = x, y = y$Sunrise_postpaid, color=" Sunrise_postpaid "), linetype = 1, size = 1.6) +
      geom_line(data = df, aes(x = x, y = y$Orange_prepaid, color=" Orange_prepaid "), linetype = 2, size = 1.6) +
      geom_line(data = df, aes(x = x, y = y$Orange_postpaid, color=" Orange_postpaid "), linetype = 1, size = 1.6) +
      ylab('Number of Subscribers') +
      xlab('Year') +
      # scale_x_continuous(labels = comma) +
      scale_y_continuous ( labels = comma, breaks = seq(from=0,to=3000000,by=200000)) +
      ggtitle("Subscribers in Switzerland for Mobile Prepaid and Postpaid and its' competition in 2003-2015") +
      theme(plot.title=element_text(size=8, face="bold",
                                    hjust = 0.5),
            axis.title=element_text(size=8))
    plotGgplot
  })
})

