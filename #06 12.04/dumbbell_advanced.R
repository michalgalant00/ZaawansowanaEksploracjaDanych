# ADD FULL COUNTRY NAMES
# from the spreadsheet file

library(ggplot2)
library(kableExtra)
library(tidyverse)
# ------------------------------------------------------------------------------
# DUMBBELL PLOT and Population data analysis

# Read country data - group 1230
dta <- readRDS("../data/gr_1230_clean.RData")

# ---  EXAMPLE 1 - look into 1880
dta_sum <- dta %>% filter(year=="1880") %>% 
  group_by(country,sex) %>% 
  summarise(
    height= round(mean(height),2)
  ) %>%  ungroup() 

# data is in long format. Transform into short format
# --- PIVOTS: 
# Pivot WIDER 
dta_sum
dta_sum_wide <- dta_sum %>% pivot_wider(names_from = sex, values_from = height) %>%
  mutate(mf_diff=male-female,mf_dif_perc = 100*(male-female)/female)

table <- kable(dta_sum_wide, caption = "Avarage population height in 1880 by country", format = "html",digits=1) %>%
  kable_styling(bootstrap_options = "striped", full_width = FALSE)

print(table)

# --- PIVOT LONGER
dta_sum_wide
dta_sum_wide %>% pivot_longer(cols = c('female','male'),names_to = "sex", values_to = "height") %>%
  arrange(mf_diff) -> dta_sum_long -> dta_plot
View(dta_sum_long)

dta_sum_long %>% 
  mutate(country = fct_reorder(country, mf_diff)) -> dta_plot
# ------------------------------------------------------------------------------
# GET Country names - use inner_join()

library(googlesheets4)
library(dplyr)
gsheet_key <- "1H01vA6z_M8BCl5MvaZ5QeIY4ctrQ8lzk_NI5ZDp3a80"
gs4_deauth()
gs4_auth()

ctr <- read_sheet(gsheet_key,"Countries")
ctr

# USE inner_join() function - merge data sets
dta_sum_long %>% 
  pivot_wider(names_from=sex, values_from=height) %>%
  
  inner_join(ctr,by=join_by(country==code)) %>% # join tables
  
  pivot_longer(cols=c("female","male"),names_to="gender",values_to="height") %>%
  mutate(code=country) %>% select(-c(country,sheet,group)) %>% mutate(country = name) %>%
  select(country,code,gender,height,diff=mf_diff,perc=mf_dif_perc) %>% 
  mutate(country = fct_reorder(country, diff)) -> dta_plot

dta_plot  
# ------------------------------------------------------------------------------
# A BIT MORE ADVANCED DUMBBELL PLOT
# library(glue)
# library(ggtext)

blue <- "#0171CE"
red <- "#DE0102"

dta_plot

dta_plot %>% 
  ggplot(aes(x = height, y = country)) +
  geom_line(linewidth = 3, color = "grey") +
  geom_point(aes(color = gender), size = 3, show.legend = FALSE) +
  scale_color_brewer(palette = "Set1", direction = 1) +
  theme(legend.position = "right") +
  
  # add lables
  geom_text(data=filter(dta_plot, country=="Czarnogóra" & gender == "female"),
          aes(x=height, y=country, label="Female"),
          color=red, size=3, vjust=-1.5, fontface="bold", family="Lato") +
  
  geom_text(data=filter(dta_plot, country=="Czarnogóra" & gender == "male"),
            aes(x=height, y=country, label="Male"),
            color=blue, size=3, vjust=-1.5, fontface="bold", family="Lato") +
  
  # add numeric values
  geom_text(data=filter(dta_plot, gender == "female"),
          aes(x=height, y=country, label=height),
          color=red, size=2.75, vjust=2.5, family="Lato") +
  
  geom_text(data=filter(dta_plot, gender == "male"),
            aes(x=height, y=country, label=height),
            color=blue, size=2.75, vjust=2.5, family="Lato") +

# ADD DIFFERENCE COLUMN
  geom_rect(data=dta_plot, aes(xmin=190, xmax=200, ymin=-Inf, ymax=Inf), fill="#EBEBEB") +
  geom_text(data=dta_plot, aes(label=paste0(diff, "%"), y=country, x=195), fontface="bold", size=3, family="Lato") +
  geom_text(data=filter(dta_plot, country=="Czarnogóra"),
            aes(x=195, y=country, label="Difference"),
            color="black", size=3.1, vjust=-2, fontface="bold", family="Lato") + 
  scale_x_continuous(expand=c(0,0), limits=c(130, 200)) +
  scale_y_discrete(expand=c(0.1,0)) + 

# TITLE, LABELS, CAPTION
labs(x=NULL, y=NULL, title="Man were not always higher then woman.",
     subtitle="How did the average height varied across coutries at the end of 19th century \nand what did it mean for Belgium?",
     caption="Source: Los Demiurgos de Pollub, April, 2024. \n\nDesigned by {Your_Name}") +

# BEAUTIFICATION
theme_bw(base_family="Lato") +
  theme(
    panel.grid.major=element_blank(),
    panel.grid.major.y = element_line(color = "grey",size=0.3),
    panel.grid.minor=element_blank(),
    panel.border=element_blank(),
    axis.ticks=element_blank(),
    axis.text.x=element_blank(),
    plot.title=element_text(size = 16, face="bold"),
    plot.title.position = "plot",
    plot.subtitle=element_text(face="italic", size=12, margin=margin(b=12)),
    plot.caption=element_text(size=8, margin=margin(t=12), color="#7a7d7e")
  )
          
ggsave("../outputs/dumbbell_01.jpg")  





