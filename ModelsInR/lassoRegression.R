#######################################
### LASSO Regression Example
### Libraries: glmnet
### Description: predict prostate cancer volume based on clinical measures.
#######################################

library(glmnet)
prostate <- read.table("prostate.txt")
# lcavol: log(cancer volume)
# lweight: log(prostate weight)
# age: age
# lbph: log(benign prostatic hyperplasia amount)
# svi: seminal vesicle invasion
# lcp: log(capsular penetration)
# gleason: Gleason score
# pgg45: percentage Gleason scores 4 or 5
# lpsa: log(prostate specific antigen)
train <- prostate[prostate$train == TRUE,]
test <- prostate[prostate$train == FALSE,]

#Lasso model
lasso <- glmnet(x=as.matrix(train[,2:9]), y=as.numeric(train[,1]), alpha = 1)
plot(lasso)

#cross validation
cv <- cv.glmnet(x=as.matrix(train[,2:9]), y=as.numeric(train[,1]))
plot(cv)
lambda.min <- cv$lambda.min

#predict
test$pred <- predict(lasso, newx = as.matrix(test[,2:9]), s = lambda.min)

# Root mean squared error: 0.7015
(sum((test$lcavol - test$pred)^2)/30)^0.5
