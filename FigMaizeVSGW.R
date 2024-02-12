library(readxl)
GWmaizeraw <- as.data.frame(read_excel("WG3_abra-adatok_Peternek.xlsx", range = "abra3!B5:F24", col_names = FALSE))
colnames(GWmaizeraw) <- c("Year", "GW", "Loam", "Clay","Sand")

## Soil
MaizeSoil <- t(GWmaizeraw[,c("Loam", "Clay", "Sand")])
colnames(MaizeSoil) <- GWmaizeraw$Year

## gw
GWmaize <- t(GWmaizeraw[["GW"]])
colnames(GWmaize) <- GWmaizeraw$Year

par(mar = c(5.1,4.1,1.1,4.1), las = 2)
barplot(MaizeSoil, beside = TRUE, ylim = c(0, 140), yaxt = "n", type = "n")
axis(4, at = seq(0,100, by = 20))
grid(nx=NA, ny = NULL)
barplot(MaizeSoil, beside = TRUE, ylim = c(0, 140), yaxt = "n", type = "n", add = TRUE)
par(new = TRUE)
barplot(GWmaize, ylim = c(14,0),
        xaxt = "n", yaxt = "n")
axis(2, at = seq(0,8,by = 2))
