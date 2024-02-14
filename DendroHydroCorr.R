library(readxl)
dendrohydroraw <- as.data.frame(read_excel("Dendro-HydroCorr_abra.xlsx", range = "CorrelationPlot!B1:T3"))
colnames(dendrohydroraw) <- c(tolower(month.abb[5:12]),month.abb[1:9], "pSep-pDec", "JJA")

dendrohydrosignif <- dendrohydroraw
dendrohydrosignif[2,] <- NA
dendrohydrosignif[1,dendrohydrosignif[1,] < 0.256] <- NA
colnames(dendrohydrosignif) <- NULL
dendrohydrosignif <- as.matrix(dendrohydrosignif)


produce <- "pdf" # or "png"
if(produce == "png") {
    png("DendroHydroCorr.png", width = 90, height = 60, units = "mm", pointsize = 7, res = 300)
} else {
    pdf("DendroHydroCorr.pdf", width = 90 / 25.4, height = 60 / 25.4, pointsize = 7)
}
par(mar = c(5.4,4.1,0.6,0.6), las = 2)
barplot(matrix(NA, nrow = nrow(dendrohydrosignif), ncol = ncol(dendrohydrosignif)), beside = TRUE, ylim = c(-0.5, 0.5), border = gwcolors[1:2], col = gwcolors[1:2], ylab = "", axes = FALSE, ann = FALSE)
grid(nx=NA, ny = NULL)
barplot(as.matrix(dendrohydroraw), beside = TRUE, ylim = c(-0.5, 0.5), col = "white", border = gwcolors[1:2], add = TRUE)
barplot(dendrohydrosignif, beside = TRUE, ylim = c(-0.5, 0.5), border = gwcolors[1:2], col = gwcolors[1:2], ylab = "", axes = FALSE, add = TRUE, ann = FALSE)
mtext("Correlation coefficient", side = 2, line = 3, las = 3)
legend("bottomleft", c("Precipitation", "Gwdepth"), fill = gwcolors[1:2],  border = gwcolors[1:2], bty = "n") 
dev.off()
