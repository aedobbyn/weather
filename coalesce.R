library(here)
# set_here("/Users/amanda/Desktop/Projects/weather")

root_dir <- "/Users/amanda/Desktop/Projects/weather"
prepend_root_dir <- function(path) {
  glue::glue("{root_dir}/{path}")
}
suppressPackageStartupMessages(library(gmailr))
source(prepend_root_dir("get.R"))

# use_secret_file("weather.json")

msg <- mime() %>%
  to("amanda.e.dobbyn@gmail.com") %>%
  from("amanda.e.dobbyn@gmail.com") %>% 
  subject(glue("Forecast is {clean$description[2]} for tomorrow")) %>% 
  html_body(print(xtable(gist), type="html")) 

# msg <- msg %>% 
  # attach_file(here("plots", glue("{lubridate::today()}_temperature.svg"))) %>% 
  # attach_file(here("plots", glue("{lubridate::today()}_rain.svg")))

send_message(msg)
