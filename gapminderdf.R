library(ggplot2)
suppressPackageStartupMessages(library(dplyr))

cat(file = "gapminder.tsv", RCurl::getURL("https://raw.githubusercontent.com/jennybc/gapminder/master/inst/gapminder.tsv"))

gapminderdf <- read.delim("gapminder.tsv")
write.table(gapminderdf, "gapminderdf.tsv", quote = FALSE, sep = "\t")

gapminderdf_maxlifeExp <- gapminderdf %>%
	group_by(continent) %>%
	summarize(maxlifeExp = max(lifeExp)) %>% 
	arrange(maxlifeExp)
write.table(gapminderdf_maxlifeExp, "gapminderdf_maxlifeExp.tsv", quote = FALSE, sep = "\t")

newgapminderdf <- gapminderdf %>%
	arrange(newcontinent = reorder(continent, desc(lifeExp)))
write.table(newgapminderdf, "newgapminderdf.tsv", quote = FALSE, sep = "\t")

plot1 <- ggplot(gapminderdf, 
	aes(x=gdpPercap, y=lifeExp)) + 
	scale_x_log10() + 
	geom_point(aes(color = continent)) + 
	ggtitle("Life Expectancy vs GDP Per Capita")
ggsave("LifeExpVsGDPpercap.png", plot1)

plot2 <- ggplot(gapminderdf, 
	aes(x = continent, y = gdpPercap)) + 
	scale_y_log10() + 
	geom_jitter(position = position_jitter(width = 0.05, height = 0), alpha = 1/4) + 
	stat_summary(fun.y = min, colour = "darkblue", geom = "point", size = 4) + 
	stat_summary(fun.y = max, colour = "purple", geom = "point", size = 4) + 
	ggtitle("GDP Per Capita For Each Continent")
ggsave("GDPpercapVsContinent.png", plot2)

plot3 <- gapminderdf %>% 
	group_by(continent) %>% 
	summarize(wmean = weighted.mean(lifeExp,pop)) %>% 
	ggplot(aes(x = continent, y = wmean)) + 
	geom_bar(stat = 'identity', width=0.5) + 
	ggtitle("Weighted Mean of Life Expectancy For Each Continent")
ggsave("LifeExpWeightedMean.png", plot3)

plot4 <- ggplot(gapminderdf, aes(x = year, y = lifeExp)) + 
	aes(color = continent) + geom_point() + 
	geom_smooth(lwd = 2, se = FALSE) + 
	ggtitle("Life Expectancy Change Over Time")
ggsave("LifeExpVsYear.png", plot4)

