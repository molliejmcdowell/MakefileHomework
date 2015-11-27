library(ggplot2)
suppressPackageStartupMessages(library(dplyr))
gapminderdf <- read.delim("gapminder.tsv")

plot4 <- ggplot(gapminderdf, aes(x = year, y = lifeExp)) + 
	aes(color = continent) + geom_point() + 
	geom_smooth(lwd = 2, se = FALSE) + 
	ggtitle("Life Expectancy Change Over Time")

ggsave("LifeExpVsYear.png", plot4)
