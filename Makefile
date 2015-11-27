all: Homework9Report.html

clean:
	rm -f gapminder.tsv gapminderdf.tsv gapminderdf_maxlifeExp.tsv GDPpercapVsContinent.png LifeExpWeightedMean.png LifeExpVsYear.png LifeExpVsGDPpercap.png Homework9Report.html

gapminder.tsv:
	curl -O https://raw.githubusercontent.com/jennybc/gapminder/master/inst/gapminder.tsv

gapminderdf.tsv: gapminder.tsv gapminderdf.R
	Rscript gapminderdf.R

gapminderdf_maxlifeExp.tsv: gapminderdf.tsv gapminderdf_maxlifeExp.R
	Rscript gapminderdf_maxlifeExp.R

GDPpercapVsContinent.png: gapminder.tsv
	Rscript plot2.R

LifeExpWeightedMean.png: gapminder.tsv
	Rscript plot3.R

LifeExpVsYear.png: gapminder.tsv
	Rscript plot4.R

LifeExpVsGDPpercap.png: gapminder.tsv
	Rscript plot1.R

Homework9Report.html: Homework9Report.Rmd gapminder.tsv gapminderdf.tsv gapminderdf_maxlifeExp.tsv GDPpercapVsContinent.png LifeExpWeightedMean.png LifeExpVsYear.png LifeExpVsGDPpercap.png
	Rscript -e 'rmarkdown::render("$<")'