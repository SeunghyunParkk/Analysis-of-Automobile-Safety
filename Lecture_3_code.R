real_estate=read.csv("~/Dropbox/Mac/Downloads/real_estate_lect3.csv")
attach(real_estate)



names(real_estate) #names of the variables

#Y=price
#X1=bedrooms
#X2=area
#X3=Year





#run multiple linear regression
# Price=b0+b1(bedrooms)+b2(area)+b3(year)

# Price= 7144 + 47.66(bedrooms) + 0.066 (area) - 3.45 (year)
 
mreg=lm(price~bedrooms+area+year)
summary(mreg)


###Running 3 simple regressions

sreg1=lm(price~bedrooms)
sreg2=lm(price~area)
sreg3=lm(price~year)

summary(sreg1)
summary(sreg2)
summary(sreg3)


####Making predictions

b0=coef(mreg)[1]
b1=coef(mreg)[2]
b2=coef(mreg)[3]
b3=coef(mreg)[4]


#Let's predict the price of a house with bedroom=7, area=2500, year=2008

b0+b1*7+b2*2500+b3*2008


#####Creating a Dummy/Factor variable (House=1 or 0)

real_estate$property_type=as.factor(real_estate$property_type)
attach(real_estate)
levels(property_type)
table(property_type)

mreg2=lm(price~bedrooms+property_type)
summary(mreg2)



plot(bedrooms, price, col=ifelse(property_type=="house", "red", "blue"))



b0=coef(mreg2)[1]
b1=coef(mreg2)[2]
b2=coef(mreg2)[3]


###Regression line for houses:   Price=b0+b1(bedrooms)+b2(1)  \\\ Price=(b0+b2)+b1(bedrooms)
###Regression line for apartments:   Price=b0+b1(bedrooms)+b2(0)  \\\ Price=(b0)+b1(bedrooms)

abline(b0+b2, b1, col="red")
abline(b0, b1, col="blue")
legend("topright", pch=1, col=c( "red", "blue" ), c( "house", "apartment"))


####Multiple categories

real_estate$neighbourhood=as.factor(real_estate$neighbourhood) ###make it a dummy/factor variable
attach(real_estate)
levels(neighbourhood)
mreg3=lm(price~bedrooms+neighbourhood)
summary(mreg3)


###Changing excluded category

neighbourhood=relevel(neighbourhood, ref="Lasalle")
attach(real_estate)
mreg4=lm(price~bedrooms+neighbourhood)
summary(mreg4)



###Interaction variables

mreg5=lm(price~bedrooms+property_type+bedrooms*property_type)
summary(mreg5)


b0=coef(mreg5)[1]
b1=coef(mreg5)[2]
b2=coef(mreg5)[3]
b3=coef(mreg5)[4]

plot(bedrooms, price, col=ifelse(property_type=="house", "red", "blue")) 
abline(b0+b2,b1+b3, col= "red")
abline(b0, b1, col= "blue") 
legend("topright", pch=1, col=c( "red", "blue" ), c( "house", "apartment"))
