suppressPackageStartupMessages(library(dplyr))
gapminderdf <- read.delim("gapminder.tsv")
gapminderdf_maxlifeExp <- gapminderdf %>%
	group_by(continent) %>%
	summarize(maxlifeExp = max(lifeExp))
write.table(gapminderdf_maxlifeExp, "gapminderdf_maxlifeExp.tsv", quote = FALSE, sep = "\t")
