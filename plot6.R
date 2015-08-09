#
library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
SCC <- tbl_df(readRDS("./data/Source_Classification_Code.rds")) %>% 
    filter(grepl("Mobile -",EI.Sector))
NEI <- tbl_df(readRDS("./data/summarySCC_PM25.rds"))%>%
    filter(fips == "24510" | fips == "06037")


#NEI_SCC <- inner_join(NEI,SCC,by= c("SCC" = "SCC"))

agged_data <- inner_join(NEI,SCC,by= c("SCC" = "SCC"))  %>%
    select (year,fips,Emissions) %>%
    group_by(year,fips)  %>%
    summarize(total_emissions=sum(Emissions)) %>%
    distinct(year,fips,total_emissions)%>%
    mutate(total_emissions= total_emissions)

png(filename = "plot6.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

print(qplot(year,
            total_emissions,
            data=agged_data,
            color= "red",
            facets= . ~ fips,
            geom="line",
            main="Total Emission of PM2.5 by Vehicle sources",
            ylab='Total Emission of PM2.5 in tons',
            xlab='Year'))


dev.off()