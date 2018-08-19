source(prepend_root_dir("startup.R"))
source(prepend_root_dir("utils.R"))

current_raw <- get_current("11238")
current_clean <- current_raw %>% clean_current() 
current_pretty <- current_clean %>% prettify()

diff_forecast <- 
  tomorrow_forecast %>% 
  add_diffs()


