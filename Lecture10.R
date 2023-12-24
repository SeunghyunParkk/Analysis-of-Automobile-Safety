library(readr)
spotify = read.csv("C:/Users/Park/Juan/spotify.csv")
View(spotify)

spotify_labels = spotify[,c(1,2)]
spotify_vars = spotify[,c(3:11)]

install.packages("GGally")
library(ggplot2)
library(GGally)
ggpairs(spotify_vars)

pca = prcomp(spotify_vars,scale = TRUE)
pca

###Plottingthe first and second principal components
install.packages("ggfortify")
library(ggfortify)

autoplot(pca, data = spotify_vars, loadings =TRUE, loadings.label = TRUE)

autoplot(pca, data = spotify_vars, 
         col=ifelse(spotify_labels$artist =="Drake", "blue", "transparent"),
         loadings =TRUE, loadings.label = TRUE)

autoplot(pca, data = spotify_vars, 
         col=ifelse(spotify_labels$artist =="Arcade Fire", "blue", "transparent"),
         loadings =TRUE, loadings.label = TRUE)

autoplot(pca, data = spotify_vars, 
         col=ifelse(spotify_labels$song_title =="Beat It", "blue", "transparent"),
         loadings =TRUE, loadings.label = TRUE)

###Percentage of variance explained (PVE) plot
pve = (pca$sdev^2)/sum(pca$sdev^2)
par(mfrow=c(1,2))
plot(pve, ylim=c(0,1))
plot(cumsum(pve), ylim = c(0,1))



library(readr)
IMDB_PCA = read.csv("C:/Users/Park/Juan/IMDB_PCA.csv")
View(IMDB_PCA)
attach(IMDB_PCA)
IMDB_labels = IMDB_PCA[,c(1)]
IMDB_vars = IMDB_PCA[,c(2:13)]
pca_IMDB = prcomp(na.omit(IMDB_vars), scale = TRUE)
autoplot(pca_IMDB, data=na.omit(IMDB_vars), 
         loadings = TRUE, col="grey", loadings.label = TRUE)
