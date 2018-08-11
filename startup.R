# devtools::install_github("aedobbyn/owmr", ref = "dev")
suppressPackageStartupMessages({
  library(ggplot2)
  library(glue)
  library(gmailr)
  library(here)
  library(owmr)
  library(tidyverse)
  library(xtable)
})

source(here("keys.R"))

owmr_settings(api_key = openweathermap_key)
