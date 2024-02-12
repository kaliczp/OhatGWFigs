library(readxl)
maizeraw <- as.data.frame(read_excel("WG3_abra-adatok_Peternek.xlsx", range = "abra2!B5:D24", col_names = FALSE))
colnames(maizeraw) <- c("Year", "Country", "Sim")
