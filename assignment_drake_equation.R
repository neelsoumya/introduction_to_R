# Prompts to ChatGPT
#I want to create a fun assignment for my students I'm teaching introduction to our and for most of my students it is their first introduction to our programming language. I want to create a fun assignment around generating different simulations and scenarios from the Drake equation. Please give me some R code to generate some dummy synthetic data for the fraction of planets which will have an advanced civilization in it. This is a parameter in the Drake equation.
#Please give me complete functioning R code that will generate synthetic data.
#Please also generate some R code that will create some simulations from the drag equation.

#ChatGPT said:
#ChatGPT
#Creating a fun assignment based on the Drake Equation for your students is a fantastic idea! Here's some R code to help generate synthetic data and simulate scenarios using the Drake Equation.

#Part 1: Generate Synthetic Data for the Fraction of Planets with Advanced Civilizations (f_c)


# Load required libraries
set.seed(123)  # For reproducibility

# Generate synthetic data for `f_c`
generate_fc_data <- function(n = 100) {
  # Generate `f_c` as random fractions between 0 and 1
  f_c <- runif(n, min = 0, max = 1)
  
  # Add some variability to mimic uncertainty
  noise <- rnorm(n, mean = 0, sd = 0.1)
  f_c <- pmax(0, pmin(f_c + noise, 1))  # Ensure values stay between 0 and 1
  
  # Create a data frame
  data.frame(Planet_ID = 1:n, Fraction_Advanced_Civilizations = f_c)
}

# Generate the data
fc_data <- generate_fc_data()
head(fc_data)

# save data frame
write.csv(x = fc_data, file = "drake_dummy_data.csv", row.names = FALSE)

# Function to simulate the Drake Equation
simulate_drake <- function(n = 1000) {
  # Randomly sample parameter values
  R_star <- rnorm(n, mean = 5, sd = 1)   # Star formation rate (stars/year)
  f_p <- runif(n, min = 0.1, max = 0.5)  # Fraction of stars with planets
  n_e <- rpois(n, lambda = 1) + 1        # Planets that could support life
  f_l <- runif(n, min = 0.01, max = 1)   # Life arising fraction
  f_i <- runif(n, min = 0.01, max = 1)   # Intelligent life fraction
  f_c <- runif(n, min = 0.01, max = 1)   # Communicative civilization fraction
  L <- rnorm(n, mean = 10000, sd = 5000) # Civilization lifetime (years)
  
  # Calculate N for each scenario
  N <- R_star * f_p * n_e * f_l * f_i * f_c * L
  
  # Create a data frame
  data.frame(R_star, f_p, n_e, f_l, f_i, f_c, L, N)
}

# Generate simulation data
drake_simulations <- simulate_drake()
head(drake_simulations)



# Load ggplot2 for visualization
library(ggplot2)

# Histogram of civilizations
ggplot(drake_simulations, aes(x = N)) +
  geom_histogram(binwidth = 10, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Communicative Civilizations (N)",
       x = "Number of Civilizations", y = "Frequency") +
  theme_minimal()

# Relationship between `f_c` and `N`
ggplot(drake_simulations, aes(x = f_c, y = N)) +
  geom_point(alpha = 0.5) +
  labs(title = "Impact of f_c on N",
       x = "Fraction of Planets with Advanced Civilizations (f_c)",
       y = "Number of Communicative Civilizations (N)") +
  theme_minimal()
