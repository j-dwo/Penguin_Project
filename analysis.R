# load required packages
library(here)
library(tidyverse)

# Data came from: 
# https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-pal.88.7
alt_penguin_dat <- read.csv(here::here("penguin_data.csv"))

# Data came from:
# https://github.com/allisonhorst/palmerpenguins/blob/master/README.md
install.packages("palmerpenguins")
library(palmerpenguins)
penguin_dat <- penguins

adelie_dat_na <- penguins %>%
  filter(species == 'Adelie') %>% 
  select(species, body_mass_g, sex) 

adelie_dat <- adelie_dat_na %>% 
  drop_na()

penguin_dat %>% count(species)
