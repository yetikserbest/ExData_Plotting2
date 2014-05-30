## Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). Which city has seen greater changes over time in 
## motor vehicle emissions?
# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# do some basic data checking
dim(NEI)
dim(SCC)
names(NEI)
names(SCC)
head(NEI)
head(SCC)
# fileter the data for Baltimore
NEIBaltimore<-NEI[NEI$fips == "24510",]
dim(NEIBaltimore)
head(NEIBaltimore)
# filter the data for Los Angeles
NEILosAngeles<-NEI[NEI$fips == "06037",]
dim(NEILosAngeles)
head(NEILosAngeles)
# filter Baltimore data for on-road pollution
NEIBaltimoreMotor <- NEIBaltimore[NEIBaltimore$type == "ON-ROAD",]
dim(NEIBaltimoreMotor)
head(NEIBaltimoreMotor)
# aggregate Baltimore on-road data per year
totalPollutantFromMotorBaltimore<-aggregate(NEIBaltimoreMotor$Emissions ~ NEIBaltimoreMotor$year,data=NEIBaltimoreMotor,sum)
names(totalPollutantFromMotorBaltimore)
# add a city column to the Baltimore data
totalPollutantFromMotorBaltimore <- cbind(totalPollutantFromMotorBaltimore,rep("Baltimore",length(totalPollutantFromMotorBaltimore)))
# change the names of the data frame
names(totalPollutantFromMotorBaltimore) <- c("year","TotalPollutant","city")
totalPollutantFromMotorBaltimore
# fileter Los Angeles data for on-road pollution
NEILosAngelesMotor <- NEILosAngeles[NEILosAngeles$type == "ON-ROAD",]
dim(NEILosAngelesMotor)
head(NEILosAngelesMotor)
# aggregate Los Angeles on-roasd data for year
totalPollutantFromMotorLosAngeles<-aggregate(NEILosAngelesMotor$Emissions ~ NEILosAngelesMotor$year,data=NEILosAngelesMotor,sum)
names(totalPollutantFromMotorLosAngeles)
# add a city column to the Los Angeles data
totalPollutantFromMotorLosAngeles <- cbind(totalPollutantFromMotorLosAngeles,rep("LosAngeles",length(totalPollutantFromMotorLosAngeles)))
# change the names of the data frame
names(totalPollutantFromMotorLosAngeles) <- c("year","TotalPollutant","city")
totalPollutantFromMotorLosAngeles
# combine Baltimore and Los Angeles data frame into one data frame
totalPollutantFromMotorLABaltimore <- rbind(totalPollutantFromMotorBaltimore,totalPollutantFromMotorLosAngeles)
# load ggplot2
library(ggplot2)
png(filename="plot6.png")
# create plot object 
g<-ggplot(totalPollutantFromMotorLABaltimore,aes(year,TotalPollutant))
# plot two panels one for each city for year vs on-road total pollution
print(g+geom_line(linetype=2)+facet_grid(city~.,scales="free")+geom_point()+labs(y=expression("Pollutant " * PM[2.5] * " in tons")) + labs(title = "Total Pollution from Motor Vehicles - Los Angeles vs Baltimore"))
# close the file
dev.off()
