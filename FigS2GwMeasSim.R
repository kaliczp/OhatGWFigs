library(readxl)
top.gwmeassim <- as.data.frame(read_excel("talajvizszint_modell_eredmeny_GS_cikkbe.xlsx", range = "Munka1!L3:R3025", col_names = FALSE))
bot.gwmeassim <- as.data.frame(read_excel("talajvizszint_modell_eredmeny_GS_cikkbe.xlsx", range = "Munka1!L3026:R14612", col_names = FALSE))
gwmeassim <- rbind(top.gwmeassim, bot.gwmeassim)
colnames(gwmeassim) <- c("Date", "M2680", "S2680", "M2683", "S2683", "M2684", "S2684")

library(xts)
gwmeassim.xts <- xts(gwmeassim[,-1], as.Date(gwmeassim[,1]))

plot.zoo(gwmeassim.xts[,1:2], xaxs = "i")
