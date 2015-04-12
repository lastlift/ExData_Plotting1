
## read in the data
dataIn <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?")

## load required library(s)
library(lubridate)

## create a sub-settable column
dataIn$plottime <- dmy_hms(paste(dataIn$Date, dataIn$Time))

## get the subset
chartData <- dataIn[(dataIn$plottime >= as.POSIXct("2007-02-01", tz="UTC") & dataIn$plottime < as.POSIXct("2007-02-03", tz ="UTC")), ]

## weekday factor for charting
chartData$weekday<-factor(wday(dmy(chartData$Date), label=TRUE))

## create the chart
hist(chartData$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")

## copy to png
dev.copy(png, file="plot1.png", width=480, height=480, units="px")

## turn off the device
dev.off()
