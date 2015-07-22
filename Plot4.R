# ExData - July 2015
# Brian
# Plot4.R

# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Data covers years 1999 -> 2008 --> no reason to subset
# "Pollutant" is always PM25-PRI --> no reason to subset

# Need to subset SCC for "coal combustion" sources
SCC_coal <- subset(SCC, grepl("Comb", Short.Name) 
     & (grepl("Coal", Short.Name) | grepl("Coal", Short.Name)))

# use SCC column from coal subset to then subset NEI
NEI_coal<-NEI[NEI$SCC %in% SCC_coal$SCC, ]

# Need to aggregate (sum) by year to get one entry per year.
annualPM25 <- aggregate(NEI_coal$Emissions, by=list(NEI_coal$year), sum)
names(annualPM25) = c("year", "PM25")

barplot(annualPM25$PM25, names.arg=annualPM25$year, 
        xlab="Year", ylab="PM25", space=.5, 
        main="Yearly Total of U.S. Coal-Based PM2.5 Emissions")
