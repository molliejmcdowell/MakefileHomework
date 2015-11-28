all: MakefileMarkdown.html

clean:
	rm -f gapminder.tsv gapminderdf.tsv gapminderdf_maxlifeExp.tsv newgapminderdf.tsv LifeExpVsGDPpercap.png GDPpercapVsContinent.png LifeExpWeightedMean.png LifeExpVsYear.png allcountries.tsv selectedcountriesdf.tsv africa.png asia.png europe.png americas.png

gapminder.tsv: gapminderdf.R
	Rscript gapminderdf.R

gapminderdf.tsv: gapminderdf.R gapminder.tsv
	Rscript gapminderdf.R

gapminderdf_maxlifeExp.tsv: gapminderdf.R gapminder.tsv
	Rscript gapminderdf.R

newgapminderdf.tsv: gapminderdf.R gapminder.tsv gapminderdf.tsv
	Rscript gapminderdf.R
	
LifeExpVsGDPpercap.png: gapminderdf.R gapminder.tsv gapminderdf.tsv
	Rscript gapminderdf.R
	rm Rplots.pdf

GDPpercapVsContinent.png: gapminderdf.R gapminder.tsv gapminderdf.tsv
	Rscript gapminderdf.R
	rm Rplots.pdf

LifeExpWeightedMean.png: gapminderdf.R gapminder.tsv gapminderdf.tsv
	Rscript gapminderdf.R
	rm Rplots.pdf

LifeExpVsYear.png: gapminderdf.R gapminder.tsv gapminderdf.tsv
	Rscript gapminderdf.R
	rm Rplots.pdf

allcountries.tsv: gapminderstatanalyses.R gapminder.tsv gapminderdf.tsv newgapminderdf.tsv
	Rscript gapminderstatanalyses.R

selectedcountriesdf.tsv: gapminderstatanalyses.R gapminder.tsv gapminderdf.tsv newgapminderdf.tsv
	Rscript gapminderstatanalyses.R

africa.png: gapminderstatanalyses.R selectedcountriesdf.tsv gapminder.tsv gapminderdf.tsv newgapminderdf.tsv
	Rscript gapminderstatanalyses.R
	rm Rplots.pdf

asia.png: gapminderstatanalyses.R selectedcountriesdf.tsv gapminder.tsv gapminderdf.tsv newgapminderdf.tsv
	Rscript gapminderstatanalyses.R
	rm Rplots.pdf

europe.png: gapminderstatanalyses.R selectedcountriesdf.tsv gapminder.tsv gapminderdf.tsv newgapminderdf.tsv
	Rscript gapminderstatanalyses.R
	rm Rplots.pdf

americas.png: gapminderstatanalyses.R selectedcountriesdf.tsv gapminder.tsv gapminderdf.tsv newgapminderdf.tsv
	Rscript gapminderstatanalyses.R
	rm Rplots.pdf

MakefileMarkdown.html: MakefileMarkdown.Rmd gapminder.tsv gapminderdf.tsv gapminderdf_maxlifeExp.tsv newgapminderdf.tsv LifeExpVsGDPpercap.png GDPpercapVsContinent.png LifeExpWeightedMean.png LifeExpVsYear.png allcountries.tsv selectedcountriesdf.tsv africa.png asia.png europe.png americas.png
	Rscript -e 'rmarkdown::render("$<")'