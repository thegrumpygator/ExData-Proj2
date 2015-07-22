# ExData - July 2015
# Brian
# Plot3.R

#Of the four types of sources indicated by the type (point, nonpoint, onroad,
#nonroad) variable, which of these four sources have seen decreases in emissions
#from 1999–2008 for Baltimore City? Which have seen increases in emissions from
#1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Data covers years 1999 -> 2008 --> no reason to subset
# "Pollutant" is always PM25-PRI --> no reason to subset

# Need to subset for Baltimore City (fips = 24510)
NEIBalt <- subset(NEI, fips=="24510")



# Need to aggregate (sum) by year to get one entry per year.
annualPM25 <- aggregate(NEIBalt$Emissions, 
                        by=list(Year=NEIBalt$year, Type=NEIBalt$type), 
                        sum)
names(annualPM25) = c("Year", "Type", "PM25")

# qplot(Year, PM25, data = annualPM25, 
#       geom = c("point", "smooth"), 
#       method = "lm", se = FALSE, 
#       facets = .~Type)


g <- ggplot(aes(Year,PM25), data=annualPM25)
g + geom_point() + 
     geom_smooth(method="lm", se=FALSE) +
     facet_grid(.~Type) +
     labs(title="Annual Baltimore PM2.5 Emissions by Type")