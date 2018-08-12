message(glue::glue("It is currently {lubridate::now()}."))

root_dir <- getwd()
prepend_root_dir <- function(path) {
  glue::glue("{root_dir}/{path}")
}

source(prepend_root_dir("get.R"))

# gmail_auth()
# use_secret_file(prepend_root_dir("weather.json"))

msg <- mime() %>%
  to("amanda.e.dobbyn@gmail.com") %>%
  from("amanda.e.dobbyn@gmail.com") %>% 
  subject(glue("Forecast is {clean$description[2]} for tomorrow")) %>% 
  html_body(print(xtable(gist), type="html")) 

# msg <- msg %>%
#   attach_file(here("plots", glue("{lubridate::today()}_temperature.svg"))) %>%
#   attach_file(here("plots", glue("{lubridate::today()}_rain.svg")))

send_message(msg)
