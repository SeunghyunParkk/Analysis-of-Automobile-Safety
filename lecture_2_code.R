
real_estate=read.csv("~/Dropbox/Mac/Downloads/real_estate.csv")
attach(real_estate)


#Let's look at the dataset

names(real_estate)   #See the variable names
View(real_estate)    #See spreadsheet
 

#Summarize the data (Y=price, X=bedrooms)

summary(price)  
summary(bedrooms)

###boxplot

boxplot(price)
boxplot(bedrooms)

##histogram

hist(price)
hist(bedrooms)

###Scatterplot: relationship between x and y

plot(bedrooms, price)

####Line that best fits

lm.fit=lm(price~bedrooms)
lm.fit


####plot the line   Y=bo+b1(X)

abline(lm.fit)


b0=coef(lm.fit)[1]
b1=coef(lm.fit)[2]


###Prediction for a 2-bedroom house
b0+b1*2
####Prediction for a 3-bedroom house
b0+b1*3
####Prediction for a 4-bedroom house
b0+b1*4

###Calculating standard error

summary(lm.fit)


###Confidence intervals

confint(lm.fit, 'bedrooms', level=0.90) ##90% interval
confint(lm.fit, 'bedrooms', level=0.95)   ###95% interval
confint(lm.fit, 'bedrooms', level=0.99)   ###99% interval


####install a package

install.packages("visreg")
require(visreg)

par(mfrow=c(3,2))
visreg(lm.fit, alpha=1-0.60)  ###60% confidence interval
visreg(lm.fit, alpha=1-0.70)  ###70% confidence interval
visreg(lm.fit, alpha=1-0.80)  ###80% confidence interval
visreg(lm.fit, alpha=1-0.90)  ###90% confidence interval
visreg(lm.fit, alpha=1-0.95)  ###95% confidence interval
visreg(lm.fit, alpha=1-0.99)  ###99% confidence interval
par(mfrow=c(1,1))


summary(lm.fit)
