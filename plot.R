library(here)
source(prepend_root_dir("get.R"))

temp_plot <- 
  clean %>% 
  ggplot(aes(dt, temp)) + 
  geom_smooth()

rain_plot <-
  clean %>% 
  ggplot(aes(date_time, rain_last_3h)) + 
  geom_smooth() +
  scale_x_datetime(date_labels = "%d %R",
                   date_breaks = "3 hours")
  
temp_plot %>% 
  ggsave(filename = glue("{lubridate::today()}_temperature.svg"),
         device = "svg", path = here("plots"))

temp_plot %>% 
  ggsave(filename = glue("{lubridate::today()}_rain.svg"), 
         device = "svg", path = here("plots"))

