
###########################################################################################################
### Support Vector Machine Example
### Liabraries: e1071
### Discription: use svm to segment iris based on sepal length, sepal width, petal length, and petel width. 
###              There are three species: setosa, versicolor, virginica.
###########################################################################################################


#svm classification model
library(e1071)
data(iris)
svm1 <- svm(Species ~., data = iris)

#model summary
print(svm1)
summary(svm1)

#check accuracy
pred <- fitted(svm1)
table(pred, iris$Species)
