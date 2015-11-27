library(ggplot2)
suppressPackageStartupMessages(library(dplyr))
gapminderdf <- read.delim("gapminder.tsv")

plot1 <- ggplot(gapminderdf, 
								aes(x=gdpPercap, y=lifeExp)) + 
	scale_x_log10() + 
	geom_point(aes(color = continent)) + 
	ggtitle("Life Expectancy vs GDP Per Capita")

ggsave("LifeExpVsGDPpercap.png", plot1)
