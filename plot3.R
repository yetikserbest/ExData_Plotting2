## Of the four types of sources indicated by the type (point, nonpoint, 
## onroad, nonroad) variable, which of these four sources have seen decreases 
## in emissions from 1999–2008 for Baltimore City? Which have seen increases 
## in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
## answer this question.
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
# fileter the data to get only Baltimore
NEIBaltimore<-NEI[NEI$fips == "24510",]
dim(NEIBaltimore)
head(NEIBaltimore)
# aggregate data per year and per pollutant type
totalPollutantPerTypePerYearBaltimore<-aggregate(NEIBaltimore$Emissions ~ NEIBaltimore$year + NEIBaltimore$type,data=NEIBaltimore,sum)
names(totalPollutantPerTypePerYearBaltimore)
# change the names of the data frame
names(totalPollutantPerTypePerYearBaltimore) <- c("year","type","TotalPollutant")
totalPollutantPerTypePerYearBaltimore
# load ggplot2 
library(ggplot2)
# open a png file for the plot
png(filename="plot3.png")
# create plot object
g<-ggplot(totalPollutantPerTypePerYearBaltimore,aes(year,TotalPollutant))
# create two plot panel one for each pollutant type
print(g+geom_line(linetype=2)+facet_grid(type~., scales="free")+geom_point()+labs(y=expression("Pollutant " * PM[2.5] * " in tons")) + labs(title = "Total Pollution Per Type - Baltimore, MD"))
# close the file
dev.off()
