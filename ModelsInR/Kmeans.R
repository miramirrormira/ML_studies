###########################
### K means example in R
### Description: Use K means to segment iris species
###########################

library(ggplot2)
data(iris)
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()

kmeans <- kmeans(iris[,3:4], 3)

#compare the generated clusters with observed iris species
table(kmeans$cluster, iris$Species)
