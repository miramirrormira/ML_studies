########################################
### Partial Least Squares Example
### Libraries: pls
### Discription: perform regression analysis on prostate cancer data using Partial Least Squares 
########################################

library(pls)
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

pls1 <- plsr(lcavol ~ lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa, 
             data=train)
summary(pls1)
plot(pls1)

pred <- predict(pls1, newdata = test, ncomp = 5)
test$pred <- pred
# Root mean squared error: 0.702
(sum((test$lcavol - test$pred)^2)/30)^0.5
