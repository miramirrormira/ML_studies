########################################
### Principle Component Example
### Libraries: ggplot2
### Discription: Generate principle components for the hand written digits data, 
###              and visualize pc1 and pc2 on a scatterplot
########################################

library(ggplot2)
digit <- read.csv("hand_written_digits_train.csv")

pc <- prcomp(digit)
pc_values <- data.frame(digit$label, pc$x[,1:2])

pc_values$digit.label <- as.factor(as.character(pc_values$digit.label))
ggplot(pc_values, aes(PC1, PC2)) + geom_point(aes(color = digit.label))
