
library(nnet)
digits <- read.csv("hand_written_digits_train.csv")
sample <- sample(1:42000, 21000)
digits$label <- as.factor(as.character(digits$label))
train <- digits[sample,]
test <- digits[-sample,]
x <- as.matrix(train[,-1])
y <- class.ind(train[,1])
nn <- nnet(x, y, size = 1)
x_test <- as.matrix(test[,-1])
pred <- predict(nn, x_test)

test.cl <- function(true, pred) {
  true <- max.col(true)
  cres <- max.col(pred)
  table(true, cres)
}

test.cl(test[,1], predict(nn, x_test))

