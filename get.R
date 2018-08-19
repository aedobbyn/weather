source(prepend_root_dir("startup.R"))
source(prepend_root_dir("utils.R"))

forecast_raw <- get_forecast("11238")
current_raw <- get_current("11238")

forecast_clean <- raw_forecast %>% clean_forecast() 
current_clean <- current_raw %>% clean_current() 

forecast_pretty <- forecast_clean %>% prettify()
current_pretty <- current_clean %>% prettify()

tomorrow_forecast <- forecast_pretty %>% grab_tomorrow()

# gist <- summarise_weather(clean)
