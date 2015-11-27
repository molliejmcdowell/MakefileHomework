gapminderdf <- read.delim("gapminder.tsv")
write.table(gapminderdf, "gapminderdf.tsv", quote = FALSE, sep = "\t")
