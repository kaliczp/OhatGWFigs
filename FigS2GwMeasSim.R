library(readxl)
top.gwmeassim <- as.data.frame(read_excel("talajvizszint_modell_eredmeny_GS_cikkbe.xlsx", range = "Munka1!L3:R3025", col_names = FALSE))
bot.gwmeassim <- as.data.frame(read_excel("talajvizszint_modell_eredmeny_GS_cikkbe.xlsx", range = "Munka1!L3026:R14612", col_names = FALSE))
gwmeassim <- rbind(top.gwmeassim, bot.gwmeassim)
colnames(gwmeassim) <- c("Date", "M2680", "S2680", "M2683", "S2683", "M2684", "S2684")

library(xts)
gwmeassim.xts <- xts(gwmeassim[,-1], as.Date(gwmeassim[,1]))

produce <- "pdf" # or "png"
if(produce == "png") {
png("FigS2GwMeasSim_2col.png", width = 190, height = 120, units = "mm", pointsize = 7, res = 300)
} else {
    pdf("FigS2GwMeasSim_2col.pdf", width = 190 / 25.4, height = 120 / 25.4, pointsize = 7)
}
par(oma = c(2.1,0,0.6,0.6), mar = c(0,4.1,0,0), las = 1, mfrow = c(3, 1))
actualylim <- c(3.5,-0.5)
for(nrgwwell in c(2680, 2683, 2684)) {
    if(nrgwwell > 2680) {
        actualylim <- actualylim + 1
    }
plot.zoo(gwmeassim.xts[, paste0("M",nrgwwell)], type = "n",
         xaxs = "i",
         xaxt = "n",
         ylim = actualylim,
         xlab = "", ylab = "GWL [m below ground surface]")
    legend("topleft", legend = paste(nrgwwell, "   "), col = "lightgray")
grid(nx=NA, ny = NULL)
points(as.zoo(gwmeassim.xts[, paste0("M",nrgwwell)]), pch = 16, col = "lightgray")
lines(as.zoo(gwmeassim.xts[, paste0("S",nrgwwell)]), lwd = 2, col = gwcolors[1])
}
axis(1, at = as.Date(c(paste0(1971:2010,"-01-01"),"2010-12-31")), lab = FALSE)
axis.Date(1, at = as.Date(paste0(c(1971,1980,1990,2000,2010), "-07-03")), tck = 0, format = "%Y")
legend("bottomleft", legend = c("Measured", "Simulated"), pch = c(16, NA), lwd = c(NA,2), col = c("lightgray", gwcolors[1]),  bg = "white", cex = 0.8)
box()
dev.off()
