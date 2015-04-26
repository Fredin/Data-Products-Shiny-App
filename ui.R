
library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("The logistic map"),
    sidebarPanel(
        numericInput("r",
                    "r parameter:",
                    min = 0, max = 4,
                    value = 3.0,
                    step = 0.01),
        numericInput("x0",
                    "initial condition:",
                    min = 0, max = 1,
                    value = 0.2,
                    step = 0.01),
        sliderInput("n",
                    "number of iterations:",
                    min = 50, max = 500,
                    value = 100,
                    step = 10),
        sliderInput("k",
                     "iterations to be discarded:",
                     min = 0, max = 490,
                     value = 0,
                     step = 10),
        withMathJax(
            helpText('The logistic map is a recursive second-degree',
                     'polyinomial function given by the equation',
                     '\\(x_{n+1} = rx_n(1-x_n)\\)',
                     'It is a classic example of how a simple',
                     'non-linear dynamical system can exhibit',
                     'complex and chaotic behaviour.'),
            helpText('This app allows you to explore this system by',
                     'tweaking its parameter, initial condition and',
                     'number of iterations. Vary the r parameter',
                     'continuously to witness the doubling route to chaos!'),
            helpText(a("Visit Wikipedia for more info.", href= "http://en.wikipedia.org/wiki/Logistic_map"))
    )),
    mainPanel(
        plotOutput('timeSeries'),
        plotOutput('cobweb')
    )
))