# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)
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
#subset for Baltimore only
data.BC <- NEI[NEI$fips == "24510",]
data.BC$year <- as.factor(data.BC$year )
data.BC$type <- as.factor(data.BC$type )
str(data.BC)
# ggplot(data.BC, aes(year,Emissions,fill=type)) + geom_bar(stat="identity",position="dodge") 
# total.Emission.BC <- summaryBy(Emissions~year+type, data= data.BC, FUN=function(x)
#   c(count=sum(x)))
# ggplot(total.Emission.BC, aes(year,Emissions.count,fill=type)) + geom_bar(stat="identity",position="dodge") 
#open a png graphics deveice
png(filename = "plot3.png", width=480,height=480)
ggplot(data.BC, aes(year,Emissions,fill=type)) + stat_summary(fun.y="sum", geom="bar",position="dodge") + ggtitle("Emissions by  types of sources") +
  ylab("Total Emissions") + xlab("Year of Emisions by type")
dev.off()
