source(prepend_root_dir("startup.R"))
source(prepend_root_dir("utils.R"))

raw_forecast <- get_forecast("11238")
raw_current <- get_current("11238")

forecast <- raw_forecast %>% clean_forecast() %>% prettify()
current <- raw_current %>% clean_current() %>% prettify()

tomorrow_forecast <- forecast %>% grab_tomorrow()

# gist <- summarise_weather(clean)
