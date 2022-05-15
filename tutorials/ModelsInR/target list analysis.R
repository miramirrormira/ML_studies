
setwd("C:/PI Projects/Merck Dulera")
dulera <- read.csv("DUL PI Match List July 2014 (7-10-2014).csv")
#num of rows:
dim(dulera)

#dupes and NA of IDs
head(dulera)
length(unique(dulera$Customer.ID))

length(unique(dulera$MedEd))
sum(is.na(dulera$MedEd))

length(unique(dulera$AOA))
sum(is.na(dulera$AOA))
anyDuplicated(dulera$AOA)

length(unique(dulera$IMSRef))
sum(is.na(dulera$IMSRef))
anyDuplicated(dulera$IMSRef)

#address
#get full address
dulera$Address <- paste(dulera$Street.Address.1, dulera$City, dulera$State, sep = ',')
sum(is.na(dulera$Address))
anyDuplicated(dulera$Address)

#Primary Specialty
sum(is.na(dulera$Primary.Specialty))
unique(dulera$Primary.Specialty)
ddply(dulera, .(Primary.Specialty), summarize, count = length(Customer.ID))
ddply(dulera, .(Primary.Specialty.Rollup), summarize, count = length(Customer.ID))
