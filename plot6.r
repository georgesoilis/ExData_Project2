# Assignment 2 - Question 6.
#
# Compare emissions from motor vehicle sources in
#   Baltimore City (fips == "24510")
# with emissions from motor vehicle sources in 
#   Los Angeles County, California (fips == "06037"). 
#

# Load datasets as needed
# This data set will likely take a few seconds. Be patient!

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

NEIbaltimore  <- NEI[which(NEI$fips == "24510") , ]
NEIlosAngeles <- NEI[which(NEI$fips == "06037") , ]

NEIbaltimore$city  <- "Baltimore City"
NEIlosAngeles$city <- "Los Angeles County"

combinedNEI <- rbind(NEIbaltimore, NEIlosAngeles)

# Generate Plot

ggplot(combinedNEI, aes( x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year), stat="identity") +
  facet_grid(scales="free", space="free", . ~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="Year", y=expression( "Total PM"[ 2.5] *" Emission (In Kilo-Tons) ")) +
  labs(title=expression("Compairson of PM"[ 2.5] *" Motor Vehicle Emissions"))

ggsave("plot6.png")