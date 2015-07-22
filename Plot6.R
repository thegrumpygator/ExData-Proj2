# ExData - July 2015
# Brian
# Plot6.R

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips ==
# "06037"). Which city has seen greater changes over time in motor vehicle
# emissions?


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Data covers years 1999 -> 2008 --> no reason to subset
# "Pollutant" is always PM25-PRI --> no reason to subset

# Need to subset SCC for "motor vehicle" sources
SCC_mv <- subset(SCC, Data.Category == "Onroad")

NEI2 <- subset(NEI, fips=="24510"|fips=="06037")
NEI2_mv <- NEI2[NEI2$SCC %in% SCC_mv$SCC, ]
annualPM25 <- aggregate(NEI2_mv$Emissions, by=list(NEI2_mv$year, NEI2_mv$fips), sum)
annualPM25 <- cbind(annualPM25, 
                    c("LA", "LA","LA","LA", 
                      "Baltimore City", "Baltimore City","Baltimore City","Baltimore City"))
names(annualPM25) = c("Year", "fips", "PM25", "City")


g <- ggplot(annualPM25, aes(Year, PM25))
g2 <- g + geom_point(aes(color = City), size = 9) +
     labs(title = "Yearly Total Motor Vehicle PM2.5 Emissions") +
     geom_smooth(aes(group = City), method = "lm", se = FALSE)
print(g2)