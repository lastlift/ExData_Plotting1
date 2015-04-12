
## read in the data
dataIn <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?")

## load required library(s)
library(lubridate)

## create a sub-settable column
dataIn$plottime <- dmy_hms(paste(dataIn$Date, dataIn$Time))

## get the subset
chartData <- dataIn[(dataIn$plottime >= as.POSIXct("2007-02-01", tz="UTC") & dataIn$plottime < as.POSIXct("2007-02-03", tz ="UTC")), ]

## create the chart
with (chartData, {

   plot(plottime, Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab="" )
   r <- as.POSIXct(round(range(plottime), "days"))
   axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
})

## copy to png
dev.copy(png, file="plot2.png", width=480, height=480, units="px")

## turn off the device
dev.off()
