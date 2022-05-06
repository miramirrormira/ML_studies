###########################################################################################################
### Random Forrest Example
### Liabraries: randomForest
### Discription: use random forest to segment hand-written digits.
###              
### Data source: https://www.kaggle.com/c/digit-recognizer
###########################################################################################################

#Build random forest model
library(randomForest)
train <- read.csv("hand_written_digits_train.csv")
train$label <- as.factor(as.character(train$label))
rf1 <- randomForest(label~., data=train, do.trace=TRUE)

#Model results
plot(rf1)  #check if the model converged
print(rf1)  #error rate
