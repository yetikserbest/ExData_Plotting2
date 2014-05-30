## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
## plot answering this question.
# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# do some basic checking of the data
dim(NEI)
dim(SCC)
names(NEI)
names(SCC)
head(NEI)
head(SCC)
# filter the data to get Baltimore only
NEIBaltimore<-NEI[NEI$fips == "24510",]
dim(NEIBaltimore)
head(NEIBaltimore)
# aggregate data per year for Baltimore
totalPollutantPerYearBaltimore<-aggregate(NEIBaltimore$Emissions ~ NEIBaltimore$year,data=NEIBaltimore,sum)
names(totalPollutantPerYearBaltimore)
# change the names of the data frame
names(totalPollutantPerYearBaltimore) <- c("year","TotalPollutant")
totalPollutantPerYearBaltimore
# open a png file for the plot
png(filename="plot2.png")
# plot year vs total Baltimore pollution
plot(totalPollutantPerYearBaltimore$year,totalPollutantPerYearBaltimore$TotalPollutant,type="o",lty=2,ylab=expression("Pollutant " * PM[2.5] * " in tons"),xlab="year", main="Total Pollution - Baltimore, MD")
# close the file
dev.off()
