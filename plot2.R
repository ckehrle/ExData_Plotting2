#
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

agged_data <-   NEI %>%
                    filter(NEI$fips == "24510") %>%
                    select (year,Emissions) %>%
                    group_by(year)  %>%
                    summarize(total_emissions=sum(Emissions)) %>%
                    distinct(year,total_emissions)


png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

plot(agged_data,
     type="l",
     col="black",
     main="Total Emissions over years for Baltimore",
     ylab="Total Emissions (in tons)",
     xlab='Year',
     ylim=c(0,4000)
)
dev.off()