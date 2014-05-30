## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all 
## sources for each of the years 1999, 2002, 2005, and 2008.
# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# do some initial data checking
dim(NEI)
dim(SCC)
names(NEI)
names(SCC)
head(NEI)
head(SCC)
# Aggregate emission data per year
totalPollutantPerYear<-aggregate(NEI$Emissions ~ NEI$year,data=NEI,sum)
names(totalPollutantPerYear)
# change the names
names(totalPollutantPerYear) <- c("year","TotalPollutant")
totalPollutantPerYear
# open a png file for the plot
png(filename="plot1.png")
# plot year vs total pollutant
plot(totalPollutantPerYear$year,totalPollutantPerYear$TotalPollutant,type="o",lty=2,ylab=expression("Pollutant " * PM[2.5] * " in tons"),xlab="year", main="Total Pollution - USA")
# close the file
dev.off()
