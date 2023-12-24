real_estate = read.csv("C:/Users/jserpa1/Downloads/real_estate_lect5.csv")
attach(real_estate)
library(car)




#Section 2.1: Creating a polynomial model

plot(year, price)
plot(bedrooms, price)

reg1=lm(price~bedrooms+year)
residualPlots(reg1)

##Try different polynomials
reg2=lm(price~bedrooms+poly(year,2)) #2nd-degree polynomial
reg3=lm(price~bedrooms+poly(year,3)) #3rd-degree polynomial
reg4=lm(price~bedrooms+poly(year,4)) #4th-degree polynomial

summary(reg2)
summary(reg3)
summary(reg4)


reg_a=lm(price~bedrooms+poly(year,1)) 
reg_b=lm(price~bedrooms+year) 
reg_c=lm(price~bedrooms+poly(year,1, raw=TRUE))
summary(reg_a)
summary(reg_b)   ##reg_b and reg_c give you the same results
summary(reg_c)

###Section 2.2: Plotting a polynomial
install.packages("ggplot2")
library(ggplot2)
require(methods)

#Step 1: Create the canvas/environment of the plot
plot=ggplot(real_estate, aes(y=price, x=year)) #aes=aesthetics

#Step 2: Create scatter plot
scatter=geom_point(col="sky blue")

#Step 3: Create line
line_d2=geom_smooth(method="lm", formula=y~poly(x,2))
line_d3=geom_smooth(method="lm", formula=y~poly(x,3))
line_d4=geom_smooth(method="lm", formula=y~poly(x,4))

#Step 4: Layer the line and scatter over the canvas

plot+scatter+line_d2   #2nd-degree polynomial
plot+scatter+line_d3   #3rd-degree polynomial
plot+scatter+line_d4   #4th-degree polynomial
plot+scatter+line_d2+line_d3+line_d4  #All lines together


###Section 2.3: Finding the optimal polynomial degree

#Step 1: Decide which models to compare
#we are going to compare reg1, reg2, reg3, reg4

#step 2: Run an anova test to compare models
anova(reg1, reg2, reg3, reg4)

#####Section 3: Splines
detach(real_estate)
attach(MontrealTemp)
plot=ggplot(MontrealTemp, aes(y=Temperature, x=Day))
scatter=geom_point(color="gray")
line_1=geom_smooth(method="lm", formula=y~poly(x,4))

plot+scatter+line_1

##Section 3.1: Linear splines
library(splines)
##The data looks like it needs 4 splines and joined by 3 knots
#let's place the knots at 210, 400, 560

reg6=lm(Temperature~bs(Day, knots=c(210, 400, 560), degree=1))
summary(reg6)

#Plot the function
spline_1=geom_smooth(method="lm", formula=y~bs(x, knots=c(210, 400, 560), degree=1))
plot+scatter+spline_1

##How do we obtain predictions

reg6$fitted[200]  ##gives me the prediction for the temperature in Day 200 (23.48 degrees)
reg6$fitted[300]  
reg6$fitted[400]  
reg6$fitted[500]  
reg6$fitted[277]  

###Section 3.2: Polynomial splines
reg7=lm(Temperature~bs(Day, knots=c(210, 400, 560), degree=2))  #2nd degree splines
reg8=lm(Temperature~bs(Day, knots=c(210, 400, 560), degree=3))  #3rd degree splines
reg9=lm(Temperature~bs(Day, knots=c(210, 400, 560), degree=4))  #4th degree splines
summary(reg7)
summary(reg8)
summary(reg9)

#Plotting the splines
spline_2=geom_smooth(method="lm", formula=y~bs(x, knots=c(210, 400, 560), degree=2), aes(col="blue"))
spline_3=geom_smooth(method="lm", formula=y~bs(x, knots=c(210, 400, 560), degree=3), aes(col="green"))
spline_4=geom_smooth(method="lm", formula=y~bs(x, knots=c(210, 400, 560), degree=4), aes(col="red"))

spline_plot=plot+scatter+spline_1+spline_2+spline_3+spline_4
spline_plot

##Section 3.3: Choosing the knots

##When we don't know how to place the knots, we ensure that we divide an equal number of datapoints in each segment

##For example: Create four knots to divide the data into five segments
k1=quantile(Day, 1/5)
k2=quantile(Day, 2/5)
k3=quantile(Day, 3/5)
k4=quantile(Day, 4/5)

reg10=lm(Temperature~bs(Day, knots=c(k1, k2, k3, k4), degree=3))


##Plotting the function

eq_spline=geom_smooth(method="lm", formula=y~bs(x, knots=c(k1,k2,k3,k4), degree=3))
plot+scatter+eq_spline+geom_vline(xintercept=c(k1,k2,k3,k4), linetype="dotted")



####Section 4: Local regression

reg11=loess(Temperature~Day, span=0.1)
reg12=loess(Temperature~Day, span=0.3)
reg13=loess(Temperature~Day, span=0.5)

localplot1=geom_smooth(method="loess", span=0.01, col="red")
plot+scatter+localplot1


