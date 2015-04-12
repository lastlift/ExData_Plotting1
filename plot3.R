
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

    plot(plottime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="" )
    r <- as.POSIXct(round(range(plottime), "days"))
    axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
    points(plottime,Sub_metering_2, col="red", type="l", pch=as.integer(NA))
    points(plottime,Sub_metering_3, col="blue", type="l", pch=as.integer(NA))
    legend("topright", pch = as.integer(NA), lty=1, cex=.75, xjust=0.5, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

## copy to png
dev.copy(png, file="plot3.png", width=480, height=480, units="px")

## turn off the device
dev.off()
