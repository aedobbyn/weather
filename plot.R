library(ggplot2)

bk %>% 
  ggplot(aes(dt, main_temp)) + 
  geom_smooth()