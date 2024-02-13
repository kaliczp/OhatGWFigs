library(readxl)
gwraw <- as.data.frame(read_excel("WG3_abra-adatok_Peternek.xlsx", range = "abra1!B5:E14614", col_names = FALSE))
colnames(gwraw) <- c("Date", "gw2680", "gw2683", "gw2684")
library(xts)
gw.xts <- xts(gwraw[, -1], as.Date(gwraw[,1]))

par(mar = c(2.1,4.1,0.6,0.6), las = 1)
plot.zoo(gw.xts$gw2680, ylim = c(-5,0), type = "n",
         xaxs = "i", yaxs = "i",
         xaxt = "n",
         xlab = "", ylab = "GWL [m below ground surface]")
grid(nx=NA, ny = NULL)
lines(as.zoo(gw.xts$gw2680), lwd = 2, col = gwcolors[1])
lines(as.zoo(gw.xts$gw2683), lwd = 2, col = gwcolors[2])
lines(as.zoo(gw.xts$gw2684), lwd = 2, col = gwcolors[3])
axis(1, at = as.Date(c(paste0(1971:2010,"-01-01"),"2010-12-31")), lab = FALSE)
axis.Date(1, at = as.Date(paste0(c(1971,1980,1990,2000,2010), "-07-03")), tck = 0, format = "%Y")
