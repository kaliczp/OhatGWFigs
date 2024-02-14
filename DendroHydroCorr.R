library(readxl)
dendrohydroraw <- as.data.frame(read_excel("Dendro-HydroCorr_abra.xlsx", range = "CorrelationPlot!B1:T3"))
colnames(dendrohydroraw) <- c(tolower(month.abb[5:12]),month.abb[1:9], "pSep-pDec", "JJA")

produce <- "pdf" # or "png"
if(produce == "png") {
    png("DendroHydroCorr.png", width = 90, height = 60, units = "mm", pointsize = 7, res = 300)
} else {
    pdf("DendroHydroCorr.pdf", width = 90 / 25.4, height = 60 / 25.4, pointsize = 7)
}
par(mar = c(5.3,4.1,0.6,0.6), las = 2)
barplot(as.matrix(dendrohydroraw), beside = TRUE, ylim = c(-0.5, 0.5), col = "white", border = gwcolors[1:2], ylab = "Correlation coefficient")
dev.off()
