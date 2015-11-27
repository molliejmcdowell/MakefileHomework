library(ggplot2)
suppressPackageStartupMessages(library(dplyr))
gapminderdf <- read.delim("gapminder.tsv")

plot2 <- ggplot(gapminderdf, 
								aes(x = continent, y = gdpPercap)) + 
	scale_y_log10() + 
	geom_jitter(position = position_jitter(width = 0.05, height = 0), alpha = 1/4) + 
	stat_summary(fun.y = min, colour = "darkblue", geom = "point", size = 4) + 
	stat_summary(fun.y = max, colour = "purple", geom = "point", size = 4) + 
	ggtitle("GDP Per Capita For Each Continent")

ggsave("GDPpercapVsContinent.png", plot2)
