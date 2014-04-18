# Read the data set
carsdata<-read.csv("Downloads/04cars data.csv",header=TRUE,na.strings=c("","*","NA"))
# Subset columns 8 through 19
sub = carsdata[,8:19]
# Load the corrgram library
library(corrgram)

# Question 1A
corrgram(sub, order=F, lower.panel=panel.shade, upper.panel=NULL, text.panel=panel.txt, main="Correlation diagram for Car Data Set")

# Question 1B
corrgram(sub, order=T, lower.panel=panel.shade, upper.panel=panel.pie, text.panel=panel.txt, main="Correlation diagram for Car Data Set", col.regions=colorRampPalette(c("darkgoldenrod4", "burlywood1", "darkkhaki", "darkgreen")))

# Question 2A
# Set x values
x = seq(0,10,length=500)
# Get exponential distribution with rate = 3
x.exp= dexp(x, rate=3, log=F)
# Plot it
plot(x,x.exp,xlim=c(0,10), ylim=c(0,3.5),col="blue",pch=16,ylab="Value", main="Probability Distributions")
par(new=T)
# Get chi sq distribution with one degree of freedom
x.chisq = dchisq(x, df=1, log=F)
# Plot it
plot(x,x.chisq,xlim=c(0,10), ylim=c(0,3.5),col="red",pch=15,ylab="Value", main="Probability Distributions")
# Add a legend
legend(x=6,y=3.5,legend=c("Exponential, Rate=3","Chi-Sq, df=1"),col=c("blue","red"),pch=c(16,15),cex=1)

# Question 2B
# 1000 exponential random variables
x = rexp(1000, rate=3)
# 1000 chi sq random variables
y = rchisq(1000, df=1, ncp=0)
# QQ Plot
qqplot(y,x,main="QQ plot",xlab="Chi Sq",ylab="Exponential")
# Add QQ line
qqline(x,y)

# Question 2C
# Make the QQ Line appear 45 degrees by changing the axes
qqplot(y,x,main="QQ plot",xlab="Chi Sq",ylab="Exponential",xlim=c(0,10),ylim=c(0,20))
qqline(x,y)

# Question 3A
# Subset on Retail Price
cars.cheap = carsdata[carsdata$Retail.Price < 50000,]
# Factorize Horsepower
cuts = cut(cars.cheap$HP, 4)
# Combine new factor
cars.cuts = cbind(cars.cheap, cuts)
library(lattice)

# Make Boxplots
bwplot(~cars.cuts$Retail.Price|cars.cuts$cuts, main="Price by Horsepower", xlab="Retail Price ($)")

# Question 3B
# Cut on Retail Price
price.cuts = cut(carsdata$Retail.Price, 4)
# Combine dataset and cuts
cars.price.cuts = cbind(carsdata, price.cuts)
# Plot the scatterplots
xyplot(cars.price.cuts$City.MPG~cars.price.cuts$HP|cars.price.cuts$price.cuts, main="MPG vs Horsepower, by Retail Price", xlab="Horsepower", ylab="MPG")