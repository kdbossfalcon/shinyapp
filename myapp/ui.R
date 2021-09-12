#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Exponential distribution simulation"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h3('Plot'),
            numericInput('n', 'Exponentials to be simulated (10-10000)', 500, min = 10, max = 10000, step = 1),
            sliderInput("rate1", "Expo1(red) lambda (0.01-1)",
                        min = 0.01, max = 2, value = 2, step = 0.01),
            sliderInput("rate2", "Expo2(green) lambda (0.01-1)",
                        min = 0.01, max = 2, value = 1, step = 0.01),
            sliderInput("rate3", "Expo3(blue) lambda (0.01-1)",
                        min = 0.01, max = 2, value = 0.5, step = 0.01),
            h3('CLT'),
            numericInput('simulation','Number of simulation (100-2000)', 1000, min = 100, max = 2000, step = 100),
            numericInput('n2', 'Exponentials for each simulation (10-80)', 40, min = 10, max = 80, step = 10),
            sliderInput('lambda', 'Lambda: (0.1 - 1)', 0.5, min = 0.1, max = 1, step = 0.1)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Documentation", 
                                 h2('Author: Kantapon Dissaneewate'),
                                 h3('date: 12/9/2021'),
                                 h3('Plot tab'),
                                 "Plot tab simulates 3 exponential distribution",
                                 h4(""),
                                 'You can choose number of value to simulate and lambda for each simulation exponential', h4(''),
                                'You can play around with it to get a feel of what each parameter do to the plot and compare them',h4(''),
                                'Note that lambda dictate exponential distribution mean and SD',h4(''),
                                'distribution mean and sd is equal to 1/lambda',
                                h3('CLT tab'),
                                'CLT tab simulate multiple exponential and take average of each simulation then plot them together as histogram', h4(''),
                                'This plot validate "central limit theorem" that "when independent random variables are added, their properly normalized sum tends toward a normal distribution (informally a bell curve) even if the original variables themselves are not normally distributed"',h4(''),
                                'What it mean is that as more simulation mean add together, it will converge into normal distribution',
                                'The histogram will be overlay with normal distribution line and for exponential distribution, mean and SD of the histogram will be 1/lambda', h4(''),
                                'You can change number of simulation, number of exponentials for each simulation and lambda', h4(''),
                                'Under the plot we will display theoretical and calculated mean and SD from the simulation'),
                        tabPanel("Plot", plotOutput("plot")),
                        tabPanel('CTL', plotOutput("plotCTL"),
                                 h4('Calculated mean: '), verbatimTextOutput('calmean'),
                                 h4('Theoretical mean: '), verbatimTextOutput('theomean'),
                                 h4('Calculated SD: '), verbatimTextOutput('calsd'),
                                 h4('Theoretical SD: '), verbatimTextOutput('theosd'))
                        
        )
    )
))
)