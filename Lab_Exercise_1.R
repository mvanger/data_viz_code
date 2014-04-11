# Problem 1
# Set x and y values for each function
x1 = seq(-4,4,.1)
y1 = (sin(x1))
x2 = seq(-2,2,.1)
y2 = (x2^2)
x3.1 = c(-3:0)
y3.1 = c(rep(1,4))
x3.2 = c(0:3)
y3.2 = c(rep(0,4))

# Plot function a
plot(x1,y1,ylim=range(c(y1,y2)),xlim=range(c(-6,6)),main="Question 1", xlab="X Value", ylab="Y Value",type="n")
lines(x1,y1,type="l",col="red")

# Plot function b
par(new=T)
plot(x2,y2,ylim=range(c(y1,y2)),xlim=range(c(-6,6)),main="Question 1", xlab="X Value", ylab="Y Value",type="n")
lines(x2,y2,type="p",col="green")

# Plot function c from -3 to 0
par(new=T)
plot(x3.1,y3.1,ylim=range(c(y1,y2)),xlim=range(c(-6,6)),main="Question 1", xlab="X Value", ylab="Y Value",type="n")
lines(x3.1,y3.1,type="o",col="blue")

# Plot function c from 0 to 3
par(new=T)
plot(x3.2,y3.2,ylim=range(c(y1,y2)),xlim=range(c(-6,6)),main="Question 1", xlab="X Value", ylab="Y Value",type="n")
lines(x3.2,y3.2,type="o",col="blue")

# Add a legend
legend(x=3,y=3,legend=c("function(a)","function(b)","function(c)"),col=c("red","green","blue"),lty=c(1,0,3),pch=c(26,1,1),cex=1)

# Problem 2
# Part A
carsdata<-read.csv("Downloads/04cars data.csv",header=TRUE)
attach(carsdata)
toyotas = grep("Toyota",Vehicle.Name)

d = density(Engine.Size..l.[toyotas])
plot(d,xlab="Engine Size",main="Engine Size of Toyota Vehicles Density Plot")

# Part B
sample.Toyota = carsdata[toyotas,]
x = sample.Toyota[order(sample.Toyota$Engine.Size..l.),]
x$Sports.Car = factor(x$Sports.Car)
x$color[x$Sports.Car==0] = "red"
x$color[x$Sports.Car==1] = "blue"
dotchart(as.numeric(x$Engine.Size..l.),labels=x$Vehicle.Name,cex=.8,groups=x$Sports.Car,color=x$color, main="Toyota Engine Size Vs Vehicle Type", xlab="Engine Size")

# Part C
fords = grep("Ford",Vehicle.Name)
sample.Ford = carsdata[fords,]

sample.Toyota$make = "Toyota"
sample.Ford$make = "Ford"

sample.Toyota$type[sample.Toyota$Small.Sporty..Compact.Large.Sedan==1] = "Sedan"
sample.Toyota$type[sample.Toyota$Sports.Car==1] = "Sports Car"
sample.Toyota$type[is.na(sample.Toyota$type)] = "Other"

sample.Ford$type[sample.Ford$Small.Sporty..Compact.Large.Sedan==1] = "Sedan"
sample.Ford$type[sample.Ford$Sports.Car==1] = "Sports Car"
sample.Ford$type[is.na(sample.Ford$type)] = "Other"

table.Toyota = table(sample.Toyota$make,sample.Toyota$type)
table.Ford = table(sample.Ford$make,sample.Ford$type)
stacked.Bar = rbind(table.Toyota,table.Ford)

barplot(t(stacked.Bar), main="Vehicle Type Distribution among Toyota and Ford",col=c("blue","darkblue","red"),xlab="Vehicle Make",legend=colnames(stacked.Bar),ylab="Number of Vehicles", ylim=c(0,30))

