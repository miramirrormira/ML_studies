########################################
### K Nearest Neighbors Example
### Libraries: class
### Discription: classify handwritten digits based on the gray scale of 784 pixels on the image.

library(class)

digits <- read.csv("hand_written_digits_train.csv")
sample <- sample(1:42000, 21000)
digits$label <- as.factor(as.character(digits$label))
train <- digits[sample,]
test <- digits[-sample,]
knn <- knn(train = train, test = test, cl = digits[sample,]$label, k=5)
summary(knn)
table(knn, digits[-sample,]$label)
#miss classification error: 3.93%
pred <- as.data.frame(cbind(knn, test$label))
colnames(pred) <- c("prediction", "observation")
pred$missClassification[pred$prediction != pred$observation] <- 1
sum(pred$missClassification, na.rm=TRUE)/21000 * 100



# Another example with a small dataset:
# Classify iris species
train <- rbind(iris3[1:25,,1], iris3[1:25,,2], iris3[1:25,,3])
test <- rbind(iris3[26:50,,1], iris3[26:50,,2], iris3[26:50,,3])
cl <- factor(c(rep("s",25), rep("c",25), rep("v",25)))
knn2 <- knn(train, test, cl, k = 3, prob=TRUE)
table(knn2, cl)
