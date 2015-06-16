library(shiny)

csv <- data.frame(read.csv("premierleague.csv"))
names(csv) <- c("year","spend","position")

ranked <- transform(csv, 
                    year.rank = ave(spend, year, 
                                    FUN = function(x) rank(-x, ties.method = "first"))
)

mod <<- lm(position~1 + year.rank, ranked)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  predicted <- reactive({
    new.df <- data.frame("year.rank" = c(input$rank))
    pred <- data.frame(predict(mod, new.df, interval="predict"))
   })
  
  output$predictedPosition <- renderText({
     round(predicted()[1,1])
  })
  
  output$lowerRange <- renderText({
    max(1,round(predicted()[1,2]))
  })
  
  output$upperRange <- renderText({
    min(20,round(predicted()[1,3]))
  })
  
  output$lowerInterval <- renderText({
    min(ranked[ranked$year.rank == input$rank,]$position)
  })
  
  output$upperInterval <- renderText({
    max(ranked[ranked$year.rank == input$rank,]$position)  
  })
  
})