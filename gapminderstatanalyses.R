library(broom)
suppressPackageStartupMessages(library(dplyr))
library(ggplot2)

##import newgapminderdf
newgapminderdf <- read.delim("newgapminderdf.tsv")

##make sure new continent order is still in force
head(newgapminderdf)
tail(newgapminderdf)

##fit a linear regression of life expectancy on year within each country
thefit <- function(dat, offset=1952){
	stopifnot(is.data.frame(dat))
	gapminderaugment <- augment(lm(lifeExp ~ I(year - offset), dat))
	gapminderaugment
}
allcountries <- newgapminderdf %>% group_by(country) %>%  do(thefit(.))
str(allcountries)

##write to file
write.table(allcountries, "allcountries.tsv", quote = FALSE, sep = "\t")

##find the 3 or 4 “worst” and “best” countries for each continent. I'm excluding Oceania because of lack of data). I'm finding the countries with the single highest or lowest life expectancies.

newgapminderdf %>% filter(continent == "Asia") %>% arrange(desc(lifeExp)) %>% head(30)
##Highest life expectancy: Japan, China, Israel

newgapminderdf %>% filter(continent == "Asia") %>% arrange(desc(lifeExp)) %>% tail(30)
##Lowest life expectancy: Afghanistan, Cambodia, Republic of Yemen

newgapminderdf %>% filter(continent == "Americas") %>% arrange(desc(lifeExp)) %>% head(30)
##Highest life expectancy: Canada, Costa Rica, Puerto Rico

newgapminderdf %>% filter(continent == "Americas") %>% arrange(desc(lifeExp)) %>% tail(30)
##Lowest life expectancy: Haiti, Bolivia, Honduras

newgapminderdf %>% filter(continent == "Africa") %>% arrange(desc(lifeExp)) %>% head(30)
##Highest life expectancy: Reunion, Libya, Tunisia

newgapminderdf %>% filter(continent == "Africa") %>% arrange(desc(lifeExp)) %>% tail(30)
##Lowest life expectancy: Rwanda, Gambia, Angola

newgapminderdf %>% filter(continent == "Europe") %>% arrange(desc(lifeExp)) %>% head(30)
##Highest life expectancy: Iceland, Switzerland, Spain

newgapminderdf %>% filter(continent == "Europe") %>% arrange(desc(lifeExp)) %>% tail(30)
##Lowest life expectancy: Turkey, Bosnia and Herzegovina, Albania

selectedcountries <- c("Japan", "China", "Israel", "Afghanistan", "Cambodia", "Yemen, Rep.", "Canada", "Costa Rica", "Puerto Rico", "Haiti", "Bolivia", "Honduras", "Reunion", "Libya", "Tunisia", "Rwanda", "Gambia", "Angola", "Iceland", "Switzerland", "Spain", "Turkey", "Bosnia and Herzegovina", "Albania")

selectedcountriesdf <- newgapminderdf %>% filter(country %in% selectedcountries) %>% group_by(country, continent, year) %>% do(thefit(.))

##write to file
write.table(selectedcountriesdf, "selectedcountriesdf.tsv", quote = FALSE, sep = "\t")

africadf <- selectedcountriesdf %>% filter(continent == "Africa")

africa <- ggplot(africadf, 
	aes(x=year, y=lifeExp)) + 
	geom_point(aes(color = country)) + 
	facet_wrap(~ country) +
	ggtitle("Africa: Life Expectancy Over Time")
ggsave("africa.png", africa)

asiadf <- selectedcountriesdf %>% filter(continent == "Asia")

asia <- ggplot(asiadf, 
	aes(x=year, y=lifeExp)) + 
	geom_point(aes(color = country)) + 
	facet_wrap(~ country) +
	ggtitle("Asia: Life Expectancy Over Time")
ggsave("asia.png", asia)

europedf <- selectedcountriesdf %>% filter(continent == "Europe")

europe <- ggplot(europedf, 
	aes(x=year, y=lifeExp)) + 
	geom_point(aes(color = country)) + 
	facet_wrap(~ country) +
	ggtitle("Europe: Life Expectancy Over Time")
ggsave("europe.png", europe)

americasdf <- selectedcountriesdf %>% filter(continent == "Americas")

americas <- ggplot(americasdf, 
	aes(x=year, y=lifeExp)) + 
	geom_point(aes(color = country)) + 
	facet_wrap(~ country) +
	ggtitle("Americas: Life Expectancy Over Time")
ggsave("americas.png", americas)