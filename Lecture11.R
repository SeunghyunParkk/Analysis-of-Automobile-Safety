mcmenu = read.csv("mcmenu.csv")
attach(mcmenu)
mcmenu_c = mcmenu[,c(2,3)]
rownames(mcmenu_c) = mcmenu$Item

###Plot Clusters
library(ggplot2)
plot=ggplot(mcmenu_c,aes(y=Sugars, x = Total.Fat))
plot+geom_point()

###Plot the clusters
km.2 = kmeans(mcmenu_c,2) #2 clusters
km.3 = kmeans(mcmenu_c,3) #3 clusters
km.4 = kmeans(mcmenu_c,4) #4 clusters
km.5 = kmeans(mcmenu_c,5) #5 clusters

mcmenu_c$cluster=as.factor(km.2$cluster)
attach(mcmenu_c)
plot+geom_point(aes(colour=cluster))

mcmenu_c$cluster=as.factor(km.3$cluster)
attach(mcmenu_c)
plot+geom_point(aes(colour=cluster))

mcmenu_c$cluster=as.factor(km.4$cluster)
attach(mcmenu_c)
plot+geom_point(aes(colour=cluster))

mcmenu_c$cluster=as.factor(km.5$cluster)
attach(mcmenu_c)
plot+geom_point(aes(colour=cluster))

km.5 # solution for five clusters

### Performance of solutioin

km.2$tot.withinss
km.3$tot.withinss
km.4$tot.withinss
km.5$tot.withinss

clusters = data.frame(rownames(mcmenu_c), km.3$cluster)
View(clusters)


mcmenu_short=mcmenu_c[c(1:30),]
rownames(mcmenu_short)=mcmenu$Item[c(1:30)]

hc = hclust(dist(mcmenu_short))
plot(hc,hang = -1, cex=0.6)

### Cut the tree to generate k clusters
cutree(hc,2) # k = 2, cut in second
cutree(hc,3) # k = 3, cut in third height


