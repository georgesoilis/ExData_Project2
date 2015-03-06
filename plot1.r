# Assignment 2 - Question 1.
#
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#
# Using the base plotting system, make a plot showing the total PM2.5 emission from
# all sources for each of the years 1999, 2002, 2005, and 2008.
#

# Load datasets as needed
loaded <- (exists("NEI") && is.data.frame(get("NEI")))
if (!loaded) {
  print ("Loading NEI dataset .. Please stand by")
  NEI <- readRDS("summarySCC_PM25.rds")
}

loaded <- (exists("SCC") && is.data.frame(get("SCC")))

if (!loaded) {
  print ("Loading SCC dataset .. Please stand by")
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Summarize Data

print ("Aggregating Data Totals .. Please stand by")
aggrTotals <- with(NEI, aggregate(Emissions, by = list(year), sum) )

# Generate Plot

png(filename = "plot1.png", width = 480, height = 480, units = "px")

plot(aggrTotals, type = "b", pch = 18, col = "red", 
     xlab = "Year", ylab = "Emissions", main = "United States PM2.5 Emissions")

dev.off()