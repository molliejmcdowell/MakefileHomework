library(ggplot2)
suppressPackageStartupMessages(library(dplyr))
gapminderdf <- read.delim("gapminder.tsv")

plot3 <- gapminderdf %>% 
	group_by(continent) %>% 
	summarize(wmean = weighted.mean(lifeExp,pop)) %>% 
	ggplot(aes(x = continent, y = wmean)) + 
	geom_bar(stat = 'identity', width=0.5) + 
	ggtitle("Weighted Mean of Life Expectancy For Each Continent")

ggsave("LifeExpWeightedMean.png", plot3)
