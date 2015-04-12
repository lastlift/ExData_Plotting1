
## read in the data
dataIn <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?")

## load required library(s)
library(lubridate)

## create a sub-settable column
dataIn$plottime <- dmy_hms(paste(dataIn$Date, dataIn$Time))

## get the subset
chartData <- dataIn[(dataIn$plottime >= as.POSIXct("2007-02-01", tz="UTC") & dataIn$plottime < as.POSIXct("2007-02-03", tz ="UTC")), ]

## setup device for 4x4 chart
par(mfrow = c(2, 2), oma = c(0, 0.75, 0, 0.75), cex.axis=0.85, cex.main=0.5)

## create the 4 charts
with (chartData, {

    ## --plot 1
    plot(plottime, Global_active_power, type="l", ylab = "Global Active Power", xlab="" )
    r <- as.POSIXct(round(range(plottime), "days"))
    axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
})

with (chartData, {

    ## --plot 2
    plot(plottime, Voltage, type="l", ylab = "Voltage", xlab="datetime" )
    r <- as.POSIXct(round(range(plottime), "days"))
    axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
})

with (chartData, {

    ## --plot 3
    plot(plottime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="" )
    r <- as.POSIXct(round(range(plottime), "days"))
    axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
    points(plottime,Sub_metering_2, col="red", type="l", pch=as.integer(NA))
    points(plottime,Sub_metering_3, col="blue", type="l", pch=as.integer(NA))
    legend("topright", pch = as.integer(NA), lty=1, cex=.75, xjust=0.5, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

with (chartData, {

    ## --plot 4
    plot(plottime, Global_reactive_power, axes=FALSE, type="l", ylab = "Global_reactive_power", xlab="datetime")
    r <- as.POSIXct(round(range(plottime), "days"))
    axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
    axis(2, at=seq(0.0, 0.5, by=0.1), labels=c("0.0","0.1","0.2","0.3","0.4","0.5"))
    box()
})

## copy to png
dev.copy(png, file="plot4.png", width=480, height=480, units="px")

## turn off the device
dev.off()
