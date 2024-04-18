library(googlesheets4)

# w get_data.R jest lepszy sposób na pobieranie tego
my_sheet = '1ax3aMHKLFYyJb0yjgvWClt8wTpflUVqIHkNuVXC26Lo'
ru_key = '1-YBrffZR3DpufEjgCZDlzDy2nQMqbXwm-13Gv5EpogQ'
gc_key = '1xeIC0p1SK9OzBDT8FnmnZCTTI79xU8c-qqV5zc2Bvp4'
  
my_data = read_sheet(ss = my_sheet, sheet = 'FR')
ru_data = read_sheet(ss = ru_key, sheet = 'RU')
gc_data = read_sheet(ss = gc_key, sheet = 'GC')

head(ru_data)
head(gc_data)
head(my_data)

library(dplyr)
library(ggplot2)

my_data %>%
  union(ru_data) %>%
  union(gc_data) -> dta_combined
  
saveRDS(dta_combined,file="c:/0_studia/zaawansowana eksploracja danych/lab/#05 05.04/allData.RData")

#====
#praca na odczytanym RData - get_data.R



# praca z danymi (jak na lab)
# rysowanie wykresów do kompletu danych
# przejrzec generowanie i zapisywanie danych
# naprawic zbiory i zeby bmi bylo obliczane a nie generowane XD

#shiny? i flexdashboards - pakiety na nastepne laby
