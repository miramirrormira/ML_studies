rm(list = ls())
.libPaths("C:/RPackages")
setwd("C:/EF/RM/HitMa Ranking & Activation/Old Customers/Data")
library(ggplot2) 
library(plyr)
library(reshape2)
library(randomForest)
library(gplots)
library(epicalc)
library(gbm)
library(e1071)
library(ada)
library(adabag)
library(DMwR)

data <- read.csv("2013-12-13_training.csv", header = T)
data <- subset(data, zipcode_population != 0 & zipcode_income != 0 &
                 zipcode_Avg_House_Value != 0 & zipcode_PersonsPerHousehold != 0)

hist(data$zipcode_population)
hist(data$zipcode_income)
hist(data$zipcode_Avg_House_Value)
hist(data$zipcode_PersonsPerHousehold)

data$emails_received_last_3_month[is.na(data$emails_received_last_3_month)] <- 0
data$emails_opened_last_3_month[is.na(data$emails_opened_last_3_month)] <- 0
data$emails_clicked_last_3_month[is.na(data$emails_clicked_last_3_month)] <- 0
data$emails_received_last_6_month[is.na(data$emails_received_last_6_month)] <- 0
data$emails_opened_last_6_month[is.na(data$emails_opened_last_6_month)] <- 0
data$emails_clicked_last_6_month[is.na(data$emails_clicked_last_6_month)] <- 0
data$eval_filled[is.na(data$eval_filled)] <- 0
data$eval_value[is.na(data$eval_value)] <- mean(data$eval_value, na.rm = T)
data$eval_RecGAV[is.na(data$eval_RecGAV)] <- mean(data$eval_RecGAV, na.rm = T)
data$eval_Exp[is.na(data$eval_Exp)] <- mean(data$eval_Exp, na.rm = T)
data$booked_in_two_month <- as.factor(data$booked_in_two_month)

sample <- sample(1:dim(data)[1], 20000)
train <- data[sample, ]
rf <- randomForest(booked_in_two_month~., data = train[, -c(1,3,4,5,23)])
train_pred <- predict(rf)
table(train_pred, train$booked_in_two_month)
train$pred <- predict(rf)
train$prob <- predict(rf, type = "prob")[,2]
varImpPlot(rf, main = "Variable Importance Ranking", color = "dark blue", 
           gcolor = "red", lcolor = "orange", cex = 1.1, bg = "dark blue",)
partialPlot(rf, train, months_to_last_tour, "1", rug = TRUE, 
            main = "Likelihood to Activate by \"exact_target_email_sent\"",
            ylab = "Logit")



rank <- train[, c(1, 2, 33, 34)]
rank <- rank[order(- rank$prob), ]
rank$count <- c(1:length(train$cus_id))
rank$pct <- rank$count / length(train$cus_id)
rank$pctQ <- NA
for(i in 1:length(train$cus_id)){
  rank$pctQ[i] <- sum(rank$booked_in_two_month[1:i] == 1)/
    length(rank$booked_in_two_month[rank$booked_in_two_month == 1])
}

plot(rank$pct, rank$pctQ, main = "Ranking Performance \n(Test Dataset)", 
     xlab = "Percentage of total new leads",
     ylab = "Percentage of Activated Leads", col = "red", cex = 0.5)
points(rank1$pct, rank1$pctQ, col = "blue", cex = 0.5)
abline(0,1)



#balance dataset\
yes <- subset(data, booked_in_two_month == 1)
no <- subset(data, booked_in_two_month == 0)
no_sample <- sample(1:dim(no)[1], 800)
yes_sample <- sample(1:dim(yes)[1], 800)
no_sample_test <- sample(1:dim(no)[1], 20000)
train <- rbind(yes[yes_sample,], no[no_sample, ])
test <- rbind(yes[-yes_sample,], no[no_sample_test, ])
rf <- randomForest(booked_in_two_month~., data = train[, -c(1,3,4,5,23:27)], 
                   do.trace = TRUE, ntree = 1000)
rf <- randomForest(booked_in_two_month~., data = train[, -c(1,3,4,5,23)], 
                   do.trace = TRUE, ntree = 1000)
plot(rf)
train_pred <- predict(rf, test)
table(train_pred, test$booked_in_two_month)
varImpPlot(rf, main = "Variable Importance Ranking", color = "dark blue", 
           gcolor = "red", lcolor = "orange", cex = 1.1, bg = "dark blue",)

partialPlot(rf, train, market_channel, "1", rug = TRUE, 
            main = "Likelihood to Activate by \"exact_target_email_sent\"",
            ylab = "Logit")


hist(data$zipcode_population)
hist(data$zipcode_income)
hist(data$zipcode_Avg_House_Value)
hist(data$zipcode_PersonsPerHousehold)

sum(data$booked_in_two_month == 1)

subset(train, zipcode_population < 10000)


#more data
data <- read.csv("2013-12-13_training.csv", header = T)
test <- read.csv("2013-12-13_test.csv", header = T)
data <- subset(data, zipcode_population != 0 & zipcode_income != 0 &
                 zipcode_Avg_House_Value != 0 & zipcode_PersonsPerHousehold != 0)
test <- subset(test, zipcode_population != 0 & zipcode_income != 0 &
                 zipcode_Avg_House_Value != 0 & zipcode_PersonsPerHousehold != 0)

hist(data$zipcode_population)
hist(data$zipcode_income)
hist(data$zipcode_Avg_House_Value)
hist(data$zipcode_PersonsPerHousehold)

data$emails_received_last_3_month[is.na(data$emails_received_last_3_month)] <- 0
data$emails_opened_last_3_month[is.na(data$emails_opened_last_3_month)] <- 0
data$emails_clicked_last_3_month[is.na(data$emails_clicked_last_3_month)] <- 0
data$emails_received_last_6_month[is.na(data$emails_received_last_6_month)] <- 0
data$emails_opened_last_6_month[is.na(data$emails_opened_last_6_month)] <- 0
data$emails_clicked_last_6_month[is.na(data$emails_clicked_last_6_month)] <- 0
data$eval_filled[is.na(data$eval_filled)] <- 0
data$eval_value[is.na(data$eval_value)] <- mean(data$eval_value, na.rm = T)
data$eval_RecGAV[is.na(data$eval_RecGAV)] <- mean(data$eval_RecGAV, na.rm = T)
data$eval_Exp[is.na(data$eval_Exp)] <- mean(data$eval_Exp, na.rm = T)
data$booked_in_two_month <- as.factor(data$booked_in_two_month)

test$emails_received_last_3_month[is.na(test$emails_received_last_3_month)] <- 0
test$emails_opened_last_3_month[is.na(test$emails_opened_last_3_month)] <- 0
test$emails_clicked_last_3_month[is.na(test$emails_clicked_last_3_month)] <- 0
test$emails_received_last_6_month[is.na(test$emails_received_last_6_month)] <- 0
test$emails_opened_last_6_month[is.na(test$emails_opened_last_6_month)] <- 0
test$emails_clicked_last_6_month[is.na(test$emails_clicked_last_6_month)] <- 0
test$eval_filled[is.na(test$eval_filled)] <- 0
test$eval_value[is.na(test$eval_value)] <- mean(test$eval_value, na.rm = T)
test$eval_RecGAV[is.na(test$eval_RecGAV)] <- mean(test$eval_RecGAV, na.rm = T)
test$eval_Exp[is.na(test$eval_Exp)] <- mean(test$eval_Exp, na.rm = T)
test$booked_in_two_month <- as.factor(test$booked_in_two_month)

data$market_channel2 <- data$market_channel
data[!(data$market_channel %in% c("PPC - Non-Brand",
                                  "Display",
                                  "Partnerships",
                                  "Web",
                                  "Word of Mouth",
                                  "PPC - Brand",
                                  "Referral Program",
                                  "EF - Other Product",
                                  "Old Channels",
                                  "PPC - Phone")),]$market_channel2 <- "Uncategorized"
data$market_channel2 <- factor(data$market_channel2)

test$market_channel2 <- test$market_channel
test[!(test$market_channel %in% c("PPC - Non-Brand",
                                     "Display",
                                     "Partnerships",
                                     "Web",
                                     "Word of Mouth",
                                     "PPC - Brand",
                                     "Referral Program",
                                     "EF - Other Product",
                                     "Old Channels",
                                     "PPC - Phone")),]$market_channel2 <- "Uncategorized"
test$market_channel2 <- factor(test$market_channel2)


data$source2 <- data$source
test$source2 <- test$source
data[!(data$source %in% c("PPC",
                         "Display",
                         "Prospecting",
                         "GAT Website",
                         "Referral",
                         "Generic",
                         "Conference")
),]$source2 <- "Other"

data$source2 <- factor(data$source2)

test[!(test$source %in% c("PPC",
                          "Display",
                          "Prospecting",
                          "GAT Website",
                          "Referral",
                          "Generic",
                          "Conference")
),]$source2 <- "Other"

test$source2 <- factor(test$source2)

#zip data 
#income 
ggplot(test, aes(zipcode_income)) + geom_histogram(binwidth = 10000)

data$HouseHoldIncome <- NA
data$HouseHoldIncome[data$zipcode_income < 20000] <- "$0-$19,999"
data$HouseHoldIncome[data$zipcode_income < 30000 & data$zipcode_income >= 20000] <- "$20,000-$29,999"
data$HouseHoldIncome[data$zipcode_income < 40000 & data$zipcode_income >= 30000] <- "$30,000-$39,999"
data$HouseHoldIncome[data$zipcode_income < 50000 & data$zipcode_income >= 40000] <- "$40,000-$49,999"
data$HouseHoldIncome[data$zipcode_income < 60000 & data$zipcode_income >= 50000] <- "$50,000-$59,999"
data$HouseHoldIncome[data$zipcode_income < 70000 & data$zipcode_income >= 60000] <- "$60,000-$69,999"
data$HouseHoldIncome[data$zipcode_income < 80000 & data$zipcode_income >= 70000] <- "$70,000-$79,999"
data$HouseHoldIncome[data$zipcode_income < 90000 & data$zipcode_income >= 80000] <- "$80,000-$89,999"
data$HouseHoldIncome[data$zipcode_income < 100000 & data$zipcode_income >= 90000] <- "$90,000-$99,999"
data$HouseHoldIncome[data$zipcode_income >= 100000] <- "$100,000 and over"
data$HouseHoldIncome <- as.factor(data$HouseHoldIncome)

test$HouseHoldIncome <- NA
test$HouseHoldIncome[test$zipcode_income < 20000] <- "$0-$19,999"
test$HouseHoldIncome[test$zipcode_income < 30000 & test$zipcode_income >= 20000] <- "$20,000-$29,999"
test$HouseHoldIncome[test$zipcode_income < 40000 & test$zipcode_income >= 30000] <- "$30,000-$39,999"
test$HouseHoldIncome[test$zipcode_income < 50000 & test$zipcode_income >= 40000] <- "$40,000-$49,999"
test$HouseHoldIncome[test$zipcode_income < 60000 & test$zipcode_income >= 50000] <- "$50,000-$59,999"
test$HouseHoldIncome[test$zipcode_income < 70000 & test$zipcode_income >= 60000] <- "$60,000-$69,999"
test$HouseHoldIncome[test$zipcode_income < 80000 & test$zipcode_income >= 70000] <- "$70,000-$79,999"
test$HouseHoldIncome[test$zipcode_income < 90000 & test$zipcode_income >= 80000] <- "$80,000-$89,999"
test$HouseHoldIncome[test$zipcode_income < 100000 & test$zipcode_income >= 90000] <- "$90,000-$99,999"
test$HouseHoldIncome[test$zipcode_income >= 100000] <- "$100,000 and over"
test$HouseHoldIncome <- as.factor(test$HouseHoldIncome)

HouseHoldIncome <- ddply(test, .(HouseHoldIncome), summarize, 
                         total = length(cus_id),
                         conv = mean(as.numeric(booked_in_two_month) - 1))

rf <- randomForest(booked_in_two_month~., data = data[, -c(1,3,4,5,6,25,30,31)], do.trace = T, ntree = 1000)
plot(rf)
test_pred <- predict(rf, test)
table(test_pred, test$booked_in_two_month)
test$pred <- predict(rf, test)
test$prob <- predict(rf, test, type = "prob")[,2]
varImpPlot(rf, main = "Variable Importance Ranking", color = "dark blue", 
           gcolor = "red", lcolor = "orange", cex = 1.1, bg = "dark blue",)

partialPlot(rf, data, zipcode_population, "1", rug = TRUE, 
            main = "zipcode_population",
            ylab = "Logit")



rank <- test[, c(1, 2, 4, 6, 7, 32, 33, 38, 39)]
rank <- rank[order(- rank$prob), ]
rank$count <- c(1:length(test$cus_id))
rank$count_bk <- 0
rank$pct <- rank$count / length(test$cus_id)
rank$pctQ <- NA
for(i in 1:length(test$cus_id)){
  rank$count_bk[i] <- sum(rank$booked_in_two_month[1:i] == 1)
  rank$pctQ[i] <- rank$count_bk[i]/
    length(rank$booked_in_two_month[rank$booked_in_two_month == 1])
}

plot(rank$pct, rank$pctQ, main = "Ranking Performance \n(Test Dataset)", 
     xlab = "Percentage of total new leads",
     ylab = "Percentage of Activated Leads", col = "red", cex = 0.5)
points(rank1$pct, rank1$pctQ, col = "blue", cex = 0.5)
abline(0,1)

write.csv(rank, "2013-12-16_rank.csv")