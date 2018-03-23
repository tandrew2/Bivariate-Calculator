
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotly)

shinyUI(fluidPage(

  # Application title
  titlePanel("Visualized Bivariate Normal Distribution"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h1("Bivariate Normal Component"),
      numericInput("n",
                   "n-sample",
                   1000,
                   min = 1,
                   max = 1000),
      numericInput("m1",
                   "Mean 1",
                   0),
      numericInput("m2",
                   "Mean 2",
                   0),
      numericInput("sd1",
                   "Standard Deviation 1",
                   1,
                   min = .Machine$double.eps),
      numericInput("sd2",
                   "Standard Deviation 2",
                   1,
                   min = .Machine$double.eps),
      numericInput("p",
                   "Correlation",
                   0,
                   min = -1,
                   max = 1),
      numericInput("seed_num",
                   "Put seed number",
                   1337),
      submitButton("Generate the plot")
    ),
    
    mainPanel(h3("Calculated Data"),
              plotlyOutput("plotly"),
              plotOutput("image")
    )
  )
))
