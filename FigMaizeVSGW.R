library(readxl)
GWmaizeraw <- as.data.frame(read_excel("WG3_abra-adatok_Peternek.xlsx", range = "abra3!B5:F24", col_names = FALSE))
colnames(GWmaizeraw) <- c("Year", "GW", "Loam", "Clay","Sand")

## Prec
PrecYearRaw <- as.data.frame(read_excel("Ohat_yearly_PREC.xlsx"))
PrecYear <- t(PrecYearRaw[,2])
colnames(PrecYear) <- PrecYearRaw[,1]

## Soil
MaizeSoil <- t(GWmaizeraw[,c("Loam", "Clay", "Sand")])
# colnames(MaizeSoil) <- GWmaizeraw$Year

## gw
GWmaize <- t(GWmaizeraw[["GW"]])
colnames(GWmaize) <- GWmaizeraw$Year

gwcolors <- c("#4575b4", # blueish
              "#d73027", # dark
              "#f46d43", # lighter
              "#fdae61", # lightest
              "#abd9e9" # light blueish
              )

produce <- "pdf" # or "png"
if(produce == "png") {
png("Fig4MaizeVSGW.png", width = 90, height = 110, units = "mm", pointsize = 7, res = 300)
} else {
pdf("Fig4MaizeVSGW.pdf", width = 90 / 25.4, height = 110 / 25.4, pointsize = 7)
}
layout(matrix(1:2,ncol=1),heights=c(3,1))
par(mar = c(0,4.1,0.6,4.1), las = 2)
barplot(matrix(NA ,ncol = ncol(MaizeSoil), nrow = nrow(MaizeSoil)), beside = TRUE, ylim=c(0,120),axes=FALSE)
axis(4, at = seq(0,100, by = 20))
grid(nx=NA, ny = NULL)
barplot(MaizeSoil, beside = TRUE, ylim = c(0, 120), yaxt = "n", add = TRUE, col = gwcolors[2:4], border = NA, axes = FALSE)
mtext("Maize yield increase [%]", side = 4, line = 3, at = 50, las = 3)
par(new = TRUE)
barplot(PrecYear, ylim = c(3000,0), border = NA, space = 1,
        xaxt = "n", yaxt = "n", col = gwcolors[1])
axis(2, at = seq(0,1000,by = 250))
mtext(expression(paste("PREC [", mm %.% year^{-1}, "]")), side = 2, line = 2.8, at = 500, las = 3)
par(mar = c(3.5,4.1,0,4.1), las = 2)
barplot(GWmaize, ylim = c(2,0), border = NA, space = 1,
        , col = gwcolors[5])
mtext("GWL [m below surface]", side = 2, line = 3, at = 1, las = 3)
legend(x = "bottomright", legend = c("PREC", "loam", "clay", "sand", "GWL"), fill = gwcolors, border = gwcolors, inset = c(-0.17, -0.08), xpd = TRUE, cex = 0.9)
dev.off()
