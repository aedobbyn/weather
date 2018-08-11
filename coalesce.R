library(here)
suppressPackageStartupMessages(library(gmailr))
source(here("get.R"))

use_secret_file("weather.json")

msg <- mime() %>%
  to("amanda.e.dobbyn@gmail.com") %>%
  from("amanda.e.dobbyn@gmail.com") %>% 
  subject(glue("Forecast is {clean$description[2]} for tomorrow")) %>% 
  html_body(print(xtable(gist), type="html")) 

msg <- msg %>% 
  attach_file(here("plots", glue("{lubridate::today()}_temperature.svg")))
  # attach_file(here("plots", glue("{lubridate::today()}_rain.svg")))

send_message(msg)
