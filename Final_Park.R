library(readr)
library(knitr)
library(tidyverse)
library(ggplot2)
automobile = read.csv("Dataset 5 — Automobile data.csv")
attach(automobile)

sum(is.na(automobile))
sapply(automobile, function(x) sum(x == "?"))
automobile = automobile[,-c(2)]
missing_rows = apply(automobile, 1, function(x) any(x == "?"))
automobile = automobile[!missing_rows, ]

automobile$price= as.numeric(automobile$price)
automobile$horsepower = as.numeric(automobile$horsepower)
automobile$peak.rpm  = as.numeric(automobile$peak.rpm)
automobile$bore  = as.numeric(automobile$bore)
automobile$stroke  = as.numeric(automobile$stroke)

automobile$make = as.factor(automobile$make)
automobile$fuel.type = as.factor(automobile$fuel.type)
automobile$aspiration = as.factor(automobile$aspiration)
automobile$num.of.doors = as.factor(automobile$num.of.doors)
automobile$body.style = as.factor(automobile$body.style)
automobile$drive.wheels  = as.factor(automobile$drive.wheels )
automobile$engine.location  = as.factor(automobile$engine.location )
automobile$engine.type = as.factor(automobile$engine.type)
automobile$num.of.cylinders  = as.factor(automobile$num.of.cylinders )
automobile$fuel.system = as.factor(automobile$fuel.system)

library(ggplot2)
plot0 = ggplot(automobile, aes(x = symboling)) + geom_bar(fill = "skyblue") + theme_minimal() +labs(x = 'Symboling', y ='Freqency')
plot0

ggplot(data = automobile,aes(x=make, y=symboling)) + geom_bar(stat = "identity") +coord_flip()+labs(title="Bar Plot")

ggplot(data = automobile,aes(x=wheel.base, y=symboling)) + geom_point(fill = "steelblue")+theme_minimal()+  labs(x="wheel.base",y="symboling")

ggplot(data = automobile,aes(x=price, y=symboling,colour = make)) + geom_point()+theme_minimal() + labs(x="price",y="symboling")

plot_price = ggplot(automobile, aes(x = price)) + geom_histogram(fill = "green", color="black") + theme_minimal() + labs(x = 'Price', y ='Count')
plot_price

plot_wheel = ggplot(automobile, aes(x = wheel.base)) + geom_histogram(fill = "orange", color="black") + theme_minimal() + labs( x = 'Wheelbase', y ='Count')
plot_wheel


automobile_vars = automobile[,c(1,9,10,11,12,13,16,18,19,20,21,22,23,24,25)]

library(ggfortify)
pca = prcomp(automobile_vars,scale = TRUE)
pca

autoplot(pca, data = automobile_vars, loadings =TRUE, loadings.label = TRUE)


library(tidyverse)
library(knitr)

library(reshape2)
automobile_vars = automobile[,c(1,9,10,11,12,13,16,18,19,20,21,22,23,24,25)]

corr_matrix = cor(automobile_vars)

round(corr_matrix,2 )

library(reshape2)
library(ggplot2)
data_melt = melt(corr_matrix)
ggplot(data_melt, aes(x=Var1, y=Var2, fill=value)) +
  geom_tile() +
  scale_fill_gradient2(limits=c(-1, 1), mid="white", 
                       low="blue", high="red", midpoint=0) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

automobile$symboling = as.factor(automobile$symboling)

set.seed(123)

train_proportion = 0.7

train_row_num = round(nrow(automobile) * train_proportion)

train_indices = sample(seq_len(nrow(automobile)), size = train_row_num)

train_set = automobile[train_indices, ]

test_set = automobile[-train_indices, ]

library(randomForest)
set.seed(95)
myforest = randomForest(symboling~make+fuel.type+aspiration+num.of.doors+body.style+drive.wheels+engine.location+wheel.base+height+curb.weight+engine.type+num.of.cylinders+fuel.system+bore+stroke+compression.ratio+horsepower+peak.rpm, ntree=500, data=train_set, importance=TRUE, na.action = na.omit)
myforest
importance(myforest)
varImpPlot(myforest)

set.seed(95)
myforest2 = randomForest(symboling~make+wheel.base+num.of.doors+height+curb.weight+bore+horsepower+body.style,ntree=500, data=train_set, importance=TRUE, na.action = na.omit, do.trace=50)
myforest2
importance(myforest2)
varImpPlot(myforest2)

set.seed(95)
myforest3 =randomForest(symboling~make+wheel.base+num.of.doors+height+curb.weight+bore+horsepower+body.style,ntree=450, data=train_set, cp=0.1, importance=TRUE, na.action = na.omit)
myforest3
importance(myforest3)
varImpPlot(myforest3)

predicted = predict(myforest3,test_set, type ="class")

actual = test_set[,1]

accuracy = sum(predicted == actual) / length(actual)
accuracy


automobile = read.csv("Dataset 5 — Automobile data.csv")
attach(automobile)
automobile = automobile[,-c(2)]
missing_rows = apply(automobile, 1, function(x) any(x == "?"))
automobile = automobile[!missing_rows, ]
automobile$price = as.numeric(automobile$price)
automobile_c = automobile[,c(1,9)]
rownames(automobile_c) = paste(automobile$make, 1:nrow(automobile))

automobile_c$symboling= as.numeric(automobile_c$symboling)
attach(automobile_c)
library(ggplot2)
plot_c1 = ggplot(automobile_c, aes(y=symboling,x=wheel.base))
km.3c1 = kmeans(automobile_c,3)
automobile_c$cluster = as.factor(km.3c1$cluster)
attach(automobile_c)
cluster_plot1 = plot_c1+geom_point(aes(colour=cluster))
cluster_plot1

automobile_d = automobile[,c(1,25)]
rownames(automobile_d) = paste(automobile$make, 1:nrow(automobile))
library(ggplot2)
plot_c2 = ggplot(automobile_d, aes(y=symboling,x=price))
kmprice.3 = kmeans(automobile_d,3)
automobile_d$cluster = as.factor(kmprice.3$cluster)
attach(automobile_d)
cluster_plot2 = plot_c2+geom_point(aes(colour=cluster))
cluster_plot2

averages_by_cluster = aggregate(cbind(wheel.base, symboling) ~ cluster, data = automobile_c, FUN = mean)
averages_by_cluster %>% kable(caption = "Average of Wheel.Base and Symboling by Cluster", booktabs = TRUE)
averages_by_cluster2 = aggregate(cbind(price, symboling) ~ cluster, data = automobile_d, FUN = mean)
averages_by_cluster2 %>% kable(caption = "Average of Price and Symboling by Cluster", booktabs = TRUE)

