library(here)
source(prepend_root_dir("startup.R"))
source(prepend_root_dir("utils.R"))

raw <- get_raw_forecast("11238")

clean <- clean_raw(raw)

gist <- summarise_weather(clean)
