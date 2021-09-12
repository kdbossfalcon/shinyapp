#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

plotexpo <- function(n, rate1, rate2, rate3,
                     line1color, line2color, line3color,
                     linewidth) {
    set.seed(20)
    expo <- data.frame(ex1 = rexp(n = n, rate = rate1),
                       ex2 = rexp(n = n, rate = rate2),
                       ex3 = rexp(n = n, rate = rate3))
    expo$d1 <- dexp(expo$ex1, rate = rate1)
    expo$d2 <- dexp(expo$ex2, rate = rate2)
    expo$d3 <- dexp(expo$ex3, rate = rate3)
    
    ggplot(data = expo) + 
        geom_line(aes(x=ex1, y = d1), col = line1color, size = linewidth, alpha = 0.8) +
        geom_line(aes(x=ex2, y = d2), col = line2color, size = linewidth, alpha = 0.8) +
        geom_line(aes(x=ex3, y = d3), col = line3color, size = linewidth, alpha = 0.8) +
        labs(title = 'Exponential distribution', x = 'value', y = 'density') +
        coord_cartesian(xlim = c(0,10), ylim = c(0,2))
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$plot <- renderPlot({
        plotexpo(input$n,input$rate1,input$rate2,input$rate3,'red','green','blue',1)
    })
    output$plotCTL <- renderPlot({
        
        set.seed(20)
        expo <- list()
        for (i in 1:input$simulation) {
            expo <- c(expo, list(rexp(n = input$n2, rate = input$lambda)))
        }
        means <- NULL
        for (i in 1:input$simulation) {
            means <- c(means, mean(expo[[i]]))
        }
        ## Calculate means of all simulations, store in 'smean'
        smean <- mean(means)
        ## Calculate Theoretical mean, store in 'tmean'
        tmean <- 1/input$lambda
        ## Calculate variance of all mean, store in 'svar'
        svar <- var(means)
        ## Calculate Theoretical variance, store in 'tvar'
        tvar <- (1/(input$lambda^2))/input$n2
        
        ggplot(data = data.frame(means), aes(means)) +
            geom_histogram(aes(y = ..density..),binwidth = 0.2, col = 'blue', fill = 'lightblue') +
            theme_light() + 
            labs(title = "Figure2: Density plot of simulation's mean",
                 subtitle = "simulated(red line), theoretical(green line)") +
            stat_function(fun = dnorm, colour = 'red', args = list(mean = smean, sd = sqrt(svar))) + 
            stat_function(fun = dnorm, colour = 'green', args = list(mean = tmean, sd = sqrt(tvar)))
        })
    output$calmean <- renderPrint({
        
        set.seed(20)
        expo <- list()
        for (i in 1:input$simulation) {
            expo <- c(expo, list(rexp(n = input$n2, rate = input$lambda)))
        }
        means <- NULL
        for (i in 1:input$simulation) {
            means <- c(means, mean(expo[[i]]))
        }
        ## Calculate means of all simulations, store in 'smean'
        smean <- mean(means)
        smean})
    
    output$theomean <- renderPrint({1/input$lambda})
    output$calsd <- renderPrint({
        set.seed(20)
        expo <- list()
        for (i in 1:input$simulation) {
            expo <- c(expo, list(rexp(n = input$n2, rate = input$lambda)))
        }
        means <- NULL
        for (i in 1:input$simulation) {
            means <- c(means, mean(expo[[i]]))
        }
        sd(means)
        })
    output$theosd <- renderPrint({
        tvar = (1/input$lambda^2)/input$n2
        sqrt(tvar)
    })
})

