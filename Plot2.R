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

## Plot2 ##

png("Plot2.png", width = 480, height = 480, units = "px")
with(energy2, plot(datetime, Global_active_power, type="l",
                   ylab="Global Active Power (kilowatts)", xlab=""))

dev.off()