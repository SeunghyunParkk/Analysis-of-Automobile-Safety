install.packages("tree")
install.packages("rpart.plot") 
library(tree) 
library(rpart) 
library(rpart.plot)
data_IMDB = read.csv("C:/Users/Park/Juan/data_IMDB.csv")
attach(data_IMDB)

mytree=rpart(imdb_score~duration+title_year,control=rpart.control(cp=0.01))

rpart.plot(mytree)

summary(mytree)

myoverfittedtree=rpart(imdb_score~duration+title_year,control=rpart.control(cp=0.001)) 

rpart.plot(myoverfittedtree)

printcp(myoverfittedtree) 
plotcp(myoverfittedtree)

opt_cp=myoverfittedtree$cptable[which.min(myoverfittedtree$cptable[,"xerror"]),"CP"]

opt_cp


mybesttree=rpart(imdb_score~duration+title_year,control=rpart.control(cp=opt_cp)) 
printcp(mybesttree) 
rpart.plot(mybesttree)

##########################################################
#####################Random Forest########################
##########################################################

install.packages("randomForest")
library(randomForest)

myforest = randomForest(imdb_score~budget+duration+title_year+movie_facebook_likes+actor_1_facebook_likes+facenumber_in_poster, ntree=500, data=data_IMDB, importance=TRUE, na.action = na.omit)
myforest
predict(myforest,data.frame(movie_facebook_likes=10000,budget=10000000,duration=90,title_year=2017,actor_1_facebook_likes=2500,facenumber_in_poster=3))
importance(myforest)
varImpPlot(myforest)


table(content_rating)
classifiedtree=rpart(content_rating~budget+duration +movie_facebook_likes+facenumber_in_poster, cp=0.007, na.action=na.omit)
rpart.plot(classifiedtree)

install.packages("gbm") 
library(gbm) 
set.seed (1) 
boosted=gbm(imdb_score~budget+duration+title_year+movie_facebook_likes+actor_1_facebook_likes+facenumber_in_poster,data=data_IMDB,distribution= "gaussian",n.trees=10000, interaction.depth=4) 
summary(boosted) 

#################obtain mse
predicted_score = predict(boosted, newdata=data_IMDB, ntrees = 10000)
mean((predicted_score-imdb_score)^2)
