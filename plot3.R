#
library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

agged_data <-   NEI %>%
    filter(NEI$fips == "24510") %>%
    select (year,type,Emissions) %>%
    group_by(year,type)  %>%
    summarize(total_emissions=sum(Emissions)) %>%
    distinct(year,type,total_emissions)

png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
   type = c("windows", "cairo", "cairo-png"))

print(qplot(year,
            total_emissions,
            data=agged_data,
            color= type,
            geom="line",
            main="Total Emission of PM2.5 in Baltimore by pollution type",
            ylab='Total Emission of PM2.5 in tons',
            xlab='Year'))

dev.off()