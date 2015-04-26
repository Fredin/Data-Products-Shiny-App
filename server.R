
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
logisticMap<- function (r,x0,n,k){
    # r sets the parameter, x sets initial condition, n sets the number of
    # iterations and k sets the number of iterations to be discarded.
    xn<-as.vector(x0)
    xnp1<-as.vector(NULL)
    for (i in seq_len(n)){
        xnp1[i]<- as.vector(r*xn[i]*(1-xn[i]))
        xn[i+1]<-xnp1[i]
    }
    xn<-xn[-n+1]
    results<-data.frame(xn,xnp1)
    if (k != 0) results<- results[-seq_len(k),1:2]
    return(results)
}

shinyServer(
    function(input, output) {
        output$timeSeries <- renderPlot({
            df<-logisticMap(input$r,input$x0,input$n,input$k)
            plot(df$xn, xlab='Iterations', ylab='x',main='Discreet Time Series of X')})
        output$cobweb <- renderPlot({
            df<-logisticMap(input$r,input$x0,input$n,input$k)
            curve(input$r*x*(1-x),from = 0, to= dim(df$xn), lwd= 2,
                  xlab=expression('x'[n]), ylab=expression('x'[n+1]),main='Cobweb Diagram')
            lines(df$xn,df$xnp1, type="s", col="red")
            abline(a=0, b=1, col="blue")})
    }
)
