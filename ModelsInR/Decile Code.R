rm(list = ls())
setwd("C:/PI Projects/Heatmap")
TRx <- read.csv("Enbrel_Market_TRx_Decile.csv", header = T)
TRx <- subset(TRx, ENBREL > 0)
TRx <- TRx[order(-TRx$ENBREL),]
TRx$cumsumEnbrel <- cumsum(TRx$ENBREL)
TRx$Decide_measure <- TRx$cumsumEnbrel/sum(TRx$ENBREL)

TRx$Enbrel_Decile <- 
  cut(TRx$Decide_measure, seq(from = 0, to = 1, by = 0.1), include.lowest=TRUE,lable=TRUE)


# Decile_table <- as.data.frame(matrix(nrow = 10, ncol = 2))
# names(Decile_table) <- c("Decile No.", "Percentage")
# Decile_table$`Decile No.` <- seq(from = 10, to = 1)
# Decile_table$Percentage <- seq(from = 0, to = 1, by = 0.1)


# WRONG!
# TRx$Enbrel_Decile <- 
#   cut(TRx$ENBREL,quantile(TRx$ENBREL,(0:10)/10),include.lowest=TRUE,lable=TRUE)
# quantile(TRx$ENBREL,(0:10)/10)


TRx <- TRx[order(-TRx$Total.Market.Prescriptions),]
TRx$cumsumMarket <- cumsum(TRx$Total.Market.Prescriptions)
TRx$Decide_measure <- TRx$cumsumMarket/sum(TRx$Total.Market.Prescriptions)

TRx$Market_Decile <- 
  cut(TRx$Decide_measure, seq(from = 0, to = 1, by = 0.1), include.lowest=TRUE,lable=TRUE)

TRx <- TRx[, -c(21,19,18)]

write.csv(TRx, "Enbrel_Market_TRx_Decile_2.csv")



# Enbrel_TRx <- read.csv("Enbrel_Market_TRx.csv", header = T)
# Enbrel_TRx <- subset(Enbrel_TRx, Prod == "ENBREL")
# write.csv(Enbrel_TRx, "Enbrel_Market_TRx.csv")
# remove(Enbrel_TRx)
# 
# Enbrel_NRx <- read.csv("Enbrel_Market_NRx.csv", header = T)
# Enbrel_NRx <- subset(Enbrel_NRx, Prod == "ENBREL")
# write.csv(Enbrel_NRx, "Enbrel_Market_NRx.csv")
# remove(Enbrel_NRx)
