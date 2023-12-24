real_estate <- read.csv("~/real_estate_lect4.csv")
attach(real_estate)

##############
##Section 2###
###############

#Sections 2.1 and 2.2
reg1=lm(price~bedrooms+area+property_type)
summary(reg1)

#Section 2.2
reg2=lm(price~bedrooms)
summary(reg2)

reg3=lm(price~bedrooms+area)    #relevant variable
summary(reg3)

yolo_reg=lm(price~bedrooms+ID)   #irrelevant variable
summary(yolo_reg)



##############
##Section 3###
###############

# Section 3.1 (Issue 1: Nonlinearity)
reg4=lm(price~area+year+bathrooms+bedrooms)
install.packages("car")
library(car)
residualPlots(reg4)
residualPlots(reg4)

reg5=lm(price~area+bathrooms+bedrooms) #regression without 'year'
residualPlots(reg5)

###Section 3.2 (Issue 2:Heteroskedasticity)

# Visual test
reg6=lm(price~area+year+bedrooms)
residualPlot(reg6, quadratic=FALSE)
#Numerical test
ncvTest(reg6)

#correcting for heteroskedasticity
install.packages("lmtest")
install.packages("plm")
require(lmtest)
require(plm)
coeftest(reg6, vcov = vcovHC(reg6, type = "HC1")) ##regression correcting for heteroskedasticity
summary(reg6)  ###regression with heteroskedastic errors (for comparison)



###Section 3.3 (Issue 3:Outliers)

########
reg7=lm(price~area+year+bedrooms)
summary(reg7)
qqPlot(reg7) #visual test
outlierTest(reg7)   ##numerical test
real_estate2=real_estate[-c(29,74), ]   #removing the two outliers

reg8=lm(price~area+year+bedrooms, data=real_estate2)
summary(reg8)


###Section 3.4 (Issue 4: Collinearity)
########
install.packages("psych")
require(psych)
quantvars=real_estate[, c(3, 6, 7, 8, 9, 10, 12)]
corr_matrix=cor(quantvars)
round(corr_matrix,2)

reg9=lm(price~bedrooms+bathrooms+area+area_with_garden+Levels+year)
vif(reg9)

reg10=lm(price~bedrooms+bathrooms+area+Levels+year) ##remove area_with_garden
vif(reg10)

#compare reg9 (collinearity) and reg10 (no collinearity)
summary(reg9)
summary(reg10)
