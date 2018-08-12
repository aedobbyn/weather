# devtools::install_github("aedobbyn/owmr", ref = "dev")
suppressPackageStartupMessages({
  library(dobtools)
  library(ggplot2)
  library(glue)
  library(gmailr)
  library(here)
  library(owmr)
  library(tidyverse)
  library(xtable)
})

source(prepend_root_dir("keys.R"))

owmr_settings(api_key = openweathermap_key)
