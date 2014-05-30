## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?
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
# find the codes for combustion related polution
SCCCoalCombustion <- SCC[grepl("combustion", SCC$SCC.Level.One, ignore.case=TRUE) &
        ! grepl("charcoal", SCC$SCC.Level.Three, ignore.case=TRUE) &
        grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE) |
        grepl("lignite", SCC$SCC.Level.Three, ignore.case=TRUE),]
# filter the data to get only combustion related pollution
NEICoalCombustion <- NEI[NEI$SCC %in% SCCCoalCombustion$SCC,]
dim(NEICoalCombustion)
head(NEICoalCombustion)
# aggregate data per year
totalPollutantFromCoal<-aggregate(NEICoalCombustion$Emissions ~ NEICoalCombustion$year,data=NEICoalCombustion,sum)
names(totalPollutantFromCoal)
# change the names of the data frame
names(totalPollutantFromCoal) <- c("year","TotalPollutant")
totalPollutantFromCoal
# load ggplot2
library(ggplot2)
# open a png file for the plot
png(filename="plot4.png")
# create plot object 
g<-ggplot(totalPollutantFromCoal,aes(year,TotalPollutant))
# plot combustion related total pollution per year
print(g+geom_line(linetype=2)+geom_point()+labs(y=expression("Pollutant " * PM[2.5] * " in tons")) + labs(title = "Total Pollution from Coal Combustion - USA"))
# close the file
dev.off()
