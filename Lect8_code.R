charity = read.csv("charity.csv")
charity$cause=as.factor(charity$cause)
attach(charity)


#####Plotting relationship
library(ggplot2)
ggplot(charity, aes(x=cause, y=age))+geom_boxplot()

####Calculating prior distributions
table(cause)
pi_animals=28/85
pi_deforestation=31/85
pi_ocean=26/85


####Calculating probability density functions
hists=ggplot(charity, aes(x=age))+geom_histogram(bins = 50)+facet_grid(cause)
hists
mean(age[cause=="animal rights"])
mean(age[cause=="deforestation"])
mean(age[cause=="ocean cleanup"])

####Estimating LDA
install.packages("MASS")
install.packages("klaR")
install.packages("fastmap")
library(MASS)
library(klaR)


mylda=lda(cause~age)
mylda

#####Making predictions
predict(mylda, data.frame(age=30))
predict(mylda, data.frame(age=35))
predict(mylda, data.frame(age=50))


#####LDA with two predictors

mylda2=lda(cause~age+income)
mylda2

####Predictions
predict(mylda2,data.frame(age=25, income=40))
predict(mylda2,data.frame(age=36, income=65))
predict(mylda2,data.frame(age=45, income=100))

predict(mylda2)

####Partition matrix

partimat(cause~income+age, method="lda",image.colors=c("light grey", "light green", "white")) 


#####Quadratic discriminant analysis

myqda=qda(cause~income+age)
myqda


###Predictions

predict(myqda,data.frame(age=25, income=40))
predict(myqda,data.frame(age=36, income=65))
predict(myqda,data.frame(age=45, income=100))


####Partition matrix

partimat(cause~income+age, method="qda",image.colors=c("light grey", "light green", "white")) 
  


