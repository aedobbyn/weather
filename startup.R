devtools::install_github("aedobbyn/owmr", ref = "dev")
library(owmr)
library(here)
library(tidyverse)

source(here("keys.R"))

owmr_settings(api_key = openweathermap_key)

get_raw_forecast <- function(zip, simplify = TRUE, ...) {
  get_forecast(zip = zip, 
               simplify = simplify)
}

pluck_weather <- function(x, col) {
  x[[1]][[col]]
}

nix_mains <- function(tbl) {
  names(tbl) <- names(tbl) %>% 
    map_chr(str_replace_all, "main_", "")
  
  tbl
}

clean_raw <- function(tbl) {
  tbl %>% 
    nix_mains() %>% 
    mutate(
      description = weather %>% 
        pluck_weather("description")
    ) %>% 
    rename(
      rain_last_3h = rain_3h
    ) %>% 
    select(dt, dt_txt, description,
           starts_with("temp"),
           humidity, clouds_all, wind_speed,
           rain_last_3h)
}

raw <- get_raw_forecast("11238")

clean <- clean_raw(raw)



