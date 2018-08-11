library(here)
source(here("startup.R"))
source(here("utils.R"))

raw <- get_raw_forecast("11238")

clean <- clean_raw(raw)

gist <- summarise_weather(clean)
