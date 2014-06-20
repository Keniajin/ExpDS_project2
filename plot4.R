#Across the United States, how have emissions from 
#coal combustion-related sources changed from 1999–2008?
library(ggplot2)
library(data.table)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#merge the datasets by SCC
NEI.SCC <- merge(NEI,SCC, by="SCC",ALL.x=T,ALL.y=F)
names(NEI.SCC)
#subset the coal combustion-related sources
COAL.SCC<-data.table(NEI.SCC[grepl("[Cc]oal",NEI.SCC$EI.Sector,perl = TRUE,ignore.case=TRUE),])
COAL.SCC$year <- as.factor(COAL.SCC$year)
#open a png graphic device
png(filename = "plot4.png", width=480,height=480)
ggplot(COAL.SCC, aes(year,Emissions,fill=type)) + stat_summary(fun.y="sum", geom="bar",position="dodge") + ggtitle("Coal Emissions across USA") +
  ylab("Total Emissions") + xlab("Year of Emisions by type")
dev.off()
