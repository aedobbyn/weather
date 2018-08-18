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

# dobtools would not install on server, so copying these two funs here instead
style_numeric <- function(df, digits = 3, add_commas = FALSE, dont_add_commas = NULL) {
  year_cols <- names(df)[c(which(names(df) == "year"), which(names(df) ==
                                                               "Year"))]
  if (!is.null(dont_add_commas)) {
    year_cols <- c(year_cols, dont_add_commas)
  }
  if (length(year_cols) > 0) {
    non_year_cols <- names(df)[-which(names(df) == year_cols)]
  }
  else {
    non_year_cols <- names(df)
  }
  df <- df %>%
    purrr::map_if(is.numeric, round, digits = digits) %>%
    tibble::as_tibble()
  if (add_commas == TRUE) {
    for (col in names(df)) {
      if (is.numeric(df[[col]]) & !(col %in% year_cols)) {
        df[[col]] <- df[[col]] %>% (scales::comma_format())()
      }
    }
    message(paste0("Adding commas to columns: ", stringr::str_c(non_year_cols,
                                                                collapse = ", "
    )))
  }
  return(df)
}


replace_na_df <- function(df, replacement = "") {
  out <- df %>% replace(is.na(.), "")
  return(out)
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

tomorrows_weather <- function(tbl) {
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

# todays_weather <- function()


