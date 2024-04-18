# Treść zadania:
# ====
# wygenerowac przykładowe dane na podstawie danych:
# Male:
#   Year: 1880
#     Avg height: 167.5 cm
#     Avg weight: 67.5 kg
#     BMI: 24.12
#   Year: 1980
#     Avg height: 175.5 cm
#     Avg weight: 77.5 kg
#     BMI: 25.18
# Female:
#   Year: 1880
#     Avg height: 154.5 cm
#     Avg weight: 52.5 kg
#     BMI: 22.01
#   Year: 1980
#     Avg height: 164.5 cm
#     Avg weight: 62.5 kg
#     BMI: 23.11
# dla wybranego kraju (dane zebrane dla Francji), w latach 1880 i 1980
# year,sex,country,weight,height,bmi
# ====

dgp_weights = function(n, sex, year, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  
  weight_mean <- 0
  weight_sd <- 0
  
  # Wagi dla mężczyzn
  if(sex == "male") {
    if(year == 1880) {
      weight_mean <- rnorm(n, mean = 70, sd = 5)
    } else if(year == 1980) {
      weight_mean <- rnorm(n, mean = 73, sd = 5)
    }
  }
  
  # Wagi dla kobiet
  if(sex == "female") {
    if(year == 1880) {
      weight_mean <- rnorm(n, mean = 60, sd = 5)
    } else if(year == 1980) {
      weight_mean <- rnorm(n, mean = 65, sd = 5)
    }
  }
  
  return(weight_mean)
}

# Przykładowe dane dla Francji w latach 1880 i 1980
country <- "France"
years <- c(1880, 1980)
sexes <- c("male", "female")

# Tworzenie pustego data.frame do przechowywania danych
data <- data.frame(matrix(ncol = 5, nrow = 0))
colnames(data) <- c("country", "year", "height", "sex", "weight")

# Generowanie danych dla każdej płci i każdego roku
for (year in years) {
  for (sex in sexes) {
    heights <- dgp_heights(n = 1000, seed = 123) # Generowanie wzrostu z funkcji dgp_heights
    weights <- dgp_weights(n = 1000, sex = sex, year = year, seed = 123) # Generowanie wagi
    new_data <- data.frame(country = country, 
                           year = rep(year, 1000), 
                           height = heights$height, 
                           sex = heights$sex, 
                           weight = weights)
    data <- rbind(data, new_data)
  }
}

# Wyświetlenie danych
head(data)