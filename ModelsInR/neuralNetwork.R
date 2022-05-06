#####################################
### Neural Network Example
### Libraries: nnet
### Discription: classify iris species using neural network

library(nnet)

# use half the iris data
ir <- rbind(iris3[,,1],iris3[,,2],iris3[,,3])
targets <- class.ind( c(rep("s", 50), rep("c", 50), rep("v", 50)) )
ir1 <- nnet(ir, targets, size = 2, rang = 0.1,
            decay = 5e-4, maxit = 200)

test.cl <- function(true, pred) {
  true <- max.col(true)
  cres <- max.col(pred)
  table(true, cres)
}
test.cl(targets, predict(ir1, ir))

