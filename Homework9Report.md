# Gapminder Makefile
Mollie  
November 26, 2015  

I downloaded the gapminder dataset from the internet and wrote it as a dataframe. Next, I reordered the continents by maximum life expectancy and wrote that table into another dataframe.


```r
gapminderdf <- read.delim("gapminder.tsv")
gapminderdf_maxlifeExp <- read.delim("gapminderdf_maxlifeExp.tsv")
```

I created four plots: life expectancy versus GDP per capita in each country, GDP per capita on each continent, the weighted mean of life expectancy for each continent, and life expectancy change over time. 

![*Fig. 1* Life Expectancy vs GDP Per Capita](LifeExpVsGDPpercap.png)

![*Fig. 2* GDP Per Capita For Each Continent](GDPpercapVsContinent.png)

![*Fig. 3* Weighted Mean of Life Expectancy For Each Continent](LifeExpWeightedMean.png)

![*Fig. 4* Life Expectancy Change Over Time](LifeExpVsYear.png)
