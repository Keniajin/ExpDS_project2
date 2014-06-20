#6 Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in
#Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
library(ggplot2)
library(data.table)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
NEI.SCC <- merge(NEI,SCC, by="SCC",ALL.x=T,ALL.y=F)
names(NEI.SCC)
#subset values with motor vehicle sources in Baltimore City and LA,california
VEHICLE.SCC.LB<-data.table(NEI.SCC[grepl("[Vv]ehicle",NEI.SCC$EI.Sector,perl = TRUE,ignore.case=TRUE) & 
                                     (NEI.SCC$fips == "24510"| NEI.SCC$fips == "06037"),])
VEHICLE.SCC.LB$year <- as.factor(VEHICLE.SCC.LB$year)
VEHICLE.SCC.LB$fips_factor <- factor(VEHICLE.SCC.LB$fips,
                                     levels = c("24510","06037"),
                                     labels = c("Baltimore", "LA County, California")) 
#open a graphics device
png(filename = "plot6.png", width=480,height=480)
ggplot(VEHICLE.SCC.LB, aes(year,Emissions,fill=fips_factor)) + stat_summary(fun.y="sum", geom="bar",position="dodge") +
  ggtitle("Vehicle Emissions across Baltimore and LA, California") +   ylab("Total Emissions") + xlab("Year of Emisions by city") +
  guide_legend(title = "Cities")
dev.off()