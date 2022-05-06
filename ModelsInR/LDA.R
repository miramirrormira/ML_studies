########################################
### Linear Discriminant Analysis
### Libraries: MASS
### Discription: Use linear classification model LDA to classify Iris species 
########################################

library(MASS)

data(iris)
Iris <- data.frame(rbind(iris3[,,1], iris3[,,2], iris3[,,3]),
                   Sp = rep(c("s","c","v"), rep(50,3)))

train <- sample(1:150, 75)
table(Iris$Sp[train])
#  c  s  v 
#  22 29 24 

z <- lda(Sp ~ ., data = Iris[train,])

table(Iris[-train, ]$Sp, predict(z, Iris[-train, ])$class)
