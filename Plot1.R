library(tidyverse)
library(lubridate)

## Import the data
energy <- read.table("./data/household_power_consumption.txt", sep=";", header = TRUE,
                     na.strings = "?")

## Set the dates we will use for our plots
dates <- c("1/2/2007","2/2/2007")

## Subset our data to the dates specified. Convert character variables 
## to date/ time variables.

energy2 <- as_tibble(energy[which(energy$Date %in% dates),]) %>%
        mutate(datetime = paste(Date, Time, sep=" ")) %>%
        mutate(datetime = strptime(datetime, format = "%d/%m/%Y %H:%M:%S"))

## Plot 1 ##

png("Plot1.png", width = 480, height = 480, units = "px")
with(energy2, hist(as.numeric(Global_active_power), col="red", main="Global Active Power",
                   xlab="Global Active Power (kilowatts)"))
dev.off()
