# INTRO TO GOOGLESHEET4
# https://googlesheets4.tidyverse.org/articles/find-identify-sheets.html

# DPLYR
# https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
# https://dplyr.tidyverse.org/reference/mutate.html#grouped-tibbles
# How to process data with dplyr
# https://pbiecek.github.io/IntRoduction/part-25.html
--------------------------------------------------------------------------------
# install and load googlesheet4 package:
library(googlesheets4)
library(dplyr)
library(ggplot2)

# Verify if there are any authorized users
gs4_deauth()
gs4_auth()
# or using common account: 
gs4_auth(email="zed.pollub@gmail.com") # pwd: Pollub2024!

# population - data sources
gsheet_key <- "1H01vA6z_M8BCl5MvaZ5QeIY4ctrQ8lzk_NI5ZDp3a80"

gr_1230 <- read_sheet(gsheet_key,sheet="GR_1230")
gr_1445 <- read_sheet(gsheet_key,sheet="GR_1445")
gr_1630 <- read_sheet(gsheet_key,sheet="GR_1630")
gr_1815 <- read_sheet(gsheet_key,sheet="GR_1815")

# CHECK gr_1445
dataset <- gr_1630 # %>% filter( code == "NL")
id <- 12
#dataset[9,]
dta_tmp <- read_sheet(dataset$key[id],dataset$code[id])
head(dta_tmp)
summary(dta_tmp)
summary(as.factor(dta_tmp$sex))   # note: sex:


# dplyr - basic
gr_1815 %>% select(country,code,key)

select(gr_1815,country,code,key)

# select two columns and two countries
dataset <- gr_1815 %>% 
  select(country,code,key) %>%
  filter(code=="AU" | code == "ZA" | code == "GR")
    
dataset

# --- read data set 2
dataset <- gr_1815 %>% filter( code == "NL")


dta_2 <- read_sheet(dataset$key,dataset$code)
head(dta_2)
summary(dta_2)
summary(as.factor(dta_2$sex))   # note: sex: 0, 1

# --- read data set 3
dataset <- gr_1815 %>% filter( code == "AU")
dta_3 <- read_sheet(dataset$key,dataset$code)
head(dta_3)
glimpse(dta_3)
View(dta_3)
summary(dta_3)
summary(as.factor(dta_3$sex))

# CHECK FOR MISSING DATA ... () # note: sex: man, female
# WE NEED TO FIX 'sex' code
# FUN:  filter(), select(), arrange(), mutate() group_by() / ungroup(), summarize(), gather(), spread()
head(dta_2)

# MANIPULATE DATA / CLEAN DATA SETS /  
dta_2 %>% 
  mutate(sex2 = ifelse(sex == 0, "female", "male")) %>%        # fix coding
  select(-sex) %>%                                             # drop column 'sex'
  rename(sex = sex2) %>%                                       # rename 'sex2' to 'sex'
  select(country,year, height, weight, sex) -> dta_2_cleaned   # arrange columns

# transmute(): the same in one line:
dta_2 %>% 
  transmute(country, year, height, weight
            ,sex = ifelse(sex == 0, "female", "male"))

dta_2_cleaned %>% 
  top_n(50) %>%                                                # show 20 top rows
  sample_n(30) %>%                                             # sample randomly 10 obs.
  tail()                                                       # show last rows

# CLEAN dta_3
head(dta_3)
dta_3_cleaned <- dta_3 %>% transmute(
                              country, year, height, weight,
                              sex = ifelse(sex=="man","male","female")
                            )

# Combine data sets: example
dta_3_cleaned %>% head(5) -> tmp1
dta_2_cleaned %>% select(sex,country,year,height,weight) %>% head(5) -> tmp2

tmp1; tmp2
tmp1 %>% union(tmp2)

# Combine two data sets into a single dataset: population
dta_3_cleaned %>% 
  union(dta_2_cleaned) -> population

population %>% sample_n(10)   # quick check

# SAVE FINAL DATA: save() - save external representation of R objects
saveRDS(population,file="../data/population.RData")

# ------------------------------------------------------------------------------
# READ AND SUMARIZE DATA
dta <- readRDS(file="../data/population.RData")

# basic summary - notice country and sex statistics:
dta %>% summary() 

# much better with factors:
dta %>% mutate(country=factor(country),sex = factor(sex)) %>% summary()

dta_f <- dta %>% mutate(country=factor(country),sex = factor(sex))
# keep going with summarise()

dta_f %>% summarise(avg_h=mean(height),
                    sd_h = sd(height),
                    iqr_h = IQR(height)
                    )

# group_by() : now more fancy and meaningful summarise'ing:
sum_tab <- dta_f %>% group_by(sex,country) %>% 
      summarise(
                h_min = min(height),
                h_avg= round(mean(height),2),
                h_max = max(height),                
                h_sd = sd(height),
                h_iqr = IQR(height)
                ) %>%  ungroup() 

# PIVOTS: wider and longer
sum_tab %>%   # filter(sex=="female") %>% 
  pivot_wider(names_from = year, values_from = c(h_avg)) -> aaa

aaa %>% pivot_longer(cols = c('1880','1980'),names_to = "year" , values_to = "h_avg")

View(summary_tab)
# ------------------------------------------------------------------------------
# install.packages("kableExtra")
library(kableExtra)
# https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html
# https://bookdown.org/yihui/rmarkdown-cookbook/tables.html
# vs. 1
summary_tab %>% kbl()
# vs. 2
summary_tab %>% kbl() %>%
  kable_paper("hover", full_width = F)
# vs. 3
summary_tab %>% kbl() %>%
  kable_minimal()
# vs. 4
table <- kable(summary_tab, caption = "Population sumamry", format = "html",digits=2) %>%
  kable_styling(bootstrap_options = "striped", full_width = FALSE)

print(table)
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# PLOTS with ggplot2 package.
# FUNCTIONS:ggplot(), geom_points(), facet_wrap()

# prepare data set.
dta_plot <- dta_3 %>% sample_n(500)  %>% mutate(year=factor(year))

# basic dot_plot
ggb <- ggplot(data=dta_plot,mapping=aes(x=height,y=weight)) + geom_point()

# add one dimension: color for years
ggc <- ggplot(data=dta_plot,mapping=aes(x=height,y=weight,color=year))  + geom_point()

# add new layer with model fit
ggb + geom_smooth(method="lm",se=F)  # lm: linear regression
ggc + geom_smooth(method="loess")    # loess: local polynomial regression 

# facet_wrap() - podzia³ wykresu wg. okre¶lonej cechy
ggc + geom_smooth(method="lm",se=F) +
  facet_wrap(facets=vars(sex))

# ------------------------------------------------------------------------------
# BOX-PLOT
# Wykres pude³kowy lub czasami potocznie ramka-w±sy co odzwierciedla jego kszta³t. 
# Pozwala on przedstawiæ rozk³ad zmiennej losowej. Granice ???pude³ka??? to odpowiednio
# pierwszy i trzeci kwartyl (Q1,Q3) a linia w ¶rodku to mediana rozk³adu 
# zmiennej losowej. 
# W±sy obejmuj± obserwacje o warto¶ci odleg³ej od Q1 i Q3 o nie wiêcej 
# ni¿ 1.5 rozstêpu miêdzykwartylowego (Interquartile range - IQR). 
# Obserwacje odleg³e (outliers) oznaczone s± jako odzielne punkty wykresu.

# https://pl.wikipedia.org/wiki/Wykres_pude%C5%82kowy#/media/Plik:Boxplot_vs_PDF.svg
# https://pl.wikipedia.org/wiki/Wykres_pude%C5%82kowy#/media/Plik:Elements_of_a_boxplot_en.svg

ggplot(data = dta_plot, mapping = aes(x = height,fill=year)) + 
  geom_boxplot()

ggplot(data = dta_plot, mapping = aes(x=sex, y = height,fill=year)) + 
  geom_boxplot()

# ------------------------------------------------------------------------------
# geom_jitter()
ggplot(data = dta_plot, mapping = aes(x=year, y = height,fill=year)) + 
  geom_boxplot()+
  geom_jitter(alpha=0.4,height=0.39,width=0.2)

# ------------------------------------------------------------------------------
# geom_rug()
ggplot(data = dta_plot, mapping = aes(x=year, y = height,fill=year)) + 
  geom_boxplot()+
  geom_jitter(alpha=0.4,height=0.39,width=0.2) + 
  geom_rug()
# ------------------------------------------------------------------------------
# WYKRES WIOLINOWY: geom_violin()
# Ten wykres ³±czy w sobie cechy histogramu oraz wykresu pude³kowego (boxplot).

  ggplot(data = dta_plot, mapping = aes(x=sex, y = height,fill=year)) +
  geom_violin(trim=F) +
  geom_boxplot(width=0.1, color="white",fill="white", alpha=0.2)+
  geom_jitter(alpha=0.3) + 
  geom_rug()

# ------------------------------------------------------------------------------
# HISTOGRAM: geom_histogram()

ggplot(data = dta_plot, mapping = aes(x=height, fill=year)) + 
  facet_wrap(facets=vars(sex))+
  geom_histogram(bins=30)

# DENSITY: density()
# Do histogramu dopasujemy funkcjê gêsto¶ci. 
# Dopasowanie funkcji gêsto¶ci metod± KDE: Kernel Density Estimation 

ggplot(data = dta_plot, mapping = aes(x=height)) + 
  geom_histogram(aes(y = after_stat(density)),bins=30,color="black",fill="lightgrey")+
  geom_density(col="blue",lwd=1.3,lty=1)
# ==============================================================================
