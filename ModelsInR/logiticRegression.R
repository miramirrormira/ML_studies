########################################
### Logistic Regression Example
### Libraries: ISLR, unbalanced, stats
### Discription: Default is a simulated dataset containing info of 10k credit card customers, 
###              the goal is to build a model that can predict which ones will default.
########################################

library(ISLR)
library(unbalanced)

#data manipulation
data(Default)
Default$student_dummy <- 0
Default$student_dummy[Default$student == "Yes"] <- 1
Default$default_binary <- NA
Default$default_binary[Default$default == "Yes"] <- 1
Default$default_binary[Default$default == "No"] <- 0
Default$balance_scaled <- scale(Default$balance, center = TRUE, scale = TRUE)
Default$income_scaled <- scale(Default$income, center = TRUE, scale = TRUE)
Default$student_dummy <- scale(Default$student_dummy, center = TRUE, scale = TRUE)

#create training and testing dataset  
sample <- sample(1:10000, 7000)
train <- Default[sample,]
test <- Default[-sample,]

#balance the dataset
input <- train[,c(5,7,8)]
output <- as.factor(train[, 6])
data<-ubBalance(X= input, Y=output, type="ubSMOTE", percOver=1000, verbose=TRUE)
balancedData<-cbind(data$X,data$Y)

#build the logistic model
logit <- glm(data$Y~student_dummy+balance_scaled+income_scaled, data=balancedData, 
             family = binomial(link = "logit"))

#predict the result
pred <- predict(ridge, test, type = "response")
test$pred[pred <= 0.5] <- 0
test$pred[pred > 0.5] <- 1

#classification result
table(test$pred, test$default_binary)


