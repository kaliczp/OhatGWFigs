library(readxl)
GWmaizeraw <- as.data.frame(read_excel("WG3_abra-adatok_Peternek.xlsx", range = "abra3!B5:F24", col_names = FALSE))
colnames(GWmaizeraw) <- c("Year", "GW", "Loam", "Clay","Sand")
