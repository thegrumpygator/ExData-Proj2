# ExData - July 2015
# Brian
# Plot2.R

## This first line will likely take a few seconds. Be patient!
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# Data covers years 1999 -> 2008 --> no reason to subset
# "Pollutant" is always PM25-PRI --> no reason to subset

# Need to subset for Baltimore City (fips = 24510)
NEIBalt <- subset(NEI, fips=="24510")

# Need to aggregate (sum) by year to get one entry per year.
annualPM25 <- aggregate(NEIBalt$Emissions, by=list(NEIBalt$year), sum)
names(annualPM25) = c("year", "PM25")

barplot(annualPM25$PM25, names.arg=annualPM25$year, 
        xlab="Year", ylab="PM25", space=.5, 
        main="Baltimore City, MD Yearly Total PM25 Emissions")