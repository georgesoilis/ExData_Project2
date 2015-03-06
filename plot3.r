# Course 4 - Assignment 2 - Question 3.
#
# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which 
# of these four sources have seen decreases in emissions
# from 1999-2008 for Baltimore City? Which have seen 
# increases in emissions from 1999-2008? 
#
# Use the ggplot2 plotting system to make a plot answer this question.
#
# Load Libraries
library(plyr)
library(ggplot2)

## Load datasets as needed
## This data set will likely take a few seconds. Be patient!

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

print ("Subsetting & Aggregating Data Totals .. Please stand by")

NEI.subset <- NEI[which(NEI$fips == "24510") , ]

baltimore.type <- ddply(NEI.subset, . (type, year) ,
                        summarize, Emissions = sum(Emissions) )

baltimore.type$Pollutant_Type <- baltimore.type$type

# Generate Plot

qplot(year, Emissions, data = baltimore.type,
      group = Pollutant_Type, color = Pollutant_Type,
      geom = c("point", "line") , 
      xlab = "Year", ylab = expression("Total Emissions, PM"[2.5] ) ,
      main = "Total Emissions in Baltimore by Type of Pollutant")

ggsave("plot3.png")
