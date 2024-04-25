#wytyczne
#====
# 1. opis swoich danych (dataset)
# 2. wykresy swoich danych
# 3. dumbbell plot


library(googlesheets4)
library(dplyr)

# pobranie danych i zapisanie do pliku .RData
groupSheetKey = '1H01vA6z_M8BCl5MvaZ5QeIY4ctrQ8lzk_NI5ZDp3a80'
groupSheet = read_sheet(ss = groupSheetKey, sheet = 'GR_1630')


# dla pojedynczego kraju

country = 'FR'
countrySheetCode = groupSheet$key[groupSheet$code == country]
countryData = read_sheet(ss = countrySheetCode, sheet = country)

# zapis danych o pojedynczym kraju do pliku
saveRDS(countryData, file="c:/0_studia/zaawansowana eksploracja danych/lab/#06 12.04/france.RData")



# dla wszystkich krajów

keysWithCodes = data.frame(key = groupSheet$key,
                           code = groupSheet$code)

datas = data.frame(year = NULL,
                   sex = NULL,
                   country = NULL,
                   weight = NULL,
                   height = NULL,
                   bmi = NULL)

for (i in seq_len(nrow(keysWithCodes))) {
  k = keysWithCodes[i, "key"]
  c = keysWithCodes[i, "code"]
  
  loadedDta = read_sheet(ss = k, sheet = c)
  
  datas <- bind_rows(datas, loadedDta)
}


head(datas)
unique(datas$year)
unique(datas$sex)
unique(datas$country)

# czyszczenie danych
datas = datas %>%
  mutate(sex = ifelse(sex == "Male", "male", ifelse(sex == "Female", "female", sex)))

datas = datas %>%
  mutate(country = ifelse(country == "Afghanistan", "AF", country)) %>%
  mutate(country = ifelse(country == "Serbia", "RS", country)) %>%
  mutate(country = ifelse(country == "Sri Lanka", "LK", country)) %>%
  mutate(country = ifelse(country == "Chile", "CL", country)) %>%
  mutate(country = ifelse(country == "Nepal", "NP", country)) %>%
  mutate(country = ifelse(country == "Estonia", "EE", country))



saveRDS(datas, file="c:/0_studia/zaawansowana eksploracja danych/lab/#06 12.04/allCountries.RData")








