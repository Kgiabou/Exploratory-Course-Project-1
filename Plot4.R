### Unzip the data in the specified directory.
library(tidyverse)
library(lubridate)

data<- unzip("./data/exdata_data_household_power_consumption.zip", files=NULL, exdir = "./data")


energy <- read.table("./data/household_power_consumption.txt", sep=";", header = TRUE,
                     na.strings = "?")

dates <- c("1/2/2007","2/2/2007")
energy2 <- as_tibble(energy[which(energy$Date %in% dates),]) %>%
        mutate(datetime = paste(Date, Time, sep=" ")) %>%
        mutate(datetime = strptime(datetime, format = "%d/%m/%Y %H:%M:%S"))

###Plot 1 ##

png("Plot4.png", width = 480, height = 480, units = "px")

### Plot 4 ###

par(mfrow=c(2,2), mar=c(3,4,3,2), oma=c(2,2,2,2))

### Panel 1
with(energy2, plot(datetime, as.numeric(Global_active_power), type="l",
                   ylab="Global Active Power (kilowatts)", xlab=""))

## Panel 2
with(energy2, plot(datetime, as.numeric(Voltage), type="l",
                   ylab="Global Active Power (kilowatts)"))

## Panel 3
with(energy2, plot(datetime, Sub_metering_1, type="n",
                   ylab="Energy sub metering", xlab=""))

with(energy2, lines(datetime, Sub_metering_1, col="black"))
with(energy2, lines(datetime, Sub_metering_2, col="red"))
with(energy2, lines(datetime, Sub_metering_3, col="blue"))

legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

###Panel 4

with(energy2, plot(datetime, Global_reactive_power, type="l",
                   ylab="Global_reactive_power"))

dev.off()