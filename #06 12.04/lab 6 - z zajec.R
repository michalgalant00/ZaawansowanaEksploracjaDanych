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

country = 'FR'
countrySheetCode = groupSheet$key[groupSheet$code == country]
countryData = read_sheet(ss = countrySheetCode, sheet = country)




# zapis do pliku
saveRDS(countryData, file="c:/0_studia/zaawansowana eksploracja danych/lab/#06 12.04/france.RData")



# uzupełnić o porównanie chociaz z jednym krajem
# docelowo porownanie zbiorcze wszystkich krajów
