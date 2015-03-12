# Assignment 2 - Question 5.
# How have emissions from motor vehicle sources changed 
# from 1999-2008 in Baltimore City? 
# Load libraries
library("ggplot2")

# Load datasets as needed
# This data set will likely take a few seconds. Be patient!

loaded <- (exists("NEI") && is.data.frame(get("NEI")))
if (!loaded) {
  print ("Loading NEI .. Please be patient! ")
  NEI <- readRDS("summarySCC_PM25.rds")
}
loaded <- (exists("SCC") && is.data.frame(get("SCC")))
if (!loaded) {
  print ("Loading SCC dataset .. Please be patient! ")
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Summarize Data

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[ vehicles,] $SCC
vehiclesNEI <- NEI[ NEI$SCC %in% vehiclesSCC,]
baltimoreVehiclesNEI <- vehiclesNEI[ vehiclesNEI$fips==24510,]

# Generate Plot

ggplot(baltimoreVehiclesNEI,aes(factor(year), Emissions)) +
  geom_bar( stat="identity", fill="red", width=0.75) +
  theme_bw() + guides(fill=FALSE) +
  labs(x="Year", y=expression("Total PM"[ 2.5] *" Emission (Tons)")) +
  labs(title=expression("PM"[ 2.5] *" Motor Vehicle Source Emissions in Baltimore"))
ggsave("plot5.png")
