# dokumentacja googlesheets4 na tidyverse
library(googlesheets4)

gs4_deauth()

gs4_auth()
gs4_auth(email = "s95401@pollub.edu.pl")

gs4_create()
gs4_create("test_sheet")

ss = gs4_create("zed_test_1", sheets = list(Poland=NULL, Germany=NULL))

gsheet_key = '1WcoYqxUAbespdnZR9xSPLXhq8pjWZA45xtMXmkAH3D4'
tmp = read_sheet(gsheet_key, sheet=1)

dta = data.frame(x=rnorm(10),y=rnorm(10))

sheet_write(dta, gsheet_key, sheet='Poland')
# sheet_write(dta, gsheet_key, sheet='Germany')

sheet_append(gsheet_key, dta, sheet='Poland')

new_column = data.frame(z=rnorm(10))

range_write(gsheet_key, new_column, sheet='Poland', range='J')


range_clear(gsheet_key, sheet = 'Poland', range = 'J')
range_clear(gsheet_key, sheet = 'Poland', range = 'J2:J4')


new_rectangle = data.frame(col1=c(1,2),col2=c(3,4),col3=c(5,6))

range_write(gsheet_key, new_rectangle, sheet = 'Poland', range = 'C1:E3', col_names = T)

# ====

ss %>% sheet_add()

sheet_add(ss)

ss %>% sheet_add('PL', .after = 1)
ss %>% sheet_add('DE', .after = 'PL')
ss %>% sheet_add(c('ES', 'US'))
ss %>%
  sheet_add(
    sheet = 'overview',
    .before = 1,
    gridProperties = list(
      rowCount = 3, columnCount = 6, frozenRowCount = 1
    )
  )

sheet_names(ss)
sheet_relocate(ss, 'Overview', .after='US')

# zadanie
# swoj spreadsheet na moje dane wygenerowane wczesniej (wzrosty i wagi)
# 3 zakladki
# opis zbioru (intro)
# dane (FR)
# podsumowanie (overview)


# tym wygeneruje dane wzrost,rok,plec,waga - zastosowac to do informacji z moimi srednimi per francja
dgp_heights <- function(n, coutry = "France", year= "1980", seed=NULL){
  
  if(!is.null(seed)) set.seed(seed)
  
  x1 <- sample(c(0,1),n,replace=TRUE, prob = c(0.5,0.5))
  eps <- rnorm(n, m=0, sd=1)
  
  y <- 164.7 + (13.7)*x1 + (1-x1)*7.07*eps + x1*7.59*eps
  
  sex <- factor(x1)
  levels(sex) <- c("female", "male")
  # res <- data.frame(height=round(y,2), year=year, sex=sex, weight=round(y,2))
  res <- data.frame(year=year,sex=sex,country=country,height=round(y,2),weight=round(y-105,2))
  
  return(res)
}




mysheet = gs4_create("mojsheet", sheets = list(FR=NULL, Overview=NULL))
mysheet_key = '1ax3aMHKLFYyJb0yjgvWClt8wTpflUVqIHkNuVXC26Lo' # ten juz edytowac pod standaryzacje

my_height_data = dgp_heights(n = 100)
sheet_write(dta, mysheet_key, sheet='FR')


dawid_key = '1C6AX32Te41O3OymYOTemB3_oLoqbl51sSzQOyQeQxUg'
sheet_write(my_height_data, dawid_key, sheet='FR')



# zadanie za tydzien
# dostanie sie ktore kraje
# polaczenie danych z roznych krajow
# narysowac histogram, zrobic jakies zestawienia

#standaryzacja
#arkusz ma nazywac sie wartością z Code (sprdsht z danymi ma sie tak nazywac)
#year,sex,country,weight,height,bmi*

#   *bmi - todo, dodac to datasetu







