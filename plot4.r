# Assignment 2 - Question 4.
# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999-2008?
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

combustionRelated <- grepl( "comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl( "coal", SCC$SCC.Level.Four, ignore.case=TRUE)
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[ coalCombustion,] $SCC
combustionNEI <- NEI[ NEI$SCC %in% combustionSCC,]

# Generate Plot

ggplot(combustionNEI,aes(factor(year), Emissions/10^5)) +
  geom_bar( stat="identity", fill="red", width=0.75) +
  theme_bw() + guides(fill=FALSE) +
  labs(x="Year", y=expression("Total PM"[ 2.5] *" Emissions (In Tons)")) +
  labs(title=expression( "Emissions from Coal Combustion for the US" ))

ggsave("plot4.png")