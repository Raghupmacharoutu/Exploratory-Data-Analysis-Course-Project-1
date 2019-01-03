# Plot1 in R Programming
library(plyr)
library(dplyr)
library(lubridate)

hh <- read.table("HH.txt", sep = ';', na.strings = c("?", "NA"), header = TRUE)
hh$Date <- parse_date_time(hh$Date, orders= "dmy")
hh$Time <- parse_date_time(hh$Time, orders= "hms")
filterhh <- filter(hh, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))
remove(hh)
png(filename = "./plot1.png", width = 480, height = 480, units = "px")
with(filterhh, hist(as.numeric(Global_active_power), 
                    col='red', main = "Global Active Power",
                    xlab = "Global Active Power (kilowatts)",
                    ylab = "Frequency"))
# Close the device
dev.off()