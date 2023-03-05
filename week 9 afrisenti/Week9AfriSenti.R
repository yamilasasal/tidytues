
# TidyTuesday
# Week 9 
# The data this week comes from AfriSenti: Sentiment Analysis dataset for 14 African languages 
# via @shmuhammad2004 (the corresponding author on the associated paper, and an active member of the R4DS Online Learning Community Slack).


# load packages 
#install.packages("remotes")
#remotes::install_github("hrbrmstr/waffle")
#packageVersion("waffle")

#install.packages("here")



library(tidyverse)
library(skimr)
library(waffle)
library(tidytext)


# load data
afrisenti <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/afrisenti.csv')
languages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/languages.csv')
language_scripts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/language_scripts.csv')
language_countries <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/language_countries.csv')
country_regions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/country_regions.csv')

# wrangling
glimpse(afrisenti)
skim(afrisenti)
skim(language_countries)
skim(country_regions)

language_count <- afrisenti %>%
  group_by(language_iso_code) %>%
  count (label) %>%
  mutate(n_prop = n / sum(n)) %>%
  ungroup() %>%
  rename(language_label_count = n) %>%
  left_join(languages)

# plot
# How are the twits labeled in each language distributed?

p <- ggplot(language_count, aes(x=reorder(language,language_label_count), y=language_label_count, fill=label)) +
     geom_bar(stat="identity", width = 0.8) +
     coord_flip() +
     theme_bw() +
    scale_fill_manual(
    name = NULL,
    values = c("positive" = "blue",
               "neutral" = "lightblue",
               "negative" = "violet"))+
  labs( x="Languages", y = "Number of tagged Tweets", title="Tweets from 14 African languages tagged as")+
  theme(legend.position = "top")
  
ggsave(
  filename = here::here("Week 9 afrisenti/afrisenti.png"),
  plot = p, 
  height = 800, 
  width = 1200,
  unit = "px")

