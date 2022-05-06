#######################################
### Ridge Regression Example
### Libraries: MASS
### Description: predict prostate cancer volume based on clinical measures.
#######################################

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

ridge0 <- lm.ridge(lcavol ~ lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa, 
                        data=train, lambda = seq(0,10,0.1))
plot(ridge0)

lambda <- seq(0,10,0.1)[which.min(ridge0$GCV)]
ridge <- lm.ridge(lcavol ~ lweight + age + lbph + svi + lcp + gleason + pgg45 + lpsa, 
                  data=train, lambda = lambda)

test$pred <- NA
test$pred = scale(test[,2:9], center = ridge$xm, scale = ridge$scales)%*% ridge$coef + ridge$ym

# Root mean squared error: 0.7016
(sum((test$lcavol - test$pred)^2)/30)^0.5
