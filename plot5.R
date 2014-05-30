## How have emissions from motor vehicle sources changed from 1999–2008 
## in Baltimore City? 
# load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# do some basic data checking
dim(NEI)
dim(SCC)
names(NEI)
names(SCC)
head(NEI)
head(SCC)
# filter the data for Baltimore only
NEIBaltimore<-NEI[NEI$fips == "24510",]
dim(NEIBaltimore)
head(NEIBaltimore)
# filter the data to get motor vehicle realted pollution, on-road type
NEIBaltimoreMotor <- NEIBaltimore[NEIBaltimore$type == "ON-ROAD",]
dim(NEIBaltimoreMotor)
head(NEIBaltimoreMotor)
# aggregate the data per year vs total on-road pollution
totalPollutantFromMotorBaltimore<-aggregate(NEIBaltimoreMotor$Emissions ~ NEIBaltimoreMotor$year,data=NEIBaltimoreMotor,sum)
names(totalPollutantFromMotorBaltimore)
# change the names of the data frame
names(totalPollutantFromMotorBaltimore) <- c("year","TotalPollutant")
totalPollutantFromMotorBaltimore
# load ggplot2
library(ggplot2)
# open png file for the plot
png(filename="plot5.png")
# create plot object for year vs total pollution
g<-ggplot(totalPollutantFromMotorBaltimore,aes(year,TotalPollutant))
# print tthe plot of total on-road pollution vs year for Baltimore
print(g+geom_line(linetype=2)+geom_point()+labs(y=expression("Pollutant " * PM[2.5] * " in tons")) + labs(title = "Total Pollution from Motor Vehicles - Baltimore, MD"))
# close the file
dev.off()
