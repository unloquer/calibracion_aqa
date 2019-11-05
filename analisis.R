library(tidyverse)
library(plotly)

data <- read_csv("./datos_torreajedrez.csv")

data$sta_siata.mean_pm25 <- data$sta_siata.mean_pm25 %>% lag(4)
data$sta_siata.mean_pm25[data$sta_siata.mean_pm25 <  -100] <- -1

data_g <- gather(data, -time,key = "sensor", value = "valor")

gg <- ggplot(data_g, aes(time, valor, color=sensor)) + geom_line(stat = "identity")
ggplotly(gg)


g <- ggplot(data, aes(time)) +
    geom_line(aes(y = sta_siata.mean_pm25, colour = "red"), stat = "identity") +
    geom_line(aes(y = aqa_explora_1.mean_pm25, colour = "blue"), stat = "identity") +
    geom_line(aes(y = aqa_explora_2.mean_pm25, colour = "green"), stat = "identity") +
    geom_line(aes(y = aqa_explora_3.mean_pm25, colour = "purple"), stat = "identity")

ggploty(g)
