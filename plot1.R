require(doBy)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
#view the 
head(NEI)
names(NEI)
head(SCC)
names(SCC)
str(SCC)
str(NEI)
SCC$SCC <- as.factor(SCC$SCC)
#SCC.NEI <- merge(x=NEI,y=SCC2,by.x =SCC,by.y = SCC,all=T)
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission
#from all sources for each of the years 1999, 2002, 2005, and 2008.

#a table of all the years
table(NEI$year)

#data for the total emissions for all the years
total.Emission <- summaryBy(Emissions~year, data=NEI, FUN=function(x)
  c(count=sum(x)))
data <- tapply(NEI$Emissions, list(NEI$year), sum)
barplot(data,main="Total emissions from PM2.5",xlab="Years",ylab="Total Emissions")
dev.copy(png, file = "plot1.png" ,width = 480, height = 480)  ## Copy my plot to a plot1.PNG file
dev.off()
