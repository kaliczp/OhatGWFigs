library(readxl)
maizeraw <- as.data.frame(read_excel("WG3_abra-adatok_Peternek.xlsx", range = "abra2!B5:D24", col_names = FALSE))
colnames(maizeraw) <- c("Year", "Country", "Sim")

## data preparation
Maizesim <- t(maizeraw[,2:3])
colnames(Maizesim) <- maizeraw$Year

maizecolors <- gwcolors[2:3] # dark and lighter from FigMaizeVSGW.R

par(mar = c(3.1,4.6,0.6,4.1), las = 2)
barplot(Maizesim, beside = TRUE, ylim = c(0,9), col = NA)
grid(nx=NA, ny = NULL)
barplot(Maizesim, beside = TRUE, ylim = c(0,9), col = maizecolors)
mtext(expression(paste("Maize yield [", t %.% ha^{-1}, "]")), side = 2, line = 3, las = 3, at = 4)
