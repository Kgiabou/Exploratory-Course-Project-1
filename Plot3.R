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

## Plot3 ##

png("Plot3.png", width = 480, height = 480, units = "px")

with(energy2, plot(datetime, Sub_metering_1, type="n",
                   ylab="Energy sub metering", xlab=""))

with(energy2, lines(datetime, Sub_metering_1, col="black"))
with(energy2, lines(datetime, Sub_metering_2, col="red"))
with(energy2, lines(datetime, Sub_metering_3, col="blue"))

legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()