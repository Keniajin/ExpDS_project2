# 5.How have emissions from motor vehicle sources changed from 1999 -2008 in Baltimore City
library(ggplot2)
library(data.table)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
NEI.SCC <- merge(NEI,SCC, by="SCC",ALL.x=T,ALL.y=F)
names(NEI.SCC)

#subset values with vehicle combustion-related sources in Baltimore
VEHICLE.SCC.baltimore<-data.table(NEI.SCC[grepl("[Vv]ehicle",NEI.SCC$EI.Sector,perl = TRUE,ignore.case=TRUE) & NEI.SCC$fips == "24510",])
VEHICLE.SCC.baltimore$year <- as.factor(VEHICLE.SCC.baltimore$year)
#open a png graphic device
png(filename = "plot5.png", width=480,height=480)
ggplot(VEHICLE.SCC.baltimore, aes(year,Emissions)) + stat_summary(fun.y="sum", geom="bar",position="dodge",fill="brown") +
  ggtitle("Vehicle Emissions across Baltimore") +   ylab("Total Emissions") + xlab("Year of Emisions")
dev.off()
