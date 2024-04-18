#generowanie danych
#====
dgp_heights <- function(n, sex, year, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  year = as.character(year)
  
  # Definicja średnich wartości wzrostu w zależności od płci i roku
  avg_height <- data.frame(
    Year = c(1880, 1980),
    Male = c(167.5, 175.5),
    Female = c(154.5, 164.5)
  )
  
  # Wybór danych dla danej płci i roku
  avg_values <- subset(avg_height, Year == year)[[sex]]
  
  # Generowanie danych
  height <- rnorm(n, mean = avg_values, sd = 6)
  
  return(round(height, 2))
}

dgp_weights <- function(n, sex, year, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  year = as.character(year)
  
  # Definicja średnich wartości wagi w zależności od płci i roku
  avg_weight <- data.frame(
    Year = c(1880, 1980),
    Male = c(67.5, 77.5),
    Female = c(52.5, 62.5)
  )
  
  # Wybór danych dla danej płci i roku
  avg_values <- subset(avg_weight, Year == year)[[sex]]
  
  # Generowanie danych
  weight <- rnorm(n, mean = avg_values, sd = 10)
  
  return(round(weight, 2))
}

dgp_bmis <- function(heights, weights) {
  # Obliczanie BMI
  bmis <- weights / ((heights / 100) ^ 2)
  
  return(round(bmis, 2))
}

# Przykładowe użycie
set.seed(2137)  # Ustawienie ziarna dla reprodukowalności
h= dgp_heights(10, "Male", 1980)
w= dgp_weights(10, "Male", 1980)
dgp_bmis(h, w)

#====
#zapis tych danych do arkusza

library(googlesheets4)

# Tworzenie arkusza kalkulacyjnego
mysheet <- gs4_create("mojsheet", sheets = list(FR=NULL, Overview=NULL))
mysheet_key <- '1ax3aMHKLFYyJb0yjgvWClt8wTpflUVqIHkNuVXC26Lo'  # Ustawianie klucza arkusza

# Funkcja do generowania danych i zapisywania ich do arkusza
generate_and_write_data <- function(n, year, sex) {
  # Generowanie danych
  heights <- dgp_heights(n, sex, year)
  weights <- dgp_weights(n, sex, year)
  bmis <- dgp_bmis(heights, weights)
  
  header <- data.frame(
    year = 'year',
    sex = 'sex',
    country = 'country',
    weight = 'weight',
    height = 'height',
    bmi = 'bmi'
  )
  
  # Tworzenie ramki danych
  mydata <- data.frame(
    year = rep(year, n),
    sex = rep(sex, n),
    country = rep("FR", n),  # Zakładam, że kraj to zawsze Francja
    weight = weights,
    height = heights,
    bmi = bmis
  )
  
  # Zapisywanie danych do arkusza kalkulacyjnego
  sheet_append(data=mydata, ss=mysheet_key, sheet='FR')
}

# Generowanie i zapisywanie danych dla każdego roku i płci
years <- c(1880, 1980)
sexes <- c("Male", "Female")

header <- data.frame(
  year = 'year',
  sex = 'sex',
  country = 'country',
  weight = 'weight',
  height = 'height',
  bmi = 'bmi'
)

sheet_append(data=header, ss=mysheet_key, sheet='FR')
for (year in years) {
  for (sex in sexes) {
    generate_and_write_data(2000, year, sex)
  }
}

#====
#pobranie odpowiednich danych z grupowego arkusza i wprowadzenie ich do mojego
library(googlesheets4)

fetch_country_data <- function(country_codes, sheets_key) {
  # Ładowanie arkusza z danymi krajów i ich arkuszy
  country_sheets <- read_sheet(sheets_key, sheet='GR_1630')
  
  for (country_code in country_codes) {
    # Pobieranie kodu arkusza dla danego kraju
    sheet_code <- country_sheets$key[country_sheets$code == country_code]
    
    if (length(sheet_code) == 0) {
      warning(paste("Nie znaleziono kodu arkusza dla kraju:", country_code))
      next
    }
    
    # Pobieranie danych z arkusza dla danego kraju
    data <- read_sheet(sheet_code)
    
    # Zapisywanie danych do odpowiedniej zakładki w arkuszu kalkulacyjnym
    sheet_write(data, sheets_key, sheet = country_code)
  }
}

# Przykładowe użycie
country_codes <- c('FR', 'RU', 'GC')
sheets_key <- '1H01vA6z_M8BCl5MvaZ5QeIY4ctrQ8lzk_NI5ZDp3a80'  # Klucz arkusza zbiorczego
sheet_name <- 'GR_1630'

fetch_country_data(country_codes, sheets_key)





























