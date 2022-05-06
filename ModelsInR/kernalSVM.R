########################################
### Kernel SVM
### Libraries: kernlab
### Discription: generate non linear separatable data and use kernal SVM to classify them.
########################################

library(kernlab)
library(ggplot2)

n = 20
r = runif(n)
a = 2*pi*runif(n)
a1 = r*sin(a)
a2 = r*cos(a)
r = 2+runif(n)
a = 2*pi*runif(n)
b1 = r*sin(a)
b2 = r*cos(a)
x = rbind(matrix(cbind(a1,a2),,2),matrix(cbind(b1,b2),,2))
y <- matrix(c(rep(1,n),rep(-1,n)))

qplot(x=x[,1], y=x[,2], color = y)

ksvm1 <- ksvm(x=x, y=y, kernel = "rbfdot")
predict(ksvm1)
