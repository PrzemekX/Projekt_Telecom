
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
    #####WIDGET - Checkbox Group - OPEN#####
    sidebarPanel(
      checkboxGroupInput("Plot_1_1", label = h3("Plot 1 options - Mobile market"), 
                         choices = list("Swisscom prepaid" = 1, "Swisscom postpaid" = 2, "Sunrise prepaid" = 3, "Sunrise postpaid" = 4, "Orange prepaid" = 5, "Orange postpaid" = 6),
                         selected = c(1,2,3,4,5,6))
    ),
    #####WIDGET - Checkbox Group - END#####
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot1")
      # plotOutput("Plot2")
    )
  ),
  #####WIDGET - SLIDER RANGE - OPEN#####
  fluidRow(
    column(4,
           
           # Copy the line below to make a slider range 
           sliderInput("Plot_1_2", label = h3("Year Range"), min = 2003, 
                       max = 2015, value = c(2003, 2015))
    )
  ),
  
  hr(),
  
  fluidRow(
    column(4, verbatimTextOutput("range"))
  ),
  #####WIDGET - SLIDER RANGE - END#####
  
  plotOutput("Plot2")
  
))
