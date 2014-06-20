#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
library(doBy)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
#view the details of the data 
head(NEI)
names(NEI)
head(SCC)
names(SCC)
str(SCC)
str(NEI)
SCC$SCC <- as.factor(SCC$SCC)
#subset data for Baltimore only
data.BC <- NEI[NEI$fips == "24510",]
list.BC <- tapply(data.BC$Emissions, list(data.BC$year), sum)
barplot(list.BC,main="Total emissions from PM2.5 in Baltimore City",xlab="Years",ylab="Total Emissions")
dev.copy(png, file = "plot2.png" ,width = 480, height = 480)  ## Copy my plot to a plot2.PNG file
dev.off()