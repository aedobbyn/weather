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

kelvin_to_fahrenheit <- function(x) {
  (x - 273)*1.8 + 32
}

un_kelvin <- function(tbl) {
  tbl %>% 
    mutate_at(vars(contains("temp")), 
              funs(kelvin_to_fahrenheit))
}

clean_raw <- function(tbl) {
  tbl %>% 
    nix_mains() %>% 
    mutate(
      date_time = dt_txt %>% lubridate::as_datetime(),
      description = weather %>% 
        pluck_weather("description")
    ) %>% 
    rename(
      rain_last_3h = rain_3h,
      cloud_perc = clouds_all
    ) %>% 
    select(dt, date_time, description,
           starts_with("temp"), -temp_kf, # an internal param
           rain_last_3h, cloud_perc, 
           wind_speed, humidity
    ) %>% 
    un_kelvin() 
}


summarise_weather <- function(tbl) {
  tbl %>% 
    style_numeric() %>% 
    replace_na_df() %>% 
    mutate(
      date_time = as.character(date_time)
    ) %>%  
    separate(date_time, into = c("date", "time"), " ") %>% 
    mutate(time = str_remove_all(time, ":[0-9:]+")) %>% 
    select(-dt) %>% 
    filter(date == lubridate::today() + 1)    # Grab just tomorrow
}

