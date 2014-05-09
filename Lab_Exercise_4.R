carsdata<-read.csv("Downloads/04cars data.csv",header=TRUE,na.strings=c("","*","NA"))
attach(carsdata)
library(ggplot2)

# Question 1A
qplot(HP,Retail.Price, data = carsdata, geom = c("point", "smooth"),main="Retail Price VS HorsePower", formula=y~poly(x,2), method="lm")

# Question 1B
cyls = subset(carsdata, Cyl > 3 & Cyl < 9 & Cyl != 5)

cyls$Cyl.Levels <- factor(cyls$Cyl,levels=c(4,6,8),
                              labels=c("4","6", "8")) 

ggplot(cyls[], aes(x=HP, y=Retail.Price, color=Cyl.Levels)) + geom_point(point=0) + geom_smooth(method=lm, fullrange=T, level=0) 

# Question 1C
ggplot(cyls[], aes(x=Cyl.Levels, y=City.MPG, color=Cyl.Levels)) + geom_boxplot()

# Question 1D
ggplot(cyls[], aes(x=Cyl.Levels, y=City.MPG, shape=factor(Sports.Car), color=factor(Sports.Car))) + geom_boxplot()

# Question 1E
ggplot(carsdata[], aes(x=City.MPG, color=factor(Sports.Car), alpha=0.5)) + geom_histogram()

# Question 1F
ggplot(carsdata[], aes(x=Hwy.MPG)) + stat_density() + geom_vline(xintercept=mean(na.omit(Hwy.MPG)), linetype="longdash", color="blue") + geom_vline(xintercept=mean(na.omit(City.MPG)), color="red")

# Question 2
library(plyr)
library(rgeos)
library(maptools)
library(sp)
library(rgdal)

# A
nepal<-read.csv("nepal.csv",header=TRUE,na.strings=c("","*","NA"))
str(nepal)

np_dist <- readShapeSpatial("NPL_admin/NPL_adm3.shp")
np_dist <- fortify(np_dist, region = "NAME_3")

np_dist$id <- toupper(np_dist$id)
ggplot() + geom_map(data = nepal, aes(map_id = District, fill = PASS.PERCENT), map = np_dist) + expand_limits(x = np_dist$long, y = np_dist$lat)

distrpassave <- ddply(nepal, .(District), summarize, PassMean = mean(PASS.PERCENT))
ggplot() + geom_map(data = distrpassave, aes(map_id = District, fill = PassMean), map = np_dist) + expand_limits(x = np_dist$long, y = np_dist$lat)

# B
ggplot() + geom_map(data = distrpassave, aes(map_id = District, fill = PassMean), map = np_dist) + expand_limits(x = np_dist$long, y = np_dist$lat) + scale_fill_gradient2(low="red", mid="white", high="blue", midpoint=50)