require(caTools)
require(splines)
require(methods)
library(ggplot2)

real_estate = read.csv("~/Dropbox/Mac/Downloads/real_estate_lect6.csv")
attach(real_estate)
View(real_estate)

##Plot relationship

plot=ggplot(real_estate, aes(y=price, x=area))
scatter=geom_point()
plot+scatter


reg1=lm(price~area)
reg2=lm(price~poly(area,2))
reg3=lm(price~poly(area,3))

summary(reg1)
summary(reg2)
summary(reg3)


##Section 3.1: Validation set test

#Step 1: Divide the data into two subdatasets

sample=sample.split(real_estate$price, SplitRatio=0.5)  ##assign random value of TRUE/FALSE to each obs

train_set=subset(real_estate, sample==TRUE) ## send obs with TRUE to train set
test_set=subset(real_estate, sample==FALSE) ## send obs with FALSE to test set

#Step 1: Divide the data into two subdatasets
train_points=geom_point(data=train_set,col="red")
test_points=geom_point(data=test_set,col="grey")
plot+train_points+test_points

#Step 2: Fit the model on a training set

fit=lm(price~poly(area,10), data=train_set) #ran reg on training data


###Steps 3 and 4: Calculate MSE

actual=test_set$price
prediction=predict(fit, test_set)
squared_error=(actual-prediction)^2
mse=mean(squared_error)
mse  
  

####Section 3.2: Leave-one-out cross-validation (LOOCV)

library(boot)  ##package to do cross-validation

fit=glm(price~poly(area,10), data=real_estate)  #note: lm=glm, but glm allows us to do cross-validation
mse=cv.glm(real_estate, fit)$delta[1]
mse


###Loop of different MSEs
mse=rep(NA, 5)  

for (i in 1:5) {
  fit=glm(price~poly(area,i), data=real_estate) 
  mse[i]=cv.glm(real_estate, fit)$delta[1]
}
mse  

##Plot the MSE

plot(mse)
lines(mse, col="red") ##We can visualize how the 3-rd degree polynomial has the lowest MSE
which.min(mse) #Here, we are told that third-degree polynomial has smallest MSE
min(mse)  ###3rd degree polynomial model (best one) gives you MSE of 0.4727



#### K-fold cross-validation
##Let's do K=10 folds. In other words, we divide dataset into 10 sub-datasets
fit=glm(price~area, data=real_estate)
mse=cv.glm(real_estate, fit, K=10)$delta[1]
mse



##Let's do a loop to test 10 models

mse=rep(NA, 10)  

for (i in 1:10) {
  fit=glm(price~poly(area,i), data=real_estate) 
  mse[i]=cv.glm(real_estate, fit, K=10)$delta[1]
}
mse 


plot(mse)
lines(mse, col="red") ##We can visualize how the 3-rd degree polynomial has the lowest MSE
which.min(mse) #Here, we are told that third-degree polynomial has smallest MSE
min(mse)  ###3rd degree polynomial model (best one) gives you MSE of 0.4727

