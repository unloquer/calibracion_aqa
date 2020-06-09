library(tidyverse)
library(plotly)

data <- read_csv("./data/datos_torreajedrez.csv")

colnames(data)

data$sta_siata.mean_pm25 <- data$sta_siata.mean_pm25 %>% lag(4)
data$sta_siata.mean_pm25[data$sta_siata.mean_pm25 <  -100] <- -1
data$date <- lubridate::mdy_hms(data$date)

data_g <- gather(data, -date,key = "sensor", value = "valor")

gg <- ggplot(data_g %>%
             filter(date > "2019-12-01", date < "2020-04-01"),
             aes(date, valor, color=sensor)) + geom_line(stat = "identity")
ggplotly(gg)

