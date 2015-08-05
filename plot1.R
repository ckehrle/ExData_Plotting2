#
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

agged_data <-   NEI                     %>%
                select (year,Emissions) %>%
                group_by(year)  %>%
                summarize(total_emissions=sum(Emissions)) %>%
                distinct(year,total_emissions) %>%
                mutate(total_emissions= total_emissions/1000)
                

png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

plot(agged_data,
     type="l",
     col="black",
     ylab="Total Emissions US (in kilotons)",
     xlab='Year',
     ylim=c(0,8000)
     )
dev.off()