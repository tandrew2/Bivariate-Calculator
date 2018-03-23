
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(MASS)
library(mvtnorm)
library(plotly)

shinyServer(function(input, output) {
  
  bivariate_normal = reactive({
    validate(
      need(input$n > 0, 'Please enter n > 0'),
      need(input$sd1 > 0, 'Please enter SD1 > 0'),
      need(input$sd2 > 0, 'Please enter SD2 > 0'),
      need(
        input$p >= -1 &
          input$p <= 1,
        'Please enter correlation between -1 & 1'
      )
    )
    set.seed(input$seed_num)
    mean_matrix = c(input$m1, input$m2)
    var_x = input$sd1 ^ 2
    var_y = input$sd2 ^ 2
    cov_xy = input$p * input$sd1 * input$sd2
    cov_matrix = matrix(
      c(var_x, cov_xy, cov_xy, var_y),
      nrow = 2,
      ncol = 2,
      byrow = TRUE
    )
    rmvnorm(input$n, mean_matrix, cov_matrix)
  })
  
 output$plotly = renderPlotly({
   bivn_kde = kde2d(bivariate_normal()[,1], bivariate_normal()[,2], n = 50)
   plot_ly(x = bivn_kde$x, y = bivn_kde$y, z = bivn_kde$z) %>% add_surface()
 })
 
 output$image = renderPlot({
   bivn_kde = kde2d(bivariate_normal()[,1], bivariate_normal()[,2], n = 50)
   image(bivn_kde)
   contour(bivn_kde, add = TRUE)
 })
})
