#
library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
SCC <- tbl_df(readRDS("./data/Source_Classification_Code.rds")) %>% 
       filter(grepl("Comb",EI.Sector) & any(grepl("Coal",EI.Sector)))
NEI <- tbl_df(readRDS("./data/summarySCC_PM25.rds"))


#NEI_SCC <- inner_join(NEI,SCC,by= c("SCC" = "SCC"))

agged_data <- inner_join(NEI,SCC,by= c("SCC" = "SCC"))  %>%
    select (year,Emissions) %>%
    group_by(year)  %>%
    summarize(total_emissions=sum(Emissions)) %>%
    distinct(year,total_emissions)%>%
    mutate(total_emissions= total_emissions/1000)

png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

plot(agged_data,
     type="l",
     col="black",
     main="US Coal-combustion related Emission from 1999-2008",
     ylab="Total Emissions (in kilotons)",
     xlab='Year',
     ylim=c(0,2000)
)

dev.off()