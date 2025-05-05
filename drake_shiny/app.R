# Load necessary libraries
library(shiny)
library(ggplot2)

# Define the user interface
ui <- fluidPage(
  titlePanel("Drake Equation Simulator"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("n_samples", "Number of Samples:", value = 10000, min = 1000, max = 100000),
      sliderInput("R_star", "Star Formation Rate (R*):", min = 1, max = 10, value = c(1, 10)),
      sliderInput("f_p", "Fraction of Stars with Planets (f_p):", min = 0.1, max = 0.5, value = c(0.1, 0.5)),
      sliderInput("n_e", "Number of Habitable Planets per Star (n_e):", min = 0.1, max = 2, value = c(0.1, 2)),
      sliderInput("f_l", "Fraction of Habitable Planets with Life (f_l):", min = 0.01, max = 1, value = c(0.01, 1)),
      sliderInput("f_i", "Fraction of Planets with Intelligent Life (f_i):", min = 0.01, max = 1, value = c(0.01, 1)),
      sliderInput("f_c", "Fraction of Civilizations that Communicate (f_c):", min = 0.01, max = 1, value = c(0.01, 1)),
      sliderInput("L", "Longevity of Civilizations (L):", min = 100, max = 10000, value = c(100, 10000)),
      actionButton("simulate", "Simulate")
    ),
    
    mainPanel(
      plotOutput("plot"),
      verbatimTextOutput("summary")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Reactive data for simulation
  simulation <- eventReactive(input$simulate, {
    set.seed(123)  # For reproducibility
    
    # Generate random samples
    R_star <- runif(input$n_samples, input$R_star[1], input$R_star[2])
    f_p <- runif(input$n_samples, input$f_p[1], input$f_p[2])
    n_e <- runif(input$n_samples, input$n_e[1], input$n_e[2])
    f_l <- runif(input$n_samples, input$f_l[1], input$f_l[2])
    f_i <- runif(input$n_samples, input$f_i[1], input$f_i[2])
    f_c <- runif(input$n_samples, input$f_c[1], input$f_c[2])
    L <- runif(input$n_samples, input$L[1], input$L[2])
    
    # Compute N (Drake equation results)
    N <- R_star * f_p * n_e * f_l * f_i * f_c * L
    return(N)
  })
  
  # Plot output
  output$plot <- renderPlot({
    N <- simulation()
    ggplot(data.frame(N = N), aes(x = N)) +
      geom_histogram(bins = 50, fill = "blue", color = "black", alpha = 0.7) +
      labs(
        title = "Distribution of Drake Equation Results",
        x = "Number of Communicative Civilizations (N)",
        y = "Frequency"
      ) +
      theme_minimal()
  })
  
  # Summary output
  output$summary <- renderPrint({
    N <- simulation()
    summary(N)
  })
}

# Run the application
shinyApp(ui = ui, server = server)