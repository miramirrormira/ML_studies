###########################
### K means example in R
### Description: Use K medoid to segment iris species
###########################

library(cluster)
data("iris")

kmed <- pam(iris[,3:4], 3)

#compare the generated clusters with observed iris species
table(kmed$clustering, iris$Species)
