library(readxl)
gwraw <- as.data.frame(read_excel("WG3_abra-adatok_Peternek.xlsx", range = "abra1!B5:E14614", col_names = FALSE))
colnames(gwraw) <- c("Date", "gw2680", "gw2683", "gw2684")
library(xts)
gw.xts <- xts(gwraw[, -1], gwraw[,1])

plot.zoo(gw.xts$gw2680, ylim = c(-6,0), xaxs = "i", type = "n",
         xlab = "", ylab = "GWL [m below ground surface]")
lines(as.zoo(gw.xts$gw2680))
lines(as.zoo(gw.xts$gw2683))
lines(as.zoo(gw.xts$gw2684))
