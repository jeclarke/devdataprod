library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("EPL Predictor - by James Clarke"),
  h4("For Developing Data Products, June 2015"),
  p("This app predicts a premier league position given relative spending on footballers' wages."),
  p("1. Pick a club"),
  p("2. Decide where they sit in a ranking of wage spend"),
  p("3. Use the slider to select the chosen ranking"),
  p("4. Bet on the predicted league position"),
  p("5. Profit!!!!"),
  
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("rank",
                  "Spend on wages",
                  min = 1,
                  max = 20,
                  value = 1),
      h5("1 = spends the most in league"),
      h5("20 = spends the least in league")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h6("Predicted position:"),
      verbatimTextOutput("predictedPosition"),
      h6("With 95% confidence of it between:"),
      verbatimTextOutput("lowerInterval"),
      h6("and"),
      verbatimTextOutput("upperInterval"),
      h6("And historic range between:"),
      verbatimTextOutput("lowerRange"),
      h6("and"),
      verbatimTextOutput("upperRange")
    )
  )
))
