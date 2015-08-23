#
library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
SCC <- tbl_df(readRDS("./data/Source_Classification_Code.rds")) %>% 
    filter(grepl("Mobile -",EI.Sector))
NEI <- tbl_df(readRDS("./data/summarySCC_PM25.rds"))%>%
    filter(fips == "24510" | fips == "06037")


NEI_SCC <- inner_join(NEI,SCC,by = c("SCC" = "SCC"))

agged_data <- NEI_SCC  %>%
    select (year,fips,Emissions) %>%
    group_by(fips,year)  %>%
    summarize(total_emissions=sum(Emissions)) %>%
    distinct(year,fips,total_emissions)%>%
    mutate(total_emissions_delta=abs(total_emissions -lag(total_emissions))) %>%
    mutate(location=ifelse(fips == "24510","Baltimore City","Los Angeles County"))    

    
png(filename = "plot6.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

print(qplot(total_emissions_delta ,
            data=agged_data))

dev.off()