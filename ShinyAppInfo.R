library(shiny)

#Feature 1: Putting in x amount of money will generate x returns at closing today. 
# Define UI for application that draws a histogram


#Feature 2: If I invested X amount of money in x year it would be worth X amount today. 
# Define UI for application that draws a histogram

# Application title
titlePanel("How Much Investment is Worth"),


#Feature 3: Creates a graph that shows the stock fluctuation over the years. 
# Define UI for application that draws a histogram
ui <- fluidPage(  
  
  titlePanel("Stock Price Fluctuation"),
  selectInput("selected", label = h3("Select Company"), 
              choices = list("SPG" = 1, "PEP" = 2, "TSLA" = 3,"AMZN" = 4, 'FB'=5 ), 
              selected = 1),
  
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
  
)
server <- function(input, output) {
  #output$value <- renderPrint({ input$select }),
  #output$plot <- renderPlot({input$graph})
  output$plot <- renderPlot({
    new<-filter(dataframe, x,CompanyCode %in% input$selected)
    autoplot(new)
  })
  output$value <- renderPrint({ input$checkGroup})
  
}
shinyApp(ui = ui, server = server)
#Feature 4: Input date and it shows the prices for the stocks that day. 
# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Price per Stock on Different Days"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

