library(readxl)
top.gwmeassim <- as.data.frame(read_excel("talajvizszint_modell_eredmeny_GS_cikkbe.xlsx", range = "Munka1!L3:R3025", col_names = FALSE))
bot.gwmeassim <- as.data.frame(read_excel("talajvizszint_modell_eredmeny_GS_cikkbe.xlsx", range = "Munka1!L3026:R14612", col_names = FALSE))
gwmeassim <- rbind(top.gwmeassim, bot.gwmeassim)
colnames(gwmeassim) <- c("Date", "M2680", "S2680", "M2683", "S2683", "M2684", "S2684")

library(xts)
gwmeassim.xts <- xts(gwmeassim[,-1], as.Date(gwmeassim[,1]))

produce <- "pdf" # or "png"
if(produce == "png") {
png("FigS2GwMeasSim_2col.png", width = 190, height = 60, units = "mm", pointsize = 7, res = 300)
} else {
    pdf("FigS2GwMeasSim_2col.pdf", width = 190 / 25.4, height = 60 / 25.4, pointsize = 7)
}
par(mar = c(2.1,4.1,0.6,0.6), las = 1)
plot.zoo(gwmeassim.xts$M2680, type = "n",
         xaxs = "i",
         xaxt = "n",
         ylim = c(3,0),
         xlab = "", ylab = "GWL [m below ground surface]")
grid(nx=NA, ny = NULL)
points(as.zoo(gwmeassim.xts$M2680), pch = 16, col = "lightgray")
lines(as.zoo(gwmeassim.xts$S2680), lwd = 2, col = gwcolors[1])
axis(1, at = as.Date(c(paste0(1971:2010,"-01-01"),"2010-12-31")), lab = FALSE)
axis.Date(1, at = as.Date(paste0(c(1971,1980,1990,2000,2010), "-07-03")), tck = 0, format = "%Y")
legend("bottomleft", legend = c("Measured", "Simulated"), pch = c(16, NA), lwd = c(NA,2), col = c("lightgray", gwcolors[1]),  bg = "white", cex = 0.8)
box()
dev.off()
