
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage( theme = "bootstrap.css",

  # Application title
  titlePanel(h2("Subscribers Market Share in Switzerland for Mobile Prepaid and Postpaid market and its' competition in 2003-2015")),
  # Add CSS
  includeCSS("styles.css"),
  
  hr(),
  
  sidebarLayout( position = "right",
    
    #####WIDGET - Checkbox Group - OPEN#####

    sidebarPanel( width = 4,
      checkboxGroupInput("Plot_1_1", label = h3("Plot 1 options - Mobile market"),
                         choices = list("Swisscom prepaid" = 1, "Swisscom postpaid" = 2, "Sunrise prepaid" = 3, "Sunrise postpaid" = 4, "Orange prepaid" = 5, "Orange postpaid" = 6),
                         selected = c(1,2,3,4,5,6))
    ),
    # navbarPage()
    #####WIDGET - Checkbox Group - END#####
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot1")
    )
  ),
  
  #####WIDGET - SLIDER RANGE - OPEN#####
    fluidRow( 
      column(width = 9, offset = 1,

           # Copy the line below to make a slider range
           sliderInput("Plot_1_2", label = h3("Year Range"), min = 2003,
                       max = 2015, value = c(2003, 2015))
      )
    ),
  #####WIDGET - SLIDER RANGE - END#####
  
  hr(),
  
  sidebarLayout( position = "right",
    sidebarPanel( width = 4,
                  checkboxGroupInput("Plot_2_1", label = h3("Plot 2 options - Mobile market"),
                  choices = list("Swisscom prepaid" = 1, "Swisscom postpaid" = 2, "Sunrise prepaid" = 3, "Sunrise postpaid" = 4, "Orange prepaid" = 5, "Orange postpaid" = 6, "Population" = 7, "Female population" = 8, "Male population" = 9, "Total" = 10),
                  selected = c(1,2,3,4,5,6,7,8,9,10))
    ),
    
    mainPanel(
      plotOutput("Plot2")
    )
  ),
  
  radioButtons("Plot2_2", label = h3("Plot 2 options - Year"),
               choices = list("2003" = 1, "2004" = 2, "2005" = 3, "2006" = 4, "2007" = 5, "2008" = 6, "2009" = 7, "2010" = 8, "2011" = 9, "2012" = 10, "2013" = 11, "2014" = 12, "2015" = 13),
               selected = 1,
               inline = TRUE),
  
  hr(),
  
  plotOutput("Plot3"),
  hr(),
  plotOutput("Plot4"),
  hr()
))
