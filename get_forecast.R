source(prepend_root_dir("startup.R"))
source(prepend_root_dir("utils.R"))

forecast_raw <- get_forecast("11238")
forecast_clean <- forecast_raw %>% clean_forecast() 
tomorrow_forecast <- forecast_clean %>% grab_tomorrow()
forecast_pretty <- forecast_clean %>% prettify()
