setwd("C:/PI Projects/Amgen mobile user tracking")
rm(list=ls())
# Enbrel_RA_Mobile <- read.csv("Enbrel RA Mobile.csv")
# Enbrel_RA_UserDetail <- read.csv("RHUEMs - UserDetail data with flags.csv")
# Enbrel_RA <- merge()

Prolia <- read.csv("Prolia Universe - UserDetail data with flags.csv")
Prolia_tv <- read.csv("Prolia Topic Views.csv")
Prolia_sht <- read.csv("Prolia - Search Home Tab.csv")
Prolia_sfr <- read.csv("Prolia - Search From Rsc.csv")

#select matched records 
Prolia <- subset(Prolia, Total_PIH_EmailReach != 0)

Prolia_M <- merge(Prolia, Prolia_tv, by.x = "SkyscapeID", by.y = "SS.ID", all.x = TRUE)
Prolia_M <- merge(Prolia_M, Prolia_sht, by.x = "SkyscapeID", by.y = "SS.ID", all.x = TRUE)
Prolia_M <- merge(Prolia_M, Prolia_sfr, by.x = "SkyscapeID", by.y = "SS.ID", all.x = TRUE)

#count total matched records
prolia_match <- subset(Prolia_M, !is.na(Profession) | !is.na(Profession.x) | !is.na(Profession.y))
dim(prolia_match)

prolia_state <- ddply(prolia_match, .(State_cd), summarize, count = length(SkyscapeID))
prolia_state[order(-prolia_state$count),]

#--------------
#Enbrel -Derm

Enbrel_D <- read.csv("DERMS - UserDetail data with flags.csv")
Enbrel_D_tv <- read.csv("Enbrel Derm Topic Views.csv")
Enbrel_D_sht <- read.csv("Enbrel RA - Search Home Tab.csv")
Enbrel_D_sfr <- read.csv("Enbrel Derm - Search From Rsc.csv")
Enbrel_D_M <- merge(Enbrel_D, Enbrel_D_tv, by.x = "SkyscapeID", by.y = "SS.ID", all.x = TRUE)

Enbrel_D_M <- merge(Enbrel_D_M, Enbrel_D_sht, by.x = "SkyscapeID", by.y = "SS.ID", all.x = TRUE)
Enbrel_D_M <- merge(Enbrel_D_M, Enbrel_D_sfr, by.x = "SkyscapeID", by.y = "SS.ID", all.x = TRUE)
dim(subset(Enbrel_D_M, !is.na(Last.Name)))
dim(subset(Enbrel_D_M, !is.na(Last.Name.x)))
dim(subset(Enbrel_D_M, !is.na(Last.Name.y)))




#Enbrel - RA
Enbrel_RA <- read.csv("RHUEMs - UserDetail data with flags.csv")
Enbrel_RA <- subset(Enbrel_RA, Total_PIH_EmailReach != 0)

Enbrel_RA_tv <- read.csv("Enbrel RA Topic Views.csv")
Enbrel_RA_sht <- read.csv("Enbrel RA - Search Home Tab.csv")
Enbrel_RA_sfr <- read.csv("Enbrel RA - Search From Rsc.csv")
Enbrel_RA_M <- merge(Enbrel_RA, Enbrel_RA_tv, by.x = "SkyscapeID", by.y = "SS.ID", all.x = TRUE)
Enbrel_RA_M <- merge(Enbrel_RA_M, Enbrel_RA_sht, by.x = "SkyscapeID", by.y = "SS.ID", all.x = TRUE)
Enbrel_RA_M <- merge(Enbrel_RA_M, Enbrel_RA_sfr, by.x = "SkyscapeID", by.y = "SS.ID", all.x = TRUE)

Enbrel_RA_match <- subset(Enbrel_RA_M, !is.na(Profession) | !is.na(Profession.x) | !is.na(Profession.y))
dim(Enbrel_RA_match)
