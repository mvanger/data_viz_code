# Question 1A
# Load the library
library(manipulate)
carsdata = read.csv("Downloads/04cars data.csv")
attach(carsdata)
manipulate(
  plot(HP,Retail.Price,xlim=c(x.min,x.max), main="HP vs Retail Price"),
  x.min=slider(0,250),
  x.max=slider(250,500))

# Question 1B
manipulate(
  plot(HP,Retail.Price,xlim=c(0,x.max),ylim=c(10000, y.max), main="HP vs Retail Price"),
  x.max=slider(0,500, initial=500),
  y.max=slider(10000,200000,initial=200000))

# Question 1C
# Get Toyota and Audi groups
toyota = grep("Toyota", Vehicle.Name)
audi = grep("Audi", Vehicle.Name)
# Concatenate them
toyota.audi = c(toyota,audi)
# Plot
manipulate(
  barplot(as.numeric(carsdata[group,"City.MPG"]),as.numeric(carsdata[group,"Vehicle.Name"]), main="City MPG By Car Make", ylab="City MPG"),
  group = picker("Toyota"=toyota,
                 "Audi"=audi,
                 "Mazda"=grep("Mazda", Vehicle.Name),
                 "Toyota and Audi"=toyota.audi)
)

# Question 1D
manipulate(
  plot(as.numeric(City.MPG), Retail.Price, xlim=c(0, x.max),type=type, axes=axes, xlab="City MPG", ylab="Retail Price", main="Retail Price vs City MPG"),
  x.max=slider(5,65,initial=25, step=5, label="x-axis"),
  type = picker("points" = "p", "line" = "l", "step" = "s"),
  axes = checkbox(T, "Draw Axes")
)

# Question 1E
sub = carsdata[1:20,]
library(lattice)
manipulate(
  densityplot(as.numeric(sub[group,"City.MPG"]), xlab="City MPG", main="Density of City MPG", xlim=c(0,x.max)),
  x.max = slider(0,20,initial=20,step=4),
  group = picker("4 Cyl"=which(sub$Cyl==4),
                 "6 Cyl"=which(sub$Cyl==6),
                 "8 Cyl"=which(sub$Cyl==8))
)

# Question 2
library(iplots)
ihist(as.numeric(City.MPG))
library(JGR)
Sys.setenv(NOAWT=1)
Sys.unsetenv("NOAWT")
JGR()
# carsdata = read.csv("Downloads/04cars data.csv")
# attach(carsdata)
# ihist(City.MPG)
# toyota = grep("Toyota", Vehicle.Name)
# audi = grep("Audi", Vehicle.Name)
# mazda = grep("Mazda", Vehicle.Name)
# all = rbind(toyota,audi,mazda)
# iset.select(all)
# Proportion selected
# sum(sign(iset.selected()))/length(City.MPG)

# Question 3A
library(googleVis)
demo(WorldBank)

# Question 3B
# i
cal=gvisCalendar(Cairo, datevar="Date",numvar="Temp",options=list())
plot(cal)

# ii
cal=gvisCalendar(Cairo, datevar="Date",numvar="Temp",options=list(width=1000))
plot(cal)

# iii
cal=gvisCalendar(Cairo, datevar="Date",numvar="Temp",options=list(width=1000, calendar="{yearLabel: {fontSize: 30}}", title="Daily Temperature in Cairo"))
plot(cal)

# Question 3C
# i
timeline = gvisAnnotatedTimeLine(Stock, datevar="Date", numvar="Value", id="Device", titlevar="Title", annotationvar="Annotation", date.format = "%Y/%m/%d", options=list())
plot(timeline)

# ii
timeline = gvisAnnotatedTimeLine(Stock, datevar="Date", numvar="Value", id="Device", titlevar="Title", annotationvar="Annotation", date.format = "%Y/%m/%d", options=list(displayAnnotations=T))
plot(timeline)

# iii
timeline = gvisAnnotatedTimeLine(Stock, datevar="Date", numvar="Value", id="Device", titlevar="Title", annotationvar="Annotation", date.format = "%Y/%m/%d", options=list(displayAnnotations=T, scaleColumns='[0,1]', scaleType='allmaximized'))
plot(timeline)