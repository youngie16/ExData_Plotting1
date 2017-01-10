
# Coursera Exploratory Data Analysis Week 1 Project

# Plot 3 - Linegraph - Daily & Hourly Energy by each sub-meter


# Download and read in data
# some fields have missing data characterised by "?" capture in read statement

library(downloader)
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileurl, temp, mode = "wb")
unzip(temp,exdir = ".")

library(data.table)
pdata.all <- fread("household_power_consumption.txt", na.strings = "?" ,stringsAsFactors = "FALSE")
str(pdata.all)

# extract 2007-02-01 & 2007-02-02 days
# dates in data look like they are in UK order ie day,month, year because extracting as below gives similar frequencies on the histogram

earlyfeb.data <- subset(pdata.all,Date == "1/2/2007" | Date == "2/2/2007")
str(earlyfeb.data)

# extract data and time in Posixct format

earlyfeb.data$DateTime <- paste(earlyfeb.data$Date,earlyfeb.data$Time,sep=" ")
earlyfeb.data$numeric_datetime <- strptime(earlyfeb.data$DateTime, "%d/%m/%Y %H:%M:%S",tz="UTC")
earlyfeb.data$x <- as.POSIXct(earlyfeb.data$DateTime,"%d/%m/%Y %H:%M:%S",tz="UTC")


# open device and write graph to file

png(filename = "plot3.png", width = 480, height = 480)  # width and height requested are default values anyway
with(earlyfeb.data, {
        plot(x,Sub_metering_1, type = "l", ylab = "Energy Sub Metering",xlab="")
        lines(x,Sub_metering_2, type = "l", col = "red",xlab="")
        lines(x,Sub_metering_3, type = "l", col = "blue",xlab="")
        legend("topright",col=c("black","red","blue"),legend=c("Sub-metering_1","Sub_metering_2","sub_metering_3"),lwd=2)
})
dev.off()
