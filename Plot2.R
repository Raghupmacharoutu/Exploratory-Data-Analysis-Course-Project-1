# Plot2 in R Programming
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
png(filename = "./plot2.png", width = 480, height = 480, units = "px")
with(filterhh, plot(datetime, Global_active_power, type='l', xlab = ' ' , ylab = 'Global Active Power(Kilowatts)'))
# Close the device
dev.off()
