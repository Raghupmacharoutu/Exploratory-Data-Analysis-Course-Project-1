# Plot4 in R Programming
library(plyr)
library(dplyr)
library(lubridate)
library(plotrix)

hh <- read.table("HH.txt", sep = ';', na.strings = c("?", "NA"), header = TRUE)
hh$Date <- parse_date_time(hh$Date, orders= "dmy")
hh$Time <- parse_date_time(hh$Time, orders= "hms")
filterhh <- filter(hh, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))
remove(hh)
datefield <- strftime(filterhh$Date, format = "%Y-%m-%d", tz="UTC")
timefield <- strftime(filterhh$Time, format = "%H:%M:%S", tz="UTC")
filterhh$datetime <- as.POSIXct(paste(datefield, timefield), tz ="UTC")

# make 4 plots
# opens a png graphic device 
png(filename = "./plot4.png", width = 480, height = 480, units = "px")

# set graphical parameters for multiple plots
par(mfrow=c(2,2), mar= c(4,4,2,1), oma=c(0,0,2,0))
# plots the data
with(filterhh, 
     plot(datetime, Global_active_power, 
          type="l", 
          xlab = "",
          ylab = "Global Active Power")
)
with(filterhh, 
     plot(datetime, Voltage, 
          type="l", 
          xlab = "datetime",
          ylab = "Voltage")
)
with(filterhh, 
     plot(datetime, Sub_metering_1, 
          type="l", 
          xlab = "",
          ylab = "Energy sub metering ")
)
with(filterhh, lines(datetime, Sub_metering_2, col="red"))
with(filterhh, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", pch="__", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_mertering_3"))
with(filterhh, 
     plot(datetime, Global_reactive_power, 
          type="l", 
          xlab = "datetime",
          ylab = "Global_reactive_power")
)
#close the device
dev.off()