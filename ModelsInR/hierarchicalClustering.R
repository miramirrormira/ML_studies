########################################
### Hierarchical Clustering Example
### Discription: use hierarchical clustering model to classify US States based on their criminal rate
########################################

hc <- hclust(dist(USArrests), "ave")
plot(hc)
plot(hc, hang = -1)
