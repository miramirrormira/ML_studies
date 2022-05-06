#######################################
### Best selection example
### Libraries: leaps
### Description: predict prostate cancer volume based on clinical measures.
#######################################

library(leaps)
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

best <- regsubsets(x=prostate[,2:9], y=prostate[,1],
                   method = "exhaustive")
summary(best)
plot(best, scale = "adjr2")

#select the model with highest "adjusted squared error",
#include "age","lbph","lcp","gleason","pgg45","lpsa"

train <- prostate[prostate$train == TRUE,]
test <- prostate[prostate$train == FALSE,]

lm <- lm(lcavol ~ age + lbph + lcp + gleason + pgg45 + lpsa, 
         data=train)

test$pred <- predict(lm, test)

# Root mean squared error: 0.705
(sum((test$lcavol - test$pred)^2)/30)^0.5
