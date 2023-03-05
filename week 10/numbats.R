
# Week 10

# data & libraries


tuesdata <- tidytuesdayR::tt_load('2023-03-07')
tuesdata <- tidytuesdayR::tt_load(2023, week = 10)

numbats <- tuesdata$numbats

# Or read in the data manually

numbats <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-03-07/numbats.csv')