
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Subscribers Market Share in Switzerland for Mobile Prepaid and Postpaid market and its' competition in 2010-2015"),

  sidebarLayout(
    sidebarPanel(
      #helpText("Test1"),
      
      #selectInput("var", 
                 #label = "Choose a variable to display",
                  #choices = c("Percent White", "Percent Black",
                  #            "Percent Hispanic", "Percent Asian"),
                  #selected = "Percent White"),
      
      # sliderInput("range", 
      #             label = "Range of interest:",
      #             min = 0, max = 100, value = c(0, 100))
       ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
