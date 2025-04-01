# load packages
librarian::shelf(shiny, shinydashboard, tidyverse, leaflet, shinycssloaders, fresh)

# read in data
lake_data <- read_csv("data/lake_data_processed.csv")