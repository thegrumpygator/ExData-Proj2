# ExData - July 2015
# Brian
# Plot4.R

# How have emissions from motor vehicle sources changed from 1999–2008 
# in Baltimore City? 

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Data covers years 1999 -> 2008 --> no reason to subset
# "Pollutant" is always PM25-PRI --> no reason to subset

# Need to subset for Baltimore City (fips = 24510)
NEIBalt <- subset(NEI, fips=="24510")

# Need to subset SCC for "motor vehicle" sources
SCC_mv <- subset(SCC, Data.Category == "Onroad")

# SCC_coal <- subset(SCC, grepl("Comb", Short.Name) 
#      & (grepl("Coal", Short.Name) | grepl("Coal", Short.Name)))

# use SCC column from mv subset to then subset NEIBalt
NEIBalt_mv <- NEIBalt[NEIBalt$SCC %in% SCC_mv$SCC, ]

# Need to aggregate (sum) by year to get one entry per year.
annualPM25 <- aggregate(NEIBalt_mv$Emissions, by=list(NEIBalt_mv$year), sum)
names(annualPM25) = c("year", "PM25")

barplot(annualPM25$PM25, names.arg=annualPM25$year, 
        xlab="Year", ylab="PM25", space=.5, 
        main="Yearly Total of Baltimore City Motor Vehicle PM2.5 Emissions")
