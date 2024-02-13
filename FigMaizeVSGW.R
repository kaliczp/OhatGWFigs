library(readxl)
GWmaizeraw <- as.data.frame(read_excel("WG3_abra-adatok_Peternek.xlsx", range = "abra3!B5:F24", col_names = FALSE))
colnames(GWmaizeraw) <- c("Year", "GW", "Loam", "Clay","Sand")

## Soil
MaizeSoil <- t(GWmaizeraw[,c("Loam", "Clay", "Sand")])
colnames(MaizeSoil) <- GWmaizeraw$Year

## gw
GWmaize <- t(GWmaizeraw[["GW"]])
colnames(GWmaize) <- GWmaizeraw$Year

gwcolors <- c("#2c7bb6", # blueish
              "#d7191c", # dark
              "#fdae61", # lighter
              "#ffffbf" # lightest
              )

png("Fig4MaizeVSGW.png", width = 90, height = 60, units = "mm", pointsize = 7, res = 300)
pdf("Fig4MaizeVSGW.pdf", width = 90 / 25.4, height = 60 / 25.4, pointsize = 7)
par(mar = c(3.1,4.1,0.6,4.1), las = 2)
barplot(MaizeSoil, beside = TRUE, ylim = c(0, 140), yaxt = "n", type = "n", col = NA)
axis(4, at = seq(0,100, by = 20))
grid(nx=NA, ny = NULL)
barplot(MaizeSoil, beside = TRUE, ylim = c(0, 140), yaxt = "n", add = TRUE, col = gwcolors[-1])
mtext("Maize yield increase [%]", side = 4, line = 3, at = 50, las = 3)
par(new = TRUE)
barplot(GWmaize, ylim = c(14,0),
        xaxt = "n", yaxt = "n", col = gwcolors[1])
axis(2, at = seq(0,8,by = 2))
mtext("GWL [m below surface]", side = 2, line = 3, at = 4, las = 3)
legend(1.8, 5, legend = c("GWL", "loam", "clay", "sand"), fill = gwcolors,  bg = "white", cex = 0.8)
box()
dev.off()
