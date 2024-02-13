library(readxl)
maizeraw <- as.data.frame(read_excel("WG3_abra-adatok_Peternek.xlsx", range = "abra2!B5:D24", col_names = FALSE))
colnames(maizeraw) <- c("Year", "Country", "Sim")

## data preparation
Maizesim <- t(maizeraw[,2:3])
colnames(Maizesim) <- maizeraw$Year

maizecolors <- gwcolors[2:3] # dark and lighter from FigMaizeVSGW.R

png("Fig3Maizeyield.png", width = 90, height = 60, units = "mm", pointsize = 7, res = 300)
pdf("Fig3Maizeyield.pdf", width = 90 / 25.4, height = 60 / 25.4, pointsize = 7)
par(mar = c(3.1,3.6,0.6,0.6), las = 2)
barplot(Maizesim, beside = TRUE, ylim = c(0,9), col = NA)
grid(nx=NA, ny = NULL)
barplot(Maizesim, beside = TRUE, ylim = c(0,9), col = maizecolors, add = TRUE)
mtext(expression(paste("Maize yield [", t %.% ha^{-1}, "]")), side = 2, line = 2.3, las = 3, at = 4)
legend("topleft", legend = c("Statistical county-level data", "Simulated for the loam profile"),
       fill = maizecolors,  bg = "white", cex = 0.8)
dev.off()
